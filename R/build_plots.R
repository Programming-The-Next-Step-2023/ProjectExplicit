# General Population data ------------------------------------------------------------
### Show plots based on previous data collected

#' @title Generates an Alcohol Use plot
#' @description
#'  Generates ggplot with AUDIT Questionnaire scores of the general population
#'  and the users own score.
#'
#' @returns A plot for RShiny implementation.
#'
#' @keywords internal
#'
#' @export

build_plot <- function(plot) {
  data <- read.csv("data/general_data.csv")

  if(plot == "AUDIT") {
    ggplot_audit <- ggplot(data, aes(x = AUDIT)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)",
           title = "Alcohol Use") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            plot.title = element_text(size=14,
                                      color="#ebebec"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if (file.exists("data/userdata/audit_outcome.csv")) {
      your_data <- read.csv("data/userdata/audit_outcome.csv")
      your_outcome <- sum(as.numeric(your_data[[2]]))
      ggplot_audit <- ggplot_audit +
        geom_vline(aes(xintercept=your_outcome), color = "#E4CCC0") +
        annotate(geom = "text",
                 x = your_outcome-1.5, y = 25,
                 label = "Your Score",
                 color = "#E4CCC0",
                 size = 3.5)
      plotly::ggplotly(ggplot_audit)
    } else {
      shiny::showNotification(
        "No data found for Depression & Anxiety Questionnaire.
        Please make sure to finish the Questionnaire first.
        The task can be found under Questionnaire Menu Tab.")
      plotly::ggplotly(ggplot_audit)
    }

  } else if(plot == "DASS") {
    ggplot_dass <- ggplot(data, aes(x = DASS)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)",
           title = "Depression, Anxiety and Stress Symptoms") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            plot.title = element_text(size=14,
                                      color="#ebebec"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if (file.exists("data/userdata/dass_outcome.csv")) {
      your_data <- read.csv("data/userdata/dass_outcome.csv")
      your_outcome <- sum(as.numeric(your_data[[2]]))
      ggplot_dass <- ggplot_dass +
        geom_vline(aes(xintercept=your_outcome), color = "#E4CCC0") +
        annotate(geom = "text",
                 x = your_outcome-10.5, y = 20,
                 label = "Your Score",
                 color = "#E4CCC0",
                 size = 3.5)
      plotly::ggplotly(ggplot_dass)
    } else {
      shiny::showNotification(
        "No data found for Depression & Anxiety Questionnaire.
        Please make sure to finish the Questionnaire first.
        The task can be found under Questionnaire Menu Tab.")
      plotly::ggplotly(ggplot_dass)
    }
  }  else if(plot == "SDL") {
    ggplot_sdl <- ggplot(data, aes(x = SDL_score)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)",
           title = "Stroop Deadline Score") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            plot.title = element_text(size=14,
                                      color="#ebebec"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if(file.exists("data/userdata/sdl.outcome.csv")) {
      your_data <- read.csv("data/userdata/sdl_outcome.csv")
      your_outcome <- tail(your_data$adaptive_window[!is.na(your_data$adaptive_window)], 1)
      ggplot_sdl <- ggplot_sdl +
        geom_vline(aes(xintercept=your_outcome), color = "#E4CCC0") +
        annotate(geom = "text",
                 x = your_outcome-450, y = 20,
                 label = "Your Score",
                 color = "#E4CCC0",
                 size = 3.5)
      plotly::ggplotly(ggplot_sdl)
    } else {
      shiny::showNotification(
        "No data found for Stroop Deadline Task.
        Please make sure to finish the task first.
        The task can be found under Experiments Menu Tab")
      plotly::ggplotly(ggplot_sdl)
    }
  }
}
