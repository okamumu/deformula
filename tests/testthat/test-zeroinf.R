test_that("Integral of exp(-a*x) on [0,Inf)", {
  f <- function(x, a) exp(-a*x)
  a <- 0.1
  result <- deformula.zeroinf(f, a=a)
  expect_equal(result$value, 1/a)
  a <- 0.2
  result <- deformula.zeroinf(f, a=a)
  expect_equal(result$value, 1/a)
})


test_that("Integral of a negative integrand on [0,Inf)", {
  f <- function(x, a) -exp(-a*x)
  a <- 0.1
  result <- deformula.zeroinf(f, a=a)
  expect_equal(result$value, -1/a)
  expect_equal(result$message, "OK")
})

test_that("Integral of x*exp(-x) - exp(-x) on [0,Inf) (sign change)", {
  f <- function(x) x*exp(-x) - exp(-x)
  result <- deformula.zeroinf(f)
  expect_equal(result$value, 0, tolerance = 1e-6)
  expect_equal(result$message, "OK")
})

test_that("Weights and abscissas are consistent with the value", {
  f <- function(x, a) exp(-a*x)
  result <- deformula.zeroinf(f, a=0.1)
  expect_equal(sum(result$w) * result$h, result$value)
  expect_equal(length(result$x), length(result$w))
  expect_false(is.unsorted(result$x))
})

test_that("issue #2: an integrand that is negative over the whole range", {
  f <- function(x) -x * dnorm(-x) * pnorm(-x) * 2
  result <- deformula.zeroinf(f)
  expect_equal(result$value, -0.1168475, tolerance = 1e-6)
  expect_equal(result$message, "OK")
})
