# Test Case 1: Basic functionality with a simple linear model
test_that("Basic linear model works", {
  data(mtcars)
  result <- my_lm(mpg ~ wt, mtcars)
  expect_true(is.list(result))
  expect_true("coefficients" %in% names(result))
  expect_true("residuals" %in% names(result))
  expect_true("fitted.values" %in% names(result))
  expect_true("qr" %in% names(result))
  expect_true("call" %in% names(result))
})

# Test Case 2: Compare coefficients with built-in lm function
test_that("Coefficients match those from lm()", {
  data(mtcars)
  result <- my_lm(mpg ~ wt, mtcars)
  lm_result <- lm(mpg ~ wt, data = mtcars)
  expect_equal(as.numeric(result$coefficients), as.numeric(lm_result$coefficients))
})

# Test Case 3: Test with multiple predictors
test_that("Works with multiple predictors", {
  data(mtcars)
  result <- my_lm(mpg ~ wt + cyl, mtcars)
  expect_true(length(result$coefficients) == 3) # Intercept, wt, cyl
})

# Test Case 4: Handling of NA values
test_that("Correct handling of NA values", {
  df <- data.frame(x = c(1, 2, NA, 4), y = c(4, NA, 6, 8))
  result <- my_lm(y ~ x, df)
  expect_true(all(is.na(result$coefficients) == FALSE))
})

# Test Case 5: Test with no intercept
test_that("Works with no intercept", {
  data(mtcars)
  result <- my_lm(mpg ~ 0 + wt, mtcars)
  expect_false(any(names(result$coefficients) == "(Intercept)"))
})

# Test Case 6: Test with categorical predictors
test_that("Works with categorical predictors", {
  df <- data.frame(y = rnorm(10), x = gl(2, 5))
  result <- my_lm(y ~ x, df)
  expect_true(length(result$coefficients) == 2) # Two levels of x
})
