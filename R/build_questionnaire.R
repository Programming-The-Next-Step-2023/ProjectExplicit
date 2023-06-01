
#' @title Generates a Questionnaire for Rshiny
#' @description
#'  Loads the Questionnaires from the data/ package folder.
#'
#' @param i variable that will be looped through in a for loop, or within lapply() function.
#' @param quest character. Which Questionnaire the function should generate.
#' @returns A Questionnaire with Radio buttons for RShiny implementation.
#' @details Use only within RShiny. See an example of shiny implementation below.
#'
#' @note Only to be used within RShiny, specifically within a lapply function.
#'
#' @examples
#' ui <- fluidPage(
#'         lapply(1:8, function(i) {
#'           build_questionnaire(i, "AUDIT_part1")
#'           }),
#'         lapply(9:10, function(i) {
#'           build_questionnaire(i, "AUDIT_part2")
#'           })
#'        )
#'
#'
#' @keywords internal
#'
#' @export


build_questionnaire <- function(i, quest) {
  if (quest == "AUDIT_part1" ) {
    inputId <- paste("AUDIT", rownames(AUDIT)[i], sep="_")
    label <- AUDIT$Question[i]
    choices <- as.character(AUDIT[i, 2:6])
    shiny::radioButtons(inputId = inputId, label = label,
                 choiceNames = choices, selected=character(0), choiceValues=c(0,1,2,3,4))
  }
  else if (quest == "AUDIT_part2") {
    inputId <- paste("AUDIT", rownames(AUDIT)[i], sep="_")
    label <- AUDIT$Question[i]
    choices <- as.character(AUDIT[i, 2:4])
    shiny::radioButtons(inputId = inputId, label = label,
                 choiceNames = choices, selected=character(0), choiceValues=c(0,2,4))
  }
  else if (quest == "DASS") {
    inputId <- paste("DASS", rownames(DASS)[i], sep="_")
    label <- DASS$Question[i]
    choices <- as.character(DASS[i, 2:5])
    shiny::radioButtons(inputId = inputId, label = label,
                        choiceNames = choices, selected=character(0), choiceValues=c(0,1,2,3))
  }
}

