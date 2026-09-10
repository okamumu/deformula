## Resubmission of an archived package

deformula was archived on 2026-02-15 because the C++11 specification issue reported by the
CRAN checks was not corrected.

`SystemRequirements: C++11` and the `Rcpp::plugins("cpp11")` attribute have been removed,
which resolves the notes that led to the archival:

* "Specified C++11: please drop specification unless essential"
* "SystemRequirements specified C++11: support has been removed"
* "Obsolete C++11 standard request will be ignored"

This version also fixes a bug in which integrands taking negative values were integrated
incorrectly: the quadrature weights were compared against the zero threshold without taking
their magnitude, so every negative contribution was discarded. An integrand that is negative
over its whole range lost all of its nodes and the call failed with an unhelpful error
(https://github.com/okamumu/deformula/issues/2).

## Test environments

* local Docker, Ubuntu 24.04, R 4.5.1 (release), R CMD check --as-cran
* win-builder, R-devel
* macOS builder, R-release
* GitHub Actions: ubuntu-latest (R-devel, R-release, R-oldrel-1), macOS-latest and
  windows-latest (R-release)

## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  New submission
  Package was archived on CRAN

  This is the resubmission of the archived package described above.
