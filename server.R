#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
     suppressWarnings(library(ggplot2))
     model1 <- lm(mpg~am, data = mtcars)
     model2 <- lm(mpg~wt, data = mtcars)
     model3 <- lm(mpg~wt+am, data = mtcars)



     model1pred <- reactive({
         amInput <- input$sliderAm
         predict(model1, newdata = data.frame(am = amInput))
     })
     model2pred <- reactive({
         wtInput <- input$sliderWt
         predict(model2, newdata = data.frame(wt = wtInput))
     })

     model3pred <- reactive({
         amInput <- input$sliderAm
         wtInput <- input$sliderWt
         predict(model3, newdata = data.frame(am = amInput, wt = wtInput))
     })

     output$plot1 <- renderPlot({
         choiceInput <- input$radio
         if(choiceInput==1){
             theme_update(plot.title = element_text(hjust = 0.5))
             plot(x=mtcars$am,y=mtcars$mpg,xlab = "Transmission",ylab = "MPG",main = "MPG vs Transmission")
             abline(model1, col = "red", lwd = 2)
             legend("topright",title = "Transmission Legend", pch = 1, legend = c("0 - Auto","1 - Manual"))
         }
         else if(choiceInput==2){
             theme_update(plot.title = element_text(hjust = 0.5))
             plot(x=mtcars$wt,y=mtcars$mpg,xlab = "Weight",ylab = "MPG",main = "MPG vs Weight")
             abline(model2, col = "blue", lwd = 2)
             legend("topright",title = "Weight in 1000lbs", pch = 1, legend = "")
         }else {
             theme_update(plot.title = element_text(hjust = 0.5))
             mtcars$amText <- factor(ifelse(mtcars$am==0,1,0),labels = c("Auto","Manual"))
             ggplot(mtcars,aes(x=wt,y=mpg,fill = amText))+
                 geom_boxplot()+
                 ggtitle("MPG vs Transmission & Weight")+
                 geom_smooth(method = "lm", se=FALSE, color="green",lwd = 2, aes(group=1))
         }
     })
     ?mtcars
     output$pred1 <- renderText({
         model1pred()
     })

     output$pred2 <- renderText({
         model2pred()
     })
     output$pred3 <- renderText({
         model3pred()
     })
})
