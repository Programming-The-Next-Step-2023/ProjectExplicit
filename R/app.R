#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
  titlePanel("ProjectExplicit"),
  selectInput(inputId = "start_exp",
              label = "Choose Experiment", 
              choices = list(choose = "", Stroop = "experiments/Stroop/experiment/index.html", test1 = "http://www.google.com"),
              ),
  fileInput('target_upload', 'Choose file to upload',
            accept = c(
              'text/csv',
              'text/comma-separated-values',
              '.csv'
            )),
  htmlOutput("experiment"),
  DT::dataTableOutput("sample_table")
)

#  ----- server.R -----

server <- function(input, output) {
  
  # getPage<-function() {
  #   return(includeHTML("Stroop/experiment/index.html"))
  # }
    output$experiment<-renderUI({
      return(includeHTML(input$start_exp))
    })
    
    df_products_upload <- reactive({
      inFile <- input$target_upload
      if (is.null(inFile))
        return(NULL)
      df <- read.csv(inFile$datapath, header = TRUE)
      return(df)
    })
    
    output$sample_table<- DT::renderDataTable({
      df <- df_products_upload()
      DT::datatable(df)
    })
}


# Run the application 
shinyApp(ui = ui, server = server)