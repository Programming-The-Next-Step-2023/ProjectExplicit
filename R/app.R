#
# This is a Shiny web application. You can run the application by clicking

#devtools::load_all()
#' @import shiny tidyverse bslib


#' @export
App_UI <- function() {
  ui <- fluidPage(
  #titlePanel("ProjectExplicit"),
  theme = bslib::bs_theme(bg = "#1F1D21",
                   #17212E
                   fg = "#ebebec",
                   secondary = "#bc0031",
                   primary="#E4CCC0",
                   base_font = bslib::font_google("Prompt"),
                   code_font = bslib::font_google("JetBrains Mono")
                   ),
  navbarPage("ProjectExplicit",
             tabPanel("About",
                             mainPanel(includeMarkdown("inst/about.md"))),
             navbarMenu("Experiments",
                               tabPanel("Stroop",
                                               fluidRow(column(6,
                                                 "This is a classic Stroop Task.", br(),
                                                 "It serves to measure your attentional control", br(), br(),
                                                 "In this task you will see colored words and your task is to respond to the color of the font, while ignoring the meaning of the word.", br(),
                                                 "The tasks takes approximately 5 minutes to complete."),
                                                 column(6,
                                                 actionButton("start_stroop", "Start Experiment"))),
                                          tableOutput("table")),
                               tabPanel("Stroop Deadline",
                                               fluidRow(column(6,
                                                 "This is a novel version of a classic Stroop Task.", br(),
                                                 "It serves to measure your attentional control", br(), br(),
                                                 "The Deadline version of the task means that the task gets more
                                                 or less difficult depending on your performance", br(),
                                                 "The task takes approximately 5 minutes to complete."),
                                                 column(6,
                                                 actionButton("start_sdl", "Start Experiment"))),
                                 ),
                               tabPanel("Digit Span Task",
                                 fluidRow(column(6,
                                                 "This is a classic Backwards Digit Span Task.", br(),
                                                 "It serves to measure your working memory capacity", br(), br(),
                                                 "In the task, you need to memorize and recall digits in the backwards order.", br(),
                                                 "The task takes approximately 5 minutes to complete."),
                                                 column(6,
                                                 actionButton("start_digit", "Start Experiment")))),
                               tabPanel("VMAC Task",
                                               fluidRow(column(6,
                                                 "This is a Value-Driven Attentional Capture Task.", br(),
                                                 "It serves to measure your attentional bias towards rewards", br(), br(),
                                                 "In the task, you need to respond to a dot inside of a unique shape.", br(),
                                                 "The task takes approximately 10 minutes to complete."),
                                                 column(6,
                                                 actionButton("start_vmac", "Start Experiment")))),
             ),
             navbarMenu("Questionnaires",
                        tabPanel("Alcohol Use",
                                 lapply(1:8, function(i) {
                                   build_questionnaire(i, "AUDIT_part1")
                                   }),
                                 lapply(9:10, function(i) {
                                   build_questionnaire(i, "AUDIT_part2")
                                   }),
                                 ),
                        tabPanel("Depression Symptoms",
                                 lapply(1:21, function(i) {
                                   build_questionnaire(i, "DASS")
                                 }))),
             tabPanel("Your Results"),
  ),

  htmlOutput("experiment"),
  DT::dataTableOutput("sample_table")
  )
}


#' @export
App_server <- function(input, output) {
  #start the Stroop experiment Action Button:
  observeEvent(input$start_stroop, {
    output$experiment <- renderUI({
      return(includeHTML("inst/Stroop/experiment/index.html"))
      })
    })
  #start the StroopDeadline experiment Action Button:
  observeEvent(input$start_sdl, {
    output$experiment <- renderUI({
      return(includeHTML("inst/SDL/experiment/index.html"))
      })
    })
  #start the Digit Span Action button:
  observeEvent(input$start_digit, {
    output$experiment <- renderUI({
      return(includeHTML("inst/Digit_span/index.html"))
      })
    })

  observeEvent(input$stroop_results, {
      data <- jsonlite::fromJSON(input$stroop_results)
      file_name <- paste("data/", data$uniqueSubID[1], "_stroop_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = file_name)
      })
  observeEvent(input$sdl_results, {
      data <- jsonlite::fromJSON(input$sdl_results)
      file_name <- paste("data/", data$uniqueSubID[2], "_sdl_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = file_name)
    })
  observeEvent(input$digit_results, {
      data <- jsonlite::fromJSON(input$digit_results)
      file_name <- paste("data/", data$uniqueSubID[2], "_digit_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = file_name)
    })
  observeEvent(input$vmac_results, {
      data <- jsonlite::fromJSON(input$vmac_results)
      data <- as.matrix(data)
      file_name <- paste("data/", data$uniqueSubID[1], "_vmac_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = file_name)
    })
    # df <- eventReactive(input$jspsych_results, {
    #   jsonlite::fromJSON(input$jspsych_results)
    # })
    #
    # print(df$rt[1]) #switch to ID and then paste into datafile name so it doesn't overwrite
    # write.csv(data, file = "C:/Users/mrkon/Documents/Experiments_Public_Github/ProjectExplicit/R/experiments/Stroop/data/test_outcomes.csv")



}


# Run the application
#' Title
#'
#' @return starts the app
#' @export
#shinyApp(ui = ui, server = server)
startApp <- function() {
  shinyApp(ui = App_UI, server = App_server)
}
#C:/Users/mrkon/Documents/R/win-library/4.1/ProjectExplicit
