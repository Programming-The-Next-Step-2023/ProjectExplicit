library(ProjectExplicit)

context("Merging files functionality")

test_that("merging files works", {
  merge_data_files("C:/Users/mrkon/Desktop/UvA/CoPY/CoPY_2.0/analysis/data/data_stroop")
  
  #checks that the original number of data files is the same as  length of the merged data frame
  expect_equal(length(data_stroop), nrow(stroop_metrics))
  
  #checks that the participant ID and corresponding data are correctly merged with the original data
  expect_equal(data_stroop[[1]]$uniqueSubID[1], stroop_metrics$uniqueSubID[1])
})
