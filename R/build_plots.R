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
audit_plot <- function() {
  data <- read.csv("data/general_data.csv")
  your_data <- read.csv("data/userdata/audit_outcome.csv")
  your_outcome <- sum(as.numeric(your_data[[2]]))
  ggplot(data, aes(x = AUDIT)) +
    geom_histogram(fill = "#bc0031") +
    geom_vline(aes(xintercept=your_outcome), color = "#E4CCC0") +
    annotate(geom = "text", x = your_outcome-2.5, y = 25, label = "Your Score", color = "#E4CCC0", size = 2.5) +
    labs(x = "Score", y = "Count (n)", title = "Alcohol Use", subtitle = "How do you compare to the general population?") +
    theme(panel.background = element_rect(fill ="#1F1D21",
                                          colour = "#1F1D21"),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "#1F1D21"),
          plot.title = element_text(size=14,
                                    color="#ebebec"),
          plot.subtitle = element_text(color="#ebebec"),
          axis.title = element_text(color="#ebebec"),
          axis.text = element_text(color="#ebebec"),
          axis.line = element_line(color = "#ebebec"),
          axis.ticks = element_line(colour = "#ebebec"))
}
