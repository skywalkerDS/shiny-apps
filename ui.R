library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Storm!  Storm Hits!"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", ticks=TRUE,
                  "View top damaging weather events:",
                  min = 1,
                  max = 50,
                  value = c(1,10)),
      radioButtons("damageHit", "And their damage to:",
                   c("Human" = "human",
                     "Property" = "property")),
      hr(),
      h6('Description'),
      p("US NOAA - National Oceanic and Atmospheric Administration data is used to review weather events and their damage from 1950 to 2011."),
      p("Human injuries and deaths are accumulated counts and property damage is USD in million."),
      h6('Usage'),
      p("For a simple shiny app like this, there is no other document needed -- simply select the range of top damaging events, select the harm type, you will see the results."),
      br(),
      code('Powered by package "shiny"'),
      br(),
      br(),
      img(src = "noaa.png", height = 72, width = 72),
      "Data Source:  ", 
      span("NOAA", style = "color:blue")
    ),

    # Show a plot of the generated distribution
    mainPanel(
         h5(textOutput("titlePlot"), align = "center"),
         plotOutput("histPlot"),
         hr()
    )
    
    
    
  )
))