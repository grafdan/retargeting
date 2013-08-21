//
//  CVXGenRangeSolver25x25.h
//  CVXSolver
//
/* Produced by CVXGEN, 2012-11-27 15:57:37 -0800.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

//  Translated to Objective-C and minor modifications
//  by Daniel Graf in November 2012.

#import <Foundation/Foundation.h>

#define DOF_IN_X (25) //n, s_i
#define DOF_IN_Y (25) //m, t_j
#define NUM_DOF (DOF_IN_X + DOF_IN_Y)

typedef struct RangeParams_t {
  double E[2500];
  double B[50];
  double minW[25];
  double maxW[25];
  double minH[25];
  double maxH[25];
  double imageWidth[1];
  double imageHeight[1];

} RangeParams;

typedef struct RangeVars_t {
  double *st; /* 50 rows. */

} RangeVars;

typedef struct RangeWorkspace_t {
  double h[100];
  double s_inv[100];
  double s_inv_z[100];
  double b[2];
  double q[50];
  double rhs[252];
  double x[252];
  double *s;
  double *z;
  double *y;
  double lhs_aff[252];
  double lhs_cc[252];
  double buffer[252];
  double buffer2[252];

  double KKT[1725];
  double L[1475];
  double d[252];
  double v[252];
  double d_inv[252];

  double gap;
  double optval;

  double ineq_resid_squared;
  double eq_resid_squared;

  double block_33[1];

  /* Pre-op symbols. */

  int converged;
} RangeWorkspace;

typedef struct RangeSettings_t {
  double resid_tol;
  double eps;
  int max_iters;
  int refine_steps;

  int better_start;
  /* Better start obviates the need for s_init and z_init. */
  double s_init;
  double z_init;

  int verbose;
  /* Show extra details of the iterative refinement steps. */
  int verbose_refinement;
  int debug;

  /* For regularization. Minimum value of abs(D_ii) in the kkt D factor. */
  double kkt_reg;
} RangeSettings;

@interface CVXGenRangeSolver25x25 : NSObject {
    // from solver.h
    RangeVars vars;
    RangeParams params;
    RangeWorkspace work;
    RangeSettings settings;
    
    //from util.c (adopted)
    long global_seed;
    clock_t tic_timestart;
    

}

// added by Daniel Graf
-(double *)solveWithS:(double *) S B:(double *) B W:(double) W H:(double) H minW:(double *) minW maxW:(double *) maxW minH:(double *) minH maxH:(double *) maxH;
//end

/* Function definitions in /home/jem/olsr/releases/20110330074202/lib/olsr.extra/qp_solver/solver.c: */
-(double) eval_gap;
-(void) set_defaults;
-(void) setup_pointers;
-(void) setup_indexing;
-(void) set_start;
-(void) fillrhs_aff;
-(void) fillrhs_cc;
-(void) refineWithTarget:(double *)target andVar:(double *)var;
-(double) calc_ineq_resid_squared;
-(double) calc_eq_resid_squared;
-(void) better_start;
-(void) fillrhs_start;
-(long) solve;


/* Function definitions in /home/jem/olsr/releases/20110330074202/lib/olsr.extra/qp_solver/testsolver.c: */
int main(int argc, char **argv);
void load_default_data(void);
@end

