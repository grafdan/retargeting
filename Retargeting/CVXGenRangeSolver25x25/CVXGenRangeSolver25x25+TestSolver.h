//
//  CVXGenRangeSolver25x25+TestSolver.h
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

@interface CVXGenRangeSolver25x25 (TestSolver)
-(void) load_testcase;
-(double *) test_solver;
@end
