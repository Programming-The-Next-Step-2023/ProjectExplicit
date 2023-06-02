#
# This is a Shiny web application. You can run the application by clicking

#' @import shiny tidyverse bslib


#' @title ProjectExplicit App UI
#' @description Creates UI for the App.
#' @returns A UI variable.
#' @details For use within RShiny.
#' @keywords internal
#' @export

App_UI <- function() {
  ui <- fluidPage(
    theme = bslib::bs_theme(
      bg = "#1F1D21",
      fg = "#ebebec",
      secondary = "#bc0031",
      primary = "#E4CCC0",
      base_font = bslib::font_google("Prompt"),
      code_font = bslib::font_google("JetBrains Mono")
    ),
    navbarPage(
      "ProjectExplicit", id = "inTabset",
      tabPanel("About", value = "about_tab",
               mainPanel(includeMarkdown("inst/about.md")),
               sidebarPanel("Note: For best experience Select Stroop Deadline Task",
                            br(),
                            "Digit Span, VMAC and Classic Stroop Task are for fun only.")),
      navbarMenu("Experiments",
                 tabPanel("Classic Stroop", value = "stroop_tab",
                          fluidRow(column(6, includeMarkdown("inst/stroop.md")),
                                   column(6, actionButton("start_stroop", "Start Experiment"),
                                          align = "center", style = "margin-top: 100px;"))),
                 tabPanel("Stroop Deadline", value = "sdl_tab",
                          fluidRow(column(6, includeMarkdown("inst/sdl.md")),
                                   column(6, actionButton("start_sdl", "Start Experiment"),
                                          align = "center", style = "margin-top: 100px;"))),
                 tabPanel("Digit Span Task", value = "digit_tab",
                          fluidRow(column(6, includeMarkdown("inst/digit.md")),
                                   column(6, actionButton("start_digit", "Start Experiment"),
                                          align = "center", style = "margin-top: 100px;"))),
                 tabPanel("VMAC Task", value = "vmac_tab",
                          fluidRow(column(6, includeMarkdown("inst/vmac.md")),
                                   column(6, actionButton("start_vmac", "Start Experiment"),
                                          align = "center", style = "margin-top: 100px;")))
      ),
      navbarMenu("Questionnaires",
                 tabPanel("Alcohol Use", value = "audit_tab",
                          lapply(1:8, function(i) {
                            build_questionnaire(i, "AUDIT_part1")
                          }),
                          lapply(9:10, function(i) {
                            build_questionnaire(i, "AUDIT_part2")
                          }),
                          actionButton("submit_audit", "Submit")),
                 tabPanel("Depression Symptoms", value = "dass_tab",
                          lapply(1:21, function(i) {
                            build_questionnaire(i, "DASS")
                          }),
                          actionButton("submit_dass", "Submit"))),
      tabPanel("Your Results", value = "results_tab",
               DT::dataTableOutput("sample_table"),
               plotOutput("AUDIT")),
    ),

    htmlOutput("experiment"),
  )
}

#' @title ProjectExplicit App Server
#' @description Creates server for the App.
#' @details For use within RShiny.
#' @keywords internal
#' @export

App_server <- function(input, output, session) {
  ## Start Experiments ----
  #start the Stroop experiment Action Button:
  observeEvent(input$start_stroop, {
    output$experiment <- renderUI({
      return(includeHTML("inst/Stroop/index.html"))
    })
  })

  #start StroopDeadline Action Button:
  observeEvent(input$start_sdl, {
    output$experiment <- renderUI({
      return(includeHTML("inst/SDL/index.html"))
    })
  })
  #start Digit Span Action button:
  observeEvent(input$start_digit, {
    output$experiment <- renderUI({
      return(includeHTML("inst/Digit_span/index.html"))
    })
  })

  #start VMAC Action button:
  observeEvent(input$start_vmac, {
    output$experiment <- renderUI({
      return(includeHTML("inst/VMAC_final/index.html"))
    })
  })

  ## Get Experiment Data ----
  #Retrieve Data upon task completion:
  observeEvent(input$stroop_results, {
    data <- jsonlite::fromJSON(input$stroop_results)
    file_name <- paste("data/userdata/", data$uniqueSubID[1], "_stroop_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
    write.csv(data, file = file_name)
  })
  observeEvent(input$sdl_results, {
    data <- jsonlite::fromJSON(input$sdl_results)
    file_name <- paste("data/userdata/", data$uniqueSubID[2], "_sdl_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
    write.csv(data, file = file_name)
  })
  observeEvent(input$digit_results, {
    data <- jsonlite::fromJSON(input$digit_results)
    file_name <- paste("data/userdata/", data$uniqueSubID[2], "_digit_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
    write.csv(data, file = file_name)
  })
  observeEvent(input$vmac_results, {
    data <- jsonlite::fromJSON(input$vmac_results)
    data <- as.matrix(data)
    file_name <- paste("data/userdata/", data$uniqueSubID[1], "_vmac_outcomes.csv", sep = "") #switch to ID and then paste into datafile name so it doesn't overwrite
    write.csv(data, file = file_name)
  })
  ## Save Questionnaire Data ----
  #only save once clicked Submit button
  observeEvent(input$submit_audit, {
    audit_data <- c(
      input$AUDIT_Q1, input$AUDIT_Q2, input$AUDIT_Q3, input$AUDIT_Q4, input$AUDIT_Q5,
      input$AUDIT_Q6, input$AUDIT_Q7, input$AUDIT_Q8, input$AUDIT_Q9, input$AUDIT_Q10)
    audit_outcome <- sum(as.numeric(audit_data[[2]]))
    write.csv(audit_data, file = "data/userdata/audit_outcome.csv")
    updateTabsetPanel(session, "inTabset",
                      selected = "results_tab")
  })
  observeEvent(input$submit_dass, {
    dass_data <- c(
      input$DASS_Q1, input$DASS_Q2, input$DASS_Q3, input$DASS_Q4, input$DASS_Q5,
      input$DASS_Q6, input$DASS_Q7, input$DASS_Q8, input$DASS_Q9, input$DASS_Q10,
      input$DASS_Q11, input$DASS_Q12, input$DASS_Q13, input$DASS_Q14,
      input$DASS_Q15, input$DASS_Q16, input$DASS_Q17, input$DASS_Q18,
      input$DASS_Q19, input$DASS_Q20, input$DASS_Q21)
    dass_outcome <- sum(as.numeric(dass_data[[2]]))
    write.csv(dass_data, file = "data/userdata/dass_outcome.csv")
    updateTabsetPanel(session, "inTabset",
                      selected = "results_tab")
  })

  output$AUDIT <- renderPlot({
    audit_data <- c(
      input$AUDIT_Q1, input$AUDIT_Q2, input$AUDIT_Q3, input$AUDIT_Q4, input$AUDIT_Q5,
      input$AUDIT_Q6, input$AUDIT_Q7, input$AUDIT_Q8, input$AUDIT_Q9, input$AUDIT_Q10)
    audit_plot()
  })

}


#' @title Run the ProjectExplicit App
#' @description Starts the App.
#' @details
#' For best experience open in browser,
#' although the app works in RStudio pop-up window too.
#' @return Starts the app
#' @export

start_App <- function() {
  shinyApp(ui = App_UI, server = App_server)
}
