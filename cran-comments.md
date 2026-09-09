## Resubmission

This package was archived on 2026-02-15 because the C++11 specification issue reported by
the CRAN checks was not corrected.

`SystemRequirements: C++11` and the `Rcpp::plugins("cpp11")` attribute have been removed,
which resolves the following notes:

* "Specified C++11: please drop specification unless essential"
* "SystemRequirements specified C++11: support has been removed"
* "Obsolete C++11 standard request will be ignored"

This version also fixes a bug in which integrands taking negative values were integrated
incorrectly.

## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  New submission
  Package was archived on CRAN

  This is the resubmission of the archived package described above.
