//
//  CVXGenRangeSolver25x25+Util.m
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


#import "CVXGenRangeSolver25x25+Util.h"
#import "CVXGenRangeSolver25x25.h"

@implementation CVXGenRangeSolver25x25 (Util)
/* Produced by CVXGEN, 2012-10-07 05:59:07 -0700.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

/* Filename: util.c. */
/* Description: Common utility file for all cvxgen code. */

//added by Daniel Graf
-(void)initUtil {
    global_seed = 1;
}
//end

-(void) tic {
    tic_timestart = clock();
}

-(float) toc {
    clock_t tic_timestop;
    tic_timestop = clock();
    printf("time: %8.5f.\n", (float)(tic_timestop - tic_timestart) / CLOCKS_PER_SEC);
    return (float)(tic_timestop - tic_timestart) / CLOCKS_PER_SEC;
}

-(int) int_toc {
    clock_t tic_timestop;
    tic_timestop = clock();
    printf("time: %8.5f.\n", (float)(tic_timestop - tic_timestart) / CLOCKS_PER_SEC);
    return (int)(tic_timestop - tic_timestart);
}

-(float) tocq {
    clock_t tic_timestop;
    tic_timestop = clock();
    return (float)(tic_timestop - tic_timestart) / CLOCKS_PER_SEC;
}

-(void) printmatrixWithName:(char *)name A:(double *)A m:(int)m n:(int)n andSparse:(int) sparse{
    
    int i, j;
    
    printf("%s = [...\n", name);
    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++)
            if ((sparse == 1) && (A[i+j*m] == 0))
                printf("         0");
            else
                printf("  % 9.4f", A[i+j*m]);
        printf(",\n");
    }
    printf("];\n");
}

-(double) unifWithLower:(double)lower andUpper:(double)upper {
    return lower + ((upper - lower)*rand())/RAND_MAX;
}

/* Next function is from numerical recipes in C. */
#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define NTAB 32
#define NDIV (1+(IM-1)/NTAB)
#define EPS 1.2e-7
#define RNMX (1.0-EPS)
-(float) ran1WithIdum:(long*)idum andReset:(int)reset {
    
    int j;
    long k;
    static long iy=0;
    static long iv[NTAB];
    float temp;
    
    if (reset) {
        iy = 0;
    }
    
    if (*idum<=0||!iy) {
        if (-(*idum)<1)*idum=1;
        else *idum=-(*idum);
        for (j=NTAB+7; j>=0; j--) {
            k = (*idum)/IQ;
            *idum=IA*(*idum-k*IQ)-IR*k;
            if (*idum<0)*idum+=IM;
            if (j<NTAB)iv[j]=*idum;
        }
        iy = iv[0];
    }
    k = (*idum)/IQ;
    *idum = IA*(*idum-k*IQ)-IR*k;
    if (*idum<0)*idum += IM;
    j = iy/NDIV;
    iy = iv[j];
    iv[j] = *idum;
    if ((temp=AM*iy)> RNMX) return RNMX;
    else return temp;
}


/* Next function is from numerical recipes in C. */
-(float) randn_internalWithIdum:(long *)idum andReset:(int)reset {
    static int iset=0;
    static float gset;
    float fac, rsq, v1, v2;
    
    if (reset) {
        iset = 0;
    }
    
    if (iset==0) {
        do {
            v1 = 2.0*[self ran1WithIdum:idum andReset:reset]-1.0;
            v2 = 2.0*[self ran1WithIdum:idum andReset:reset]-1.0;
            rsq = v1*v1+v2*v2;
        } while(rsq >= 1.0 || rsq == 0.0);
        
        fac = sqrt(-2.0*log(rsq)/rsq);
        gset = v1*fac;
        iset = 1;
        return v2*fac;
    } else {
        iset = 0;
        return gset;
    }
}

-(double) randn {
    return [self randn_internalWithIdum:&global_seed andReset:0];
}


-(void) reset_rand {
    srand(15);
    global_seed = 1;
    [self randn_internalWithIdum:&global_seed andReset:1];
}

@end
