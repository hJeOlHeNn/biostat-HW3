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

  # Calculate summary statistics of residuals
  res_stats <- fivenum(object$residuals)
  names(res_stats) <- c("Min", "1Q", "Median", "3Q", "Max")

  # Calculate the coefficients, standard errors, t-values, and p-values
  sse <- sum((object$residuals) ^ 2)
  sst <- sum((object$response - mean(object$response)) ^ 2)
  mse <- sse / (nrow(object$qr$qr) - length(object$coefficients))
  std_error <-
    sqrt(diag(mse * solve(t(object$qr$qr) %*% object$qr$qr)))
  t_value <- object$coefficients / std_error
  p_value <-
    2 * pt(-abs(t_value),
           df = nrow(object$qr$qr) - length(object$coefficients))
  coef_summary <- data.frame(
    Estimate = object$coefficients,
    Std.Error = std_error,
    t_value = t_value,
    P_value = p_value
  )

  # Calculate the residual standard error and degrees of freedom
  residual_standard_error <- sqrt(mse)
  degrees_of_freedom <-
    nrow(object$qr$qr) - length(object$coefficients)

  # Calculate R-squared and Adjusted R-squared values
  r_squared <- 1 - sse / sst
  n <- nrow(object$qr$qr)
  p <- length(object$coefficients)
  adj_r_squared <- 1 - (1 - r_squared) * ((n - 1) / (n - p))

  # Calculate the F-statistic, degrees of freedom, and p-value
  f_statistic <-
    (sum((
      object$fitted.values - mean(object$fitted.values)
    ) ^ 2) / (length(object$coefficients) - 1)) / mse
  p_value_f <-
    pf(
      f_statistic,
      df1 = length(object$coefficients) - 1,
      df2 = degrees_of_freedom,
      lower.tail = FALSE
    )

  # store the values
  summary_results <- list(
    call = object$call,
    residuals = res_stats,
    coefficients = coef_summary,
    residual_standard_error = residual_standard_error,
    degrees_of_freedom = degrees_of_freedom,
    r_squared = r_squared,
    adjusted_r_squared = adj_r_squared,
    f_statistic = f_statistic,
    f_statistic_p_value = p_value_f
  )

  # Return the summary results
  return(summary_results)
}
