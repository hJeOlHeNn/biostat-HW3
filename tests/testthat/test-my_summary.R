# Assuming my_lm is already defined and working correctly
data(mtcars)
fit_my_lm <- my_lm(mpg ~ wt, mtcars)

# Test Case 1: Compare R-squared and Adjusted R-squared with lm() summary
test_that("R-squared and Adjusted R-squared match lm() summary", {
  lm_fit <- lm(mpg ~ wt, data = mtcars)
  lm_summary <- summary(lm_fit)
  my_summary_fit <- my_summary(fit_my_lm)

  expect_equal(my_summary_fit$r_squared,lm_summary$r.squared)
  expect_equal(my_summary_fit$adjusted_r_squared,lm_summary$adj.r.squared)
  expect_equal(my_summary_fit$degrees_of_freedom,lm_summary$df[2])
  expect_equal(my_summary_fit$residual_standard_error,lm_summary$sigma)
  expect_equal(my_summary_fit$f_statistic,as.numeric(lm_summary$fstatistic[1]))
})
