% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/my_lm.R
\name{my_lm}
\alias{my_lm}
\title{Linear Model}
\usage{
my_lm(formula, data)
}
\arguments{
\item{formula}{An object of class \code{"formula"}.}

\item{data}{A data frame containing the variables in the model.}
}
\value{
A numeric vector of responses, coefficients, residuals, and fitted values.
}
\description{
Fits a linear model to the given data.
}
\examples{
my_lm(mpg ~ wt + cyl, data = mtcars)

}
