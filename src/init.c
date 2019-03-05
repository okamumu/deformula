#include "allheader.h"
#include <R_ext/Rdynload.h>

#define CALLDEF(name, n) {#name, (DL_FUNC) &name, n}
#define EXTDEF(name, n)  {#name, (DL_FUNC) &name, n}

  SEXP integrate_zero_to_inf(SEXP f, SEXP rho,
    SEXP zero, SEXP reltol, SEXP startd, SEXP maxiter);
  SEXP integrate_mone_to_one(SEXP f, SEXP rho,
    SEXP zero, SEXP reltol, SEXP startd, SEXP maxiter);

static R_CallMethodDef callMethods[] = {
    CALLDEF(integrate_zero_to_inf, 6),
    CALLDEF(integrate_mone_to_one, 6),
    {NULL, NULL, 0}
};

void R_init_deformula(DllInfo *dll) {
    R_registerRoutines(dll, NULL, callMethods, NULL, NULL);
    R_useDynamicSymbols(dll, TRUE);
}

