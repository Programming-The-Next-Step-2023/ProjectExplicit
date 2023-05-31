#
# This is a Shiny web application. You can run the application by clicking


#'@import shiny tidyverse bslib

# library(shiny)
# library(jsonlite)

ui <- fluidPage(
  #titlePanel("ProjectExplicit"),
  theme = bs_theme(bg = "#1F1D21",
                   #17212E
                   fg = "#ebebec",
                   secondary = "#bc0031",
                   primary="#E4CCC0",
                   base_font = font_google("Prompt"),
                   code_font = font_google("JetBrains Mono")
                   ),
  navbarPage("ProjectExplicit",
             tabPanel("About",
                      mainPanel(includeMarkdown("about.md"))),
             navbarMenu("Experiments",
                        tabPanel("Stroop",
                                 fluidRow(column(6,
                                                 "This is a classic Stroop Task", br(),
                                                 "It serves to measure your attentional control"),
                                          column(6,
                                                 actionButton("start_stroop", "Start Experiment")))),
                        tabPanel("Digit Span Task",
                                 fluidRow(column(6,
                                                 "This is a classic Digit Span Task.", br(),
                                                 "It serves to measure your working memory capacity"),
                                          column(6,
                                                 actionButton("start_digit", "Start Experiment")))),
             ),
             navbarMenu("Questionnaires",
                        tabPanel("Alcohol Use",
                                 radioButtons("Q1", "How often do you have a drink containing alcohol?",
                                              c("0","1", "2","3","4"), choiceValues=c(0,1,2,3,4))),
                        tabPanel("Depression Symptoms")),
             tabPanel("Your Results"),
  ),

  htmlOutput("experiment"),
  DT::dataTableOutput("sample_table")
)

#  ----- server.R -----

server <- function(input, output) {

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

    observeEvent(input$jspsych_results, {
      data <- jsonlite::fromJSON(input$jspsych_results)
      print(data$rt[1]) #switch to ID and then paste into datafile name so it doesn't overwrite
      write.csv(data, file = "C:/Users/mrkon/Documents/Experiments_Public_Github/ProjectExplicit/R/experiments/Stroop/data/test_outcomes.csv")
      })
}


# Run the application
#' Title
#'
#' @return
#' @export
shinyApp(ui = ui, server = server)
# startApp <- function() {
#   shinyApp(ui = ui, server = server)
# }
#C:/Users/mrkon/Documents/R/win-library/4.1/ProjectExplicit
