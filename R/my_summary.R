#'Linear Model Summary
#'
#'Summarize linear model to the given data.
#'
#'@param object An object returned by my_lm function.
#'
#'@return multiple vectors of coefficients, tests, and R square values.
#'
#'@examples
#'my_summary(model)
#'
#'@export
#'
my_summary <- function(object) {
  #Print the call (the original function call)
  cat("Call:\n")
  print(object$call)

  # Calculate and print summary statistics of residuals
  cat("\nResiduals:\n")
  res_stats <- fivenum(object$residuals)
  names(res_stats) <- c("Min", "1Q", "Median", "3Q", "Max")
  print(res_stats)

  # Calculate and print the coefficients, standard errors, t-values, and p-values
  cat("\nCoefficients:\n")
  sse <- sum((object$residuals) ^ 2)
  sst <- sum((object$response - mean(object$response)) ^ 2)
  mse <- sse / (nrow(object$qr$qr) - length(object$coefficients))
  std_error <-
    sqrt(diag(mse * solve(t(object$qr$qr) %*% object$qr$qr)))
  t_value <- object$coefficients / std_error
  p_value <-
    2 * pt(-abs(t_value),
           df = nrow(object$qr$qr) - length(object$coefficients))
  coef_summary <-
    data.frame(
      Estimate = object$coefficients,
      Std.Error = std_error,
      t_value = t_value,
      P_value = p_value
    )
  print(coef_summary)

  # Print the residual standard error and degrees of freedom
  cat(
    "\nResidual standard error:",
    sqrt(mse),
    "on",
    nrow(object$qr$qr) - length(object$coefficients),
    "degrees of freedom\n"
  )

  # Calculate and print R-squared and Adjusted R-squared values
  #r_squared <- 1 - sse/sum((object$fitted.values - mean(object$fitted.values))^2 + sse)
  r_squared <- 1 - sse / sst
  n <- nrow(object$qr$qr)
  p <- length(object$coefficients)
  adj_r_squared <- 1 - (1 - r_squared) * ((n - 1) / (n - p))
  #adj_r_squared <- 1 - (1 - r_squared) * ((nrow(object$qr$qr) - 1)/(nrow(object$qr$qr) - length(object$coefficients)))
  cat("Multiple R-squared:", r_squared, "\n")
  cat("Adjusted R-squared:", adj_r_squared, "\n")

  # Calculate and print the F-statistic, degrees of freedom, and p-value
  f_statistic <-
    (sum((
      object$fitted.values - mean(object$fitted.values)
    ) ^ 2) / (length(object$coefficients) - 1)) / mse
  p_value_f <-
    pf(
      f_statistic,
      df1 = length(object$coefficients) - 1,
      df2 = nrow(object$qr$qr) - length(object$coefficients),
      lower.tail = FALSE
    )
  cat(
    "F-statistic:",
    f_statistic,
    "on",
    length(object$coefficients) - 1,
    "and",
    nrow(object$qr$qr) - length(object$coefficients),
    "DF, p-value:",
    p_value_f,
    "\n"
  )
}
