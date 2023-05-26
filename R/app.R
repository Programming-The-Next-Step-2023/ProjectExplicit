#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#'@import shiny tidyverse

# library(shiny)
# library(jsonlite)

ui <- fluidPage(
  #titlePanel("ProjectExplicit"),
  navbarPage("ProjectExplicit",
             tabPanel("About"),
             navbarMenu("Experiments",
                        tabPanel("Stroop",
                                 "This is a classic Stroop Task. It serves to measure your attentional contol",
                                 actionButton("start_stroop", "Start Experiment")),
                        tabPanel("Digit Span Task",
                                 "This is a classic Digit Span Task. It serves to measure your working memory capacity",
                                 actionButton("start_digit", "Start Experiment"))
                        ),
             navbarMenu("Questionnaires",
                        tabPanel("Alcohol Use"),
                        tabPanel("Depression Symptoms")),
             tabPanel("Your Results"),
  ),
  # selectInput(inputId = "start_exp",
  #             label = "Choose Experiment",
  #             choices = list(choose = "",
  #                            Stroop = "experiments/Stroop/experiment/index.html",
  #                            SDL = "experiments/SDL_final/experiment/index.html",
  #                            VMAC = "experiments/VMAC_final/experiment/index.html"),
  #             ),
  # fileInput('target_upload', 'Choose file to upload',
  #           accept = c(
  #             'text/csv',
  #             'text/comma-separated-values',
  #             '.csv'
  #           )),
  htmlOutput("experiment"),
  DT::dataTableOutput("sample_table")
)

#  ----- server.R -----

server <- function(input, output) {

    # output$experiment<-renderUI({
    #   return(includeHTML(input$start_exp))
    # })

    #start the Stroop experiment Action Button:
    observeEvent(input$start_stroop, {
      output$experiment <- renderUI({
        return(includeHTML("experiments/Stroop/experiment/index.html"))
        })
      })

    #start the Digit Span Action button:
    observeEvent(input$start_digit, {
      output$experiment <- renderUI({
        return(includeHTML("experiments/Stroop/experiment/index.html"))
      })
    })
#
#     df_products_upload <- reactive({
#       inFile <- input$target_upload
#       if (is.null(inFile))
#         return(NULL)
#       df <- read.csv(inFile$datapath, header = TRUE)
#       return(df)
#     })

    # jspsych_data_upload <- reactive({
    #   answers <- input$jspsych_results
    #   if (is.null(answers))
    #     return(NULL)
    #   data <- jsonlite::fromJSON(answers)
    #   return(data)
    # })
    #answers <- input$jspsych_results
    #return(answers)
    #data <- jspsych_data_upload()

    observeEvent(input$jspsych_results, {
      data <- jsonlite::fromJSON(input$jspsych_results)
      print(data$rt[1]) #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = "C:/Users/mrkon/Documents/Experiments_Public_Github/ProjectExplicit/R/experiments/Stroop/data/test_outcomes.csv")
      })

    # output$sample_table<- DT::renderDataTable({
    #   #df <- df_products_upload()
    #   DT::datatable(data)
    # })
}


# Run the application
#' Title
#'
#' @return
#' @export
#shinyApp(ui = ui, server = server)
startApp <- function() {
  shinyApp(ui = ui, server = server)
}
#C:/Users/mrkon/Documents/R/win-library/4.1/ProjectExplicit
