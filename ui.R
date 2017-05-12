#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Predict MPG using either displacement or weight of car or both"),
    sidebarLayout(
        sidebarPanel(
            br(),br(),br(),
            radioButtons("radio",h4("Select the predictors needed"),choices = c("Choice 1 - only transmission"=1, "Choice 2 - only weight"=2, "Choice 3 - both"=3)),
            submitButton(text = "Click to Plot"),
            br(),
            br(),
            br(),
            br(),
            br(),
            sliderInput("sliderAm", "Transmission of the car?", 0, 1, value = 0),
            sliderInput("sliderWt", "Weight of the car?", 1.5, 5.5, value = 2.0),
            submitButton(text = "Click to Predict")
        ),
        mainPanel(
            plotOutput("plot1"),
            h4("Predicted MPG for given transmission from Choice 1:"),
            textOutput("pred1"),
            h4("Predicted MPG for given weight from Choice 2:"),
            textOutput("pred2"),
            h4("Predicted MPG for given weight and transmission from Choice 3:"),
            textOutput("pred3")
        )
    )
))
