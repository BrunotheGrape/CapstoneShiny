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
  titlePanel("Word Predictions"),
  sidebarLayout(
  sidebarPanel(
    
    p("This app will predict the next word in a phrase. Enter a
  phrase in the space below and click on Submit. Give the app 
      a few seconds to process. Your results will appear in the 
      main panel. You will see a list of six numbered words in 
      descending order of likelihood."),
              textInput("txt1","Enter phrase", value = "", width = '400px'),
              submitButton("Submit")),
  
            mainPanel(
              textOutput("txt2")
        ))


    ))

