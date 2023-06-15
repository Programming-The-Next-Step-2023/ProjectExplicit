# General Population data ------------------------------------------------------------
### Show plots based on previous data collected

#' @import ggplot2

#' @title Generates Tasks and Questionnaire plots
#' @description
#'  Generates ggplot with Tasks and Questionnaire scores of the general population
#'  and the users own score.
#' @param plot character. Which data should be generated. "AUDIT", "DASS" or "SDL".
#'
#' @returns A plot for RShiny implementation.
#'
#' @keywords internal
#'
#' @export

build_plot <- function(plot) {
  package_path <- system.file(package = "ProjectExplicit")
  data <- read.csv(paste(package_path, "/general_data.csv", sep=""))

  if(plot == "AUDIT") {
    ggplot_audit <- ggplot(data, aes(x = AUDIT)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if (file.exists(paste(package_path, "/userdata/audit_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/audit_outcome.csv", sep = ""))
      your_outcome <- sum(as.numeric(your_data[[2]]))
      ggplot_audit <- ggplot_audit +
        geom_vline(aes(xintercept=your_outcome), color = "#E4CCC0") +
        annotate(geom = "text",
                 x = your_outcome-3, y = 25,
                 label = "Your Score",
                 color = "#E4CCC0",
                 size = 3.5)
      plotly::ggplotly(ggplot_audit)
    } else {
      shiny::showNotification(
        "No data found for Depression & Anxiety Questionnaire.
        Please make sure to finish the Questionnaire first.
        The task can be found under Questionnaire Menu Tab.",
        duration = 30)
      plotly::ggplotly(ggplot_audit)
    }

  } else if(plot == "DASS") {
    ggplot_dass <- ggplot(data, aes(x = DASS)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if (file.exists(paste(package_path, "/userdata/dass_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/dass_outcome.csv", sep = ""))
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
        The task can be found under Questionnaire Menu Tab.",
        duration = 30)
      plotly::ggplotly(ggplot_dass)
    }
  }  else if(plot == "SDL") {
    ggplot_sdl <- ggplot(data, aes(x = SDL_score)) +
      geom_bar(fill = "#bc0031", na.rm = TRUE) +
      labs(x = "Score",
           y = "Count (n)") +
      theme(panel.background = element_rect(fill ="#1F1D21",
                                            colour = "#1F1D21"),
            panel.grid = element_blank(),
            plot.background = element_rect(fill = "#1F1D21"),
            axis.title = element_text(color="#ebebec"),
            axis.text = element_text(color="#ebebec"),
            axis.line = element_line(color = "#ebebec"),
            axis.ticks = element_line(colour = "#ebebec"))

    if(file.exists(paste(package_path, "/userdata/sdl_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/sdl_outcome.csv", sep = ""))
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
        The task can be found under Experiments Menu Tab",
        duration = 30)
      plotly::ggplotly(ggplot_sdl)
    }
  }
}

#' @title Generates an Regression plot
#' @description
#'  Generates a regression plotly with a chosen Questionnaire scores and chosen cognitive
#'  task score of the general population and the users own score.
#'
#' @returns A plot for RShiny implementation.
#'
#' @keywords internal
#'
#' @export

build_regression_plot <- function(x, y) {
  package_path <- system.file(package = "ProjectExplicit")
  data <- read.csv(paste(package_path, "/general_data.csv", sep = ""))
  if (y == "Alcohol Use"){
    yaxis <- data$AUDIT
    ylabel <- "Alcohol Use Score"
    if (file.exists(paste(package_path, "/userdata/audit_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/audit_outcome.csv", sep = ""))
      your_outcome_y <- sum(as.numeric(your_data[[2]]))
    }

  } else if (y == "Depression, Anxiety & Stress") {
    yaxis <- data$DASS
    ylabel <- "Depression, Anxiety & Stress Score"
    if (file.exists(paste(package_path, "/userdata/dass_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/dass_outcome.csv", sep = ""))
      your_outcome_y <- sum(as.numeric(your_data[[2]]))
    }
  }
  if (x == "Stroop Deadline") {
    xaxis <- data$SDL_score
    xlabel <- "Stroop Deadline Score"
    if (file.exists(paste(package_path, "/userdata/sdl_outcome.csv", sep = ""))) {
      your_data <- read.csv(paste(package_path, "/userdata/sdl_outcome.csv", sep = ""))
      your_outcome_x <- tail(your_data$adaptive_window[!is.na(your_data$adaptive_window)], 1)
    }
  }
  ggplot <- ggplot(data, aes(xaxis, yaxis)) +
    geom_point(colour = "#bc0031") +
    geom_smooth(method ="lm", colour = "#E4CCC0", fill = "#ebebec", na.rm = TRUE) +
    theme(panel.background = element_rect(fill ="#1F1D21",
                                          colour = "#1F1D21"),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "#1F1D21"),
          axis.title = element_text(color="#ebebec"),
          axis.text = element_text(color="#ebebec"),
          axis.line = element_line(color = "#ebebec"),
          axis.ticks = element_line(colour = "#ebebec")) +
    labs(y = ylabel,
         x = xlabel)
  if (exists("your_outcome_x") & exists("your_outcome_y")) {
    ggplot <- ggplot +
      geom_point(aes(x=your_outcome_x,y=your_outcome_y),colour="#E4CCC0") +
      annotate(geom = "text",
               x = your_outcome_x, y = your_outcome_y+9,
               label = "Your Score",
               color = "#E4CCC0",
               size = 3.5)
  }
  plotly::ggplotly(ggplot)

}
