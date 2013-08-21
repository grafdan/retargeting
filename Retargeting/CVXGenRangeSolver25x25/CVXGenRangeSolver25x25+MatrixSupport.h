//
//  CVXGenRangeSolver25x25+MatrixSupport.h
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

@interface CVXGenRangeSolver25x25 (MatrixSupport)

/* Function definitions in /home/jem/olsr/releases/20110330074202/lib/olsr.extra/qp_solver/matrix_support.c: */
-(void) multbymAWithLhs:(double *)lhs andRhs:(double *)rhs;
-(void) multbymATWithLhs:(double *)lhs andRhs:(double *)rhs;
-(void) multbymGWithLhs:(double *)lhs andRhs:(double *)rhs;
-(void) multbymGTWithLhs:(double *)lhs andRhs:(double *)rhs;
-(void) multbyPWithLhs:(double *)lhs andRhs:(double *)rhs;
-(void) fillq;
-(void) fillh;
-(void) fillb;
-(void) pre_ops;
@end
