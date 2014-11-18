library(shiny)
library(ggplot2)
library(scales)

stormDMG <- read.csv("storm-damage.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

     output$titlePlot <- renderText({
          if (input$bins[1]==1) 
               topString <- paste("Top", input$bins[2])
          else
               topString <- paste("Top", input$bins[1],"-", input$bins[2])
          
          if (input$damageHit == "human") 
               paste(topString, "Weather Events Harming Human (1950-2011)", sep=" ")
          else
               paste(topString, "Weather Events Hurting Economy (1950-2011)", sep=" ")
          
     })
     output$histPlot <- renderPlot({
          if (input$damageHit == "human") {
               ord<-order(stormDMG$HDMG,decreasing=T)
               ord<-ord[input$bins[1]:input$bins[2]]
               stormHDMG <- stormDMG[ord,]
               
               stormHDMG$EVTYPE <- factor(stormHDMG$EVTYPE, levels = rev(stormHDMG$EVTYPE), ordered = TRUE)
               ggplot(stormHDMG, aes(x=EVTYPE, y=HDMG, label=HDMG)) +
                    geom_bar(stat='identity',position=position_dodge(), colour="black", fill='darkred', width=0.5) + 
                    coord_flip() + geom_text(size=3, hjust=-1) + 
                    ylab('Total Human Injuries and Deaths') + xlab('Event') + 
                    scale_y_continuous(labels = comma)
          }
          else {
               ord<-order(stormDMG$PDMG,decreasing=T)
               ord<-ord[input$bins[1]:input$bins[2]]
               stormPDMG <- stormDMG[ord,]
               
               stormPDMG$EVTYPE <- factor(stormPDMG$EVTYPE, levels = rev(stormPDMG$EVTYPE), ordered = TRUE)
               ggplot(stormPDMG, aes(x=EVTYPE, y=PDMG, label=PDMG)) +
                    geom_bar(stat='identity',position=position_dodge(), colour="black", fill='red', width=0.5) + 
                    coord_flip() + 
                    ylab('Total Property Damage (Million USD)') + xlab('Event') +
                    scale_y_continuous(labels = dollar) + 
                    theme(axis.text.x = element_text(angle = 45, hjust = 1))
          }
     })
})

# Deployment: install.packages('devtools')
# devtools::install_github('rstudio/shinyapps')
# shinyapps::setAccountInfo(name='skywalkerds', token='...', secret='...')
# library(shinyapps)
# setwd("C:/Users/rqin/Desktop/BigD/R-Train")
# shinyapps::deployApp('storm-app')