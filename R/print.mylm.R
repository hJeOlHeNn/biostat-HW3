#'Print Method for My Linear Model Objects
#'
#'Print the result of a linear model.
#'
#'@param x An model returned by my_lm function.
#'@param ... further arguments passed to or from other methods.
#'
#'@return A numeric vector of coefficients.
#'
#'@examples
#'print.mylm(my_lm(mpg ~ wt + cyl, data = mtcars))
#'
#'@export
#'
print.mylm <- function(x, ...) {
  # Print the call (the original function call)
  cat("Call:\n")
  print(x$call)

  # Print the coefficients in a formatted manner
  cat("\nCoefficients:\n")
  coef_mat <-
    matrix(c(rownames(x$coefficients), x$coefficients), ncol = 2)
  print(coef_mat, quote = FALSE)

  # Return the original object invisibly
  invisible(x)
}
