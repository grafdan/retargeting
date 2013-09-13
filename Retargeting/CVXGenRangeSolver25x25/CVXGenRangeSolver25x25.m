//
//  CVXGenRangeSolver25x25.m
//  CVXSolver
//
/* Produced by CVXGEN, 2012-11-27 15:57:37 -0800.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

//  Translated to Objective-C and minor modifications
//  by Daniel Graf in November 2012.

//    This file is part of Refooormat.
//
//    Refooormat is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Refooormat is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Refooormat.  If not, see <http://www.gnu.org/licenses/>.

#import "CVXGenRangeSolver25x25.h"
#import "CVXGenRangeSolver25x25+MatrixSupport.h"
#import "CVXGenRangeSolver25x25+Ldl.h"
#import "CVXGenRangeSolver25x25+Util.h"

@implementation CVXGenRangeSolver25x25

-(double) eval_gap {
  int i;
  double gap;

  gap = 0;
  for (i = 0; i < 100; i++)
    gap += work.z[i]*work.s[i];

  return gap;
}

-(void) set_defaults {
    settings.resid_tol = 1e-6;
    settings.eps = 1e-4;
    settings.max_iters = 25;
    settings.refine_steps = 1;
    
    settings.s_init = 1;
    settings.z_init = 1;
    settings.debug = 0;
    settings.verbose = 1;
    settings.verbose_refinement = 0;
    
    settings.better_start = 1;
    
    settings.kkt_reg = 1e-7;
}

-(void) setup_pointers {
  work.y = work.x + 50;
  work.s = work.x + 52;
  work.z = work.x + 152;

  vars.st = work.x + 0;
}

-(void) setup_indexing {
    [self setup_pointers];
}

-(void) set_start {
  int i;

  for (i = 0; i < 50; i++)
    work.x[i] = 0;

  for (i = 0; i < 2; i++)
    work.y[i] = 0;

  for (i = 0; i < 100; i++)
    work.s[i] = (work.h[i] > 0) ? work.h[i] : settings.s_init;

  for (i = 0; i < 100; i++)
    work.z[i] = settings.z_init;
}


-(double) eval_objv {
  int i;
  double objv;

  /* Borrow space in work.rhs. */
  [self multbyPWithLhs:work.rhs andRhs:work.x];

  objv = 0;
  for (i = 0; i < 50; i++)
    objv += work.x[i]*work.rhs[i];
  objv *= 0.5;

  for (i = 0; i < 50; i++)
    objv += work.q[i]*work.x[i];

  objv += 0;

  return objv;
}

-(void) fillrhs_aff {
  int i;
  double *r1, *r2, *r3, *r4;

  r1 = work.rhs;
  r2 = work.rhs + 50;
  r3 = work.rhs + 150;
  r4 = work.rhs + 250;

  /* r1 = -A^Ty - G^Tz - Px - q. */
    [self multbymATWithLhs:r1 andRhs:work.y];
    [self multbymGTWithLhs:work.buffer andRhs:work.z];
  for (i = 0; i < 50; i++)
    r1[i] += work.buffer[i];
    [self multbyPWithLhs:work.buffer andRhs:work.x];
  for (i = 0; i < 50; i++)
    r1[i] -= work.buffer[i] + work.q[i];

  /* r2 = -z. */
  for (i = 0; i < 100; i++)
    r2[i] = -work.z[i];

  /* r3 = -Gx - s + h. */
    [self multbymGWithLhs:r3 andRhs:work.x];
  for (i = 0; i < 100; i++)
    r3[i] += -work.s[i] + work.h[i];

  /* r4 = -Ax + b. */
    [self multbymAWithLhs:r4 andRhs:work.x];
  for (i = 0; i < 2; i++)
    r4[i] += work.b[i];
}

-(void) fillrhs_cc {
  int i;

  double *r2;
  double *ds_aff, *dz_aff;

  double mu;
  double alpha;
  double sigma;
  double smu;

  double minval;

  r2 = work.rhs + 50;
  ds_aff = work.lhs_aff + 50;
  dz_aff = work.lhs_aff + 150;

  mu = 0;
  for (i = 0; i < 100; i++)
    mu += work.s[i]*work.z[i];
  /* Don't finish calculating mu quite yet. */

  /* Find min(min(ds./s), min(dz./z)). */
  minval = 0;
  for (i = 0; i < 100; i++)
    if (ds_aff[i] < minval*work.s[i])
      minval = ds_aff[i]/work.s[i];
  for (i = 0; i < 100; i++)
    if (dz_aff[i] < minval*work.z[i])
      minval = dz_aff[i]/work.z[i];

  /* Find alpha. */
  if (-1 < minval)
      alpha = 1;
  else
      alpha = -1/minval;

  sigma = 0;
  for (i = 0; i < 100; i++)
    sigma += (work.s[i] + alpha*ds_aff[i])*
      (work.z[i] + alpha*dz_aff[i]);
  sigma /= mu;
  sigma = sigma*sigma*sigma;

  /* Finish calculating mu now. */
  mu *= 0.01;

  smu = sigma*mu;

  /* Fill-in the rhs. */
  for (i = 0; i < 50; i++)
    work.rhs[i] = 0;
  for (i = 150; i < 252; i++)
    work.rhs[i] = 0;

  for (i = 0; i < 100; i++)
    r2[i] = work.s_inv[i]*(smu - ds_aff[i]*dz_aff[i]);
}

-(void) refineWithTarget:(double *)target andVar:(double *)var {
  int i, j;

  double *residual = work.buffer;
  double norm2;
  double *new_var = work.buffer2;
  for (j = 0; j < settings.refine_steps; j++) {
    norm2 = 0;
        [self matrix_multiplyWithResult:residual andSource:var];
    for (i = 0; i < 252; i++) {
      residual[i] = residual[i] - target[i];
      norm2 += residual[i]*residual[i];
    }

#ifndef ZERO_LIBRARY_MODE
    if (settings.verbose_refinement) {
      if (j == 0)
        printf("Initial residual before refinement has norm squared %.6g.\n", norm2);
      else
        printf("After refinement we get squared norm %.6g.\n", norm2);
    }
#endif

    /* Solve to find new_var = KKT \ (target - A*var). */
        [self ldl_solveWithTarget:residual andVar:new_var];

    /* Update var += new_var, or var += KKT \ (target - A*var). */
    for (i = 0; i < 252; i++) {
      var[i] -= new_var[i];
    }
  }

#ifndef ZERO_LIBRARY_MODE
  if (settings.verbose_refinement) {
    /* Check the residual once more, but only if we're reporting it, since */
    /* it's expensive. */
    norm2 = 0;
        [self matrix_multiplyWithResult:residual andSource:var];
    for (i = 0; i < 252; i++) {
      residual[i] = residual[i] - target[i];
      norm2 += residual[i]*residual[i];
    }

    if (j == 0)
      printf("Initial residual before refinement has norm squared %.6g.\n", norm2);
    else
      printf("After refinement we get squared norm %.6g.\n", norm2);
  }
#endif
}

-(double) calc_ineq_resid_squared {
  /* Calculates the norm ||-Gx - s + h||. */
  double norm2_squared;
  int i;

  /* Find -Gx. */
    [self multbymGWithLhs:work.buffer andRhs:work.x];

  /* Add -s + h. */
  for (i = 0; i < 100; i++)
    work.buffer[i] += -work.s[i] + work.h[i];

  /* Now find the squared norm. */
  norm2_squared = 0;
  for (i = 0; i < 100; i++)
    norm2_squared += work.buffer[i]*work.buffer[i];

  return norm2_squared;
}

-(double) calc_eq_resid_squared {
  /* Calculates the norm ||-Ax + b||. */
  double norm2_squared;
  int i;

  /* Find -Ax. */
    [self multbymAWithLhs:work.buffer andRhs:work.x];

  /* Add +b. */
  for (i = 0; i < 2; i++)
    work.buffer[i] += work.b[i];

  /* Now find the squared norm. */
  norm2_squared = 0;
  for (i = 0; i < 2; i++)
    norm2_squared += work.buffer[i]*work.buffer[i];

  return norm2_squared;
}

-(void) better_start {
  /* Calculates a better starting point, using a similar approach to CVXOPT. */
  /* Not yet speed optimized. */
  int i;
  double *x, *s, *z, *y;
  double alpha;

  work.block_33[0] = -1;
  /* Make sure sinvz is 1 to make hijacked KKT system ok. */
  for (i = 0; i < 100; i++)
    work.s_inv_z[i] = 1;
    [self fill_KKT];
    [self ldl_factor];
    
    [self fillrhs_start];
    /* Borrow work.lhs_aff for the solution. */
    [self ldl_solveWithTarget:work.rhs andVar:work.lhs_aff];
  /* Don't do any refinement for now. Precision doesn't matter too much. */

  x = work.lhs_aff;
  s = work.lhs_aff + 50;
  z = work.lhs_aff + 150;
  y = work.lhs_aff + 250;

  /* Just set x and y as is. */
  for (i = 0; i < 50; i++)
    work.x[i] = x[i];

  for (i = 0; i < 2; i++)
    work.y[i] = y[i];

  /* Now complete the initialization. Start with s. */
  /* Must have alpha > max(z). */
  alpha = -1e99;
  for (i = 0; i < 100; i++)
    if (alpha < z[i])
      alpha = z[i];

  if (alpha < 0) {
    for (i = 0; i < 100; i++)
      work.s[i] = -z[i];
  } else {
    alpha += 1;
    for (i = 0; i < 100; i++)
      work.s[i] = -z[i] + alpha;
  }

  /* Now initialize z. */
  /* Now must have alpha > max(-z). */
  alpha = -1e99;
  for (i = 0; i < 100; i++)
    if (alpha < -z[i])
      alpha = -z[i];

  if (alpha < 0) {
    for (i = 0; i < 100; i++)
      work.z[i] = z[i];
  } else {
    alpha += 1;
    for (i = 0; i < 100; i++)
      work.z[i] = z[i] + alpha;
  }
}

-(void) fillrhs_start {
  /* Fill rhs with (-q, 0, h, b). */
  int i;
  double *r1, *r2, *r3, *r4;

  r1 = work.rhs;
  r2 = work.rhs + 50;
  r3 = work.rhs + 150;
  r4 = work.rhs + 250;

  for (i = 0; i < 50; i++)
    r1[i] = -work.q[i];

  for (i = 0; i < 100; i++)
    r2[i] = 0;

  for (i = 0; i < 100; i++)
    r3[i] = work.h[i];

  for (i = 0; i < 2; i++)
    r4[i] = work.b[i];
}

-(long) solve {
  int i;
  int iter;

  double *dx, *ds, *dy, *dz;
  double minval;
  double alpha;
  work.converged = 0;

    [self setup_pointers];
    [self pre_ops];

#ifndef ZERO_LIBRARY_MODE
  if (settings.verbose)
    printf("iter     objv        gap       |Ax-b|    |Gx+s-h|    step\n");
#endif

    [self fillq];
    [self fillh];
    [self fillb];
    
    if (settings.better_start)
        [self better_start];
    else
        [self set_start];

  for (iter = 0; iter < settings.max_iters; iter++) {
    for (i = 0; i < 100; i++) {
      work.s_inv[i] = 1.0 / work.s[i];
      work.s_inv_z[i] = work.s_inv[i]*work.z[i];
    }

    work.block_33[0] = 0;
    [self fill_KKT];
    [self ldl_factor];
    /* Affine scaling directions. */
    [self fillrhs_aff];
    [self ldl_solveWithTarget:work.rhs andVar:work.lhs_aff];
    [self refineWithTarget:work.rhs andVar:work.lhs_aff];
    /* Centering plus corrector directions. */
    [self fillrhs_cc];
    [self ldl_solveWithTarget:work.rhs andVar:work.lhs_cc];
    [self refineWithTarget:work.rhs andVar:work.lhs_cc];
        
    /* Add the two together and store in aff. */
    for (i = 0; i < 252; i++)
      work.lhs_aff[i] += work.lhs_cc[i];

    /* Rename aff to reflect its new meaning. */
    dx = work.lhs_aff;
    ds = work.lhs_aff + 50;
    dz = work.lhs_aff + 150;
    dy = work.lhs_aff + 250;

    /* Find min(min(ds./s), min(dz./z)). */
    minval = 0;
    for (i = 0; i < 100; i++)
      if (ds[i] < minval*work.s[i])
        minval = ds[i]/work.s[i];
    for (i = 0; i < 100; i++)
      if (dz[i] < minval*work.z[i])
        minval = dz[i]/work.z[i];

    /* Find alpha. */
    if (-0.99 < minval)
      alpha = 1;
    else
      alpha = -0.99/minval;

    /* Update the primal and dual variables. */
    for (i = 0; i < 50; i++)
      work.x[i] += alpha*dx[i];
    for (i = 0; i < 100; i++)
      work.s[i] += alpha*ds[i];
    for (i = 0; i < 100; i++)
      work.z[i] += alpha*dz[i];
    for (i = 0; i < 2; i++)
      work.y[i] += alpha*dy[i];

    work.gap = [self eval_gap];
    work.eq_resid_squared = [self calc_eq_resid_squared];
    work.ineq_resid_squared = [self calc_ineq_resid_squared];
#ifndef ZERO_LIBRARY_MODE
    if (settings.verbose) {
      work.optval = [self eval_objv];
      printf("%3d   %10.3e  %9.2e  %9.2e  %9.2e  % 6.4f\n",
          iter+1, work.optval, work.gap, sqrt(work.eq_resid_squared),
          sqrt(work.ineq_resid_squared), alpha);
    }
#endif

    /* Test termination conditions. Requires optimality, and satisfied */
    /* constraints. */
    if (   (work.gap < settings.eps)
        && (work.eq_resid_squared <= settings.resid_tol*settings.resid_tol)
        && (work.ineq_resid_squared <= settings.resid_tol*settings.resid_tol)
       ) {

      work.converged = 1;
      work.optval = [self eval_objv];
      return iter+1;
    }
  }

  return iter;
}

// added by Daniel Graf


-(double *)solveWithS:(double *) S B:(double *) B W:(double) W H:(double) H minW:(double *) minW maxW:(double *) maxW minH:(double *) minH maxH:(double *) maxH {
    [self set_defaults];
    settings.verbose = 0;
    [self setup_indexing];
    
    params.imageWidth[0] = W;
    params.imageHeight[0] = H;
    for(int i = 0; i < 25; i++) {
        params.minW[i] = minW[i];
        params.maxW[i] = maxW[i];
        params.minH[i] = minH[i];
        params.maxH[i] = maxH[i];
//        printf("W %f %f , H %f %f\n",
//               params.minW[i],
//               params.maxW[i],
//               params.minH[i],
//               params.maxH[i]);
    }
    
    for(int i = 0; i < NUM_DOF; i++)
    {
        for(int j = 0; j < NUM_DOF; j++)
        {
            params.E[i*NUM_DOF + j] = S[i*NUM_DOF + j];
        }
    }
    
    for(int i = 0; i < NUM_DOF; i++)
    {
        params.B[i] = B[i];
    }
    
    for(int i = 0; i < NUM_DOF; i++)
    {
        vars.st[i] = 0.0;
    }
    
    //solving the quadratic program
    // without iteration output:
    [self solve];
    // with iteration output:
//    long int num_iters = [self solve];
//    printf("optimized in %ld iterations\n",num_iters);
        
    //    double width = 0.0;
    //    for(int i = 0; i < DOF_IN_X; i++)
    //    {
    //        std::cout << vars.st[i] << "\n";
    //        width += vars.st[i];
    //    }
    //
    //    std::cout << "Solver returned width: " << width << ".\n";
    //
    //    double height = 0.0;
    //    for(int i = 0; i < DOF_IN_Y; i++)
    //    {
    //        std::cout << vars.st[i + DOF_IN_X] << "\n";
    //        height += vars.st[i + DOF_IN_X];
    //    }
    //
    //    std::cout << "Solver returned height: " << height << ".\n";
    
    double * res = malloc(NUM_DOF*sizeof(double));
    for(int i = 0; i < NUM_DOF; i++)
        res[i] = vars.st[i];
    return res;
    
}



@end
