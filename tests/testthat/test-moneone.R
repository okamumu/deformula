test_that("Integral of exp(-a*x) on [0,1]", {
  f <- function(x, a) exp(-a*x)
  expected <- function(a, lower, upper) {
    (1/a)*(exp(-a*lower)-exp(-a*upper))
  }
  a <- 0.1
  l <- 0.0
  u <- 2.0
  result <- deformula.moneone(f, l, u, a=a)
  expect_equal(result$value, expected(a, l, u))
  a <- 0.2
  l <- -1.0
  u <- 2.0
  result <- deformula.moneone(f, l, u, a=a)
  expect_equal(result$value, expected(a, l, u))
  a <- 10.0
  l <- 0.0
  u <- 20.0
  result <- deformula.moneone(f, l, u, a=a)
  expect_equal(result$value, expected(a, l, u))
})


test_that("Integral of a negative integrand over a finite interval", {
  expect_equal(deformula.moneone(function(x) -1, 0, 1)$value, -1)
  expect_equal(deformula.moneone(function(x) -exp(x), 0, 1)$value, 1 - exp(1))
})

test_that("Integral of an odd function over a symmetric interval is zero", {
  result <- deformula.moneone(function(x) x, -1, 1)
  expect_equal(result$value, 0)
  expect_equal(result$message, "OK")
})

test_that("Integral of the zero function converges", {
  result <- deformula.moneone(function(x) 0, 0, 1)
  expect_equal(result$value, 0)
  expect_equal(result$message, "OK")
})

test_that("Integral with an integrable end-point singularity", {
  result <- deformula.moneone(function(x) 1/sqrt(1-x^2), -1, 1)
  expect_equal(result$value, pi, tolerance = 1e-6)
})
