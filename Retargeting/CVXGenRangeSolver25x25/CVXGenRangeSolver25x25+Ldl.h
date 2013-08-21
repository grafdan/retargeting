//
//  CVXGenRangeSolver25x25+Ldl.h
//  CVXSolver
//
/* Produced by CVXGEN, 2012-11-27 15:57:37 -0800.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

//  Translated to Objective-C and minor modifications
//  by Daniel Graf in November 2012.

#import "CVXGenRangeSolver25x25.h"

@interface CVXGenRangeSolver25x25 (Ldl)
/* Function definitions in /home/jem/olsr/releases/20110330074202/lib/olsr.extra/qp_solver/ldl.c: */
-(void) ldl_solveWithTarget:(double *)target andVar:(double *)var;
-(void) ldl_factor;
-(double) check_factorization;
-(void) matrix_multiplyWithResult:(double *) result andSource:(double *)source;
-(double) check_residualWithTarget:(double *)target andMultiplicand:( double *)multiplicand;
-(void) fill_KKT;

@end
