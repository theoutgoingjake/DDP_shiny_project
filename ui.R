#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("USA COVID-19 Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h5("Select the type of COVID-19 outcome and the state or territory you are interested in. Choose TOTAL for the aggregate
               USA data. A plot and summary statistics are available by choosing either tab."),
            selectInput("data", h4("select data"),
                        choices=c("deaths"="dead", "hospitalizations"="hospitalized", "positive tests"="positive", 
                                  "negative tests"="negative", "recoveries"="recovered")),
            selectInput("usa", h4("select state"),
                        choices=sort(c(" TOTAL","Wyoming"="WY", "Nebraska"="NE", "North Dakota"="ND", "North Carolina"="NC", 
                                       "New Hampshire"="NH", "Northern Mariana Islands"="MP", "Missouri"="MO", "Minnesota"="MN", 
                                       "Michigan"="MI", "Maine"="ME", "New Jersey"="NJ", "Maryland"="MD", "New Mexico"="NM", 
                                       "Massachusetts"="MA", "Nevada"="NV", "Louisiana"="LA", "New York"="NY", "Kentucky"="KY",
                                       "Ohio"="OH", "Kansas"="KS", "Oklahoma"="OK", "Indiana"="IN", "Oregon"="OR", "Illinois"="IL",
                                       "Pennsylvania"="PA", "Idaho"="ID", "Puerto Rico"="PR", "Iowa"="IA", "Rhode Island"="RI",
                                       "Hawaii"="HI", "South Carolina"="SC", "Guam"="GU", "South Dakota"="SD", "Georgia"="GA",
                                       "Tennessee"="TN", "Florida"="FL", "Texas"="TX", "Delaware"="DE", "Utah"="UT","Montana"="MT",
                                       "District of Columbia"="DC", "Virginia"="VA", "Connecticut"="CT", "Virgin Islands"="VI",
                                       "Colorado"="CO", "Vermont"="VT", "California"="CA", "Washington"="WA", "Arizona"="AZ",
                                       "Wisconsin"="WI", "American Samoa"="AS", "West Virginia"="WV", "Arkansas"="AR",
                                       "Mississippi"="MS", "Alabama"="AL", "Alaska"="AK")))),
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", 
                    plotOutput("graph")),
                tabPanel("Summary", 
                    verbatimTextOutput("summary")),
                    p(a("Data downloaded from https://covidtracking.com/", href="https://covidtracking.com/"))
                
        )
    )
)))
