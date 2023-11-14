#'Linear Model
#'
#'Fits a linear model to the given data.
#'
#'@param formula An object of class \code{"formula"}.
#'@param data A data frame containing the variables in the model.
#'
#'@return A numeric vector of coefficients.
#'
#'@examples
#'my_lm(y~x, data = dataset)
#'
#'@export
#'
my_lm <- function(formula, data) {
  # Create a model frame based on the formula and data
  mf <- model.frame(formula, data)

  # Extract the response variable from the model frame
  response <- model.response(mf)

  # Create a matrix of predictor variables from the model frame
  predictor <- model.matrix(formula, mf)

  # Perform QR decomposition on the predictor matrix
  qr_fit <- qr(predictor)

  # Solve for coefficients using the R matrix from the QR decomposition
  coefficients <- solve(qr.R(qr_fit), t(qr.Q(qr_fit)) %*% response)

  # Calculate residuals (difference between observed and fitted values)
  residuals <- response - predictor %*% coefficients

  # Calculate fitted values (predicted values of the response variable)
  fitted.values <- predictor %*% coefficients

  # Create a list to store the results, and assign a class for custom printing
  result <- list(response = response, coefficients = coefficients, residuals = residuals, fitted.values = fitted.values, qr = qr_fit, call = match.call())
  class(result) <- "mylm"

  # Return the result object
  return(result)
}

print.mylm <- function(x, ...) {
  # Print the call (the original function call)
  cat("Call:\n")
  print(x$call)

  # Print the coefficients in a formatted manner
  cat("\nCoefficients:\n")
  coef_mat <- matrix(c(rownames(x$coefficients), x$coefficients), ncol = 2)
  print(coef_mat, quote = FALSE)

  # Return the original object invisibly
  invisible(x)
}
