#ifndef _ALL_R_ROUTINE_H
#define _ALL_R_ROUTINE_H

#include <R.h>
#include <R_ext/Utils.h>
#include <Rinternals.h>
#include <Rdefines.h>

#ifdef __cplusplus
extern "C" {
#endif

  SEXP integrate_zero_to_inf(SEXP f, SEXP rho,
    SEXP zero, SEXP reltol, SEXP startd, SEXP maxiter);
  SEXP integrate_mone_to_one(SEXP f, SEXP rho,
    SEXP zero, SEXP reltol, SEXP startd, SEXP maxiter);

#ifdef __cplusplus
}
#endif

#endif
