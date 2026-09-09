# deformula 0.1.3

- Dropped the `SystemRequirements: C++11` declaration and the `Rcpp::plugins("cpp11")`
  attribute. Support for requesting C++11 has been removed from R, and the request was
  flagged as obsolete by the CRAN checks.
- Removed the unused `cpp11` entry from `LinkingTo`.
- Fixed the integration of integrands that take negative values (#2). Nodes were compared
  with the zero threshold without taking the magnitude, so every negative contribution was
  silently discarded; `deformula.moneone(function(x) x, -1, 1)` returned 0.5 instead of 0.
  An integrand that is negative over the whole range lost every node, so the sum never
  converged and the reported error was `stop("Unknown error code.")`.
- Fixed the convergence test so that an integral whose value is zero converges instead of
  running until `max.iter`.
- Reaching `max.iter` and encountering non-finite values are now reported through the
  `message` component. Previously both raised `stop("Unknown error code.")`.

# deformula 0.1.2

- The package has been rewritten with Rcpp, roxygen2, testthat and devtools.
- License has been changed.
