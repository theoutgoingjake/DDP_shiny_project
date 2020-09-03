library(shiny)
library(dplyr)

data_url <- "https://covidtracking.com/data/download/all-states-history.csv"
if(!file.exists("c19data.csv")) {download.file(data_url, destfile = "c19data.csv")}
cd <- read.csv("c19data.csv")

theme_custom <- function(){
    
    theme_classic() %+replace% 
        
        theme(axis.text.x = element_text(face = "bold", size = 12),
              axis.text.y = element_text(face = "bold", size = 12),
              axis.title.x = element_text(face = "bold", size = 14),
              axis.title.y = element_text(face = "bold", size = 14, angle=90),
              legend.text = element_text(face = "bold", size = 14, colour="black"),
              legend.title = element_text(size = 12, colour = "black")
        )
}

cdv <- cd %>% 
    select(date, state, death, hospitalized, negative, positive, recovered) %>% 
    mutate(date=ymd(date))

dead <- cdv %>% select(date, state, death) %>% na.omit()
hospitalized <- cdv %>% select(date, state, hospitalized) %>% na.omit()
negative <- cdv %>% select(date, state, negative) %>% na.omit()
positive <- cdv %>% select(date, state, positive) %>% na.omit()
recovered <- cdv %>% select(date, state, recovered) %>% na.omit()

shinyServer(function(input, output) {
    
    base <- reactive({get(input$data)})
    output$graph <- renderPlot({
        mydata <- base()
        if(input$usa==" TOTAL") {
            tdata <- aggregate(mydata[,3], by=list(mydata[,1]), sum)
            ggplot(as.data.frame(tdata), aes(x=Group.1, y=x)) + 
                geom_col(width=1) +
                ggtitle("Total COVID-19 data for USA states and territories") +
                scale_x_date(date_labels="%b %y",date_breaks  ="1 month") +
                xlab("date") + ylab(input$data) +
                theme_custom()
            
        } else {
        
        mydata %>%
        filter(state==input$usa) %>%
        ggplot(aes_string(names(mydata)[1], names(mydata)[3])) + 
               geom_col(width=1) +
               ggtitle("COVID-19 data for USA states and territories") +
               scale_x_date(date_labels="%b %y",date_breaks  ="1 month") +
               theme_custom()}
        
    })
    
    output$summary <- renderPrint({
        mydata <- base()
        if(input$usa==" TOTAL") {
            tdata <- aggregate(mydata[,3], by=list(mydata[,1]), sum)
            names(tdata) <- c("", input$data)
            summary(tdata[2])
        } else {
        mydata %>%
            filter(state==input$usa) %>%
            summary()}
        
    
    })
        
})


