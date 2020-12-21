library(shiny)
library(shinyWidgets)
library(ngram)
library(stringr)


shinyUI(fluidPage(

    titlePanel("Word Prediction Application"),

    sidebarLayout(
        sidebarPanel(
            textAreaInput("text","Type something", width = "100%",resize = "vertical"),
            prettyRadioButtons("check","Choose the number of predicted texts",choices = c("One","Two"),selected = "One",animation="smooth")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Prediction Text",htmlOutput("sent1"),htmlOutput("sent2"),htmlOutput("sent3")),
                tabPanel("User Guide",textOutput("guide"))
            )
        )
    )
))
