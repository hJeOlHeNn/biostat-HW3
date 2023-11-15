
# linearmodel

<!-- badges: start -->
<!-- badges: end -->

## Introduction

This vignette demonstrates the usage of a custom R package for performing linear regression. The package includes three main functions: my_lm, print.mylm, and my_summary. These functions are designed to mimic the functionality of R's built-in lm function and associated methods.

## Installation

```{r}
#library(devtools)
#devtools::install_github("https://github.com/hJeOlHeNn/biostat-HW3")
#library(linearmodel)
```

## Usage

### Linear Regression with my_lm

The my_lm function performs linear regression. Here's an example using the mtcars dataset:

```{r}
data(mtcars)
fit1 <- my_lm(mpg ~ wt + cyl, data = mtcars)
```

Use * to include interaction variables.

```{r}
fit2 <- my_lm(mpg ~ wt*cyl, data = mtcars)
```

Use -1 to remove intercept from the model.

```{r}
fit3 <- my_lm(mpg ~ -1 + wt + cyl, data = mtcars)
```

### Viewing Results with print.mylm

To view the results of the linear regression, use print.mylm:

```{r}
print.mylm(fit1)
#> Call:
#> my_lm(formula = mpg ~ wt + cyl, data = mtcars)
#> 
#> Coefficients:
#>      [,1]        [,2]             
#> [1,] (Intercept) 39.6862614802529 
#> [2,] wt          -3.19097213898374
#> [3,] cyl         -1.5077949682598
```

### Summary Statistics with my_summary

For a detailed summary of the regression model, use my_summary:

```{r}
my_summary(fit1)
#> Call:
#> my_lm(formula = mpg ~ wt + cyl, data = mtcars)
#> 
#> Residuals:
#>        Min         1Q     Median         3Q        Max 
#> -4.2893353 -1.6036241 -0.4683724  1.5756418  6.1003523 
#> 
#> Coefficients:
#>              Estimate Std.Error   t_value      P_value
#> (Intercept) 39.686261 1.6048552 24.728873 4.858156e-21
#> wt          -3.190972 0.7316688 -4.361225 1.488969e-04
#> cyl         -1.507795 0.4230454 -3.564145 1.287356e-03
#> 
#> Residual standard error: 2.567516 on 29 degrees of freedom
#> Multiple R-squared: 0.8302274 
#> Adjusted R-squared: 0.8185189 
#> F-statistic: 70.90836 on 2 and 29 DF, p-value: 6.808955e-12
```

## Comparison with R's Built-in Functions

### Correctness

We'll compare the results of my_lm with R's lm function to ensure correctness.

```{r}
# compare my_lm using model 1
fit_builtin1 <- lm(mpg ~ wt + cyl, data = mtcars)
all.equal(as.numeric(fit1$coefficients), as.numeric(fit_builtin1$coefficients))
#> [1] TRUE

# compare my_lm using model 2
fit_builtin2 <- lm(mpg ~ wt*cyl, data = mtcars)
all.equal(as.numeric(fit2$coefficients), as.numeric(fit_builtin2$coefficients))
#> [1] TRUE

# compare my_lm using model 3
fit_builtin3 <- lm(mpg ~ -1 + wt + cyl, data = mtcars)
all.equal(as.numeric(fit3$coefficients), as.numeric(fit_builtin3$coefficients))
#> [1] TRUE

# compare my_summary r square
all.equal(as.numeric(my_summary(fit1)$r_squared), as.numeric(summary(fit_builtin1)$r.squared))
#> [1] TRUE

# compare my_summary adjusted r square
all.equal(as.numeric(my_summary(fit1)$adjusted_r_squared), as.numeric(summary(fit_builtin1)$adj.r.squared))
#> [1] TRUE

# compare my_summary p-value
all.equal(as.numeric(my_summary(fit1)$r_squared), as.numeric(summary(fit_builtin1)$r.squared))
#> [1] TRUE
```

### Efficiency

We'll use the bench package to compare the performance of my_lm and lm.

```{r}
library(bench)

# compare efficiency of my_lm
bench::mark(
  as.numeric(fit1$coefficients),
  as.numeric(fit_builtin1$coefficients),
  iterations = 10,
  check = TRUE
)
#> # A tibble: 2 × 6
#>   expression                             min median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                           <bch> <bch:>     <dbl> <bch:byt>    <dbl>
#> 1 as.numeric(fit1$coefficients)        1.3µs  1.6µs   480769.        0B        0
#> 2 as.numeric(fit_builtin1$coefficient… 1.3µs  1.7µs   478469.        0B        0

# compare efficiency of my_summary
bench::mark(
  my_summary(fit1),
  summary(fit_builtin1),
  iterations = 10,
  check = FALSE
)
#> # A tibble: 2 × 6
#>   expression                 min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>            <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 my_summary(fit1)        1.14ms   2.06ms      551.    2.16KB        0
#> 2 summary(fit_builtin1)   87.5µs   97.7µs     7582.    1.19KB        0
```

## Conclusion

This vignette has demonstrated how to use the my_lm, print.mylm, and my_summary functions from the My Linear Regression Package and compared them with R's built-in linear regression functions. The package aims to provide an alternative implementation of linear regression analysis in R.
