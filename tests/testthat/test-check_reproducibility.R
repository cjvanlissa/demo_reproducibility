test_that("loglikelihoods reproduce", {
  tab_fit <- read.csv("../../tab_fit.csv")
  expect_equal(tab_fit$LL, c(-1641.07736543489, -1397.43263370325, -1331.99221769106, -1287.30822239214,
    -1234.27537091578, -1221.91601104382), tolerance = .001)

})
