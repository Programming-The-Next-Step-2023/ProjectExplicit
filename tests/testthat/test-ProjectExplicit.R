library(ProjectExplicit)

context("Merging files functionality")

test_that("retrieving and adding your data to general population data works", {
  package_directory <- system.file(package = "ProjectExplicit")
  filename <- paste(package_directory, "/userdata/audit_outcome.csv", sep="")

  general_data_added <- merge_data_files(filename)
  general_data_original <- read.csv(paste(package_directory, "/general_data.csv", sep=""))
  expect_equal(length(general_data_added), length(general_data_original)+1)
})
