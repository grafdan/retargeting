//
//  Grid.m
//  Retargeting
//
//  Created by Daniel Graf on 12.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "Grid.h"
@implementation Grid {
    int M,N;
    int C; // # of cells
//    int T; // # of triangles;
//    Triangle3D *  triangles;
//    Triangle3D *  uniform_triangles;
}
@synthesize triangles = _triangles;
@synthesize T = _T;
@synthesize uniformTriangles = _uniform_triangles;
@synthesize showGrid = _showGrid;
@synthesize needsRecalc = _needsRecalc;

-(Grid *)init {
    self = [super init];
    M=0;
    N=0;
    return self;
}

- (void) printInfo {
    printf("grid with %d triangles\n",self.T);
    int i = 0;
    printf("first grid triangle point: %f %f\n",self.triangles[i].v1.x, self.triangles[i].v1.y);
    printf("first uniform triangle point: %f %f\n",self.uniformTriangles[i].v1.x, self.uniformTriangles[i].v1.y);
    i = self.T-1;
    printf("last grid triangle point: %f %f\n",self.triangles[i].v1.x, self.triangles[i].v1.y);
    printf("last uniform triangle point: %f %f\n",self.uniformTriangles[i].v1.x, self.uniformTriangles[i].v1.y);
}

-(void) createGridWithRows:(Matrix *)aRows andColumns:(Matrix *)aColumns {
    [self createGridWithRows:aRows columns:aColumns inRect:CGRectMake(0, 0, [aColumns last], [aRows last]) andUniformRect:CGRectMake(0, 0, 1.0, 1.0)];
}
-(void) createGridWithRows:(Matrix *)aRows columns:(Matrix *)aColumns inRect:(CGRect)aRect andUniformRect:(CGRect) aUniformRect {
    int nM = [aRows size]-1;
    int nN = [aColumns size]-1;
//    printf("aRect x %f y %f\n",aRect.origin.x, aRect.origin.y);
//    printf("%f %f\n",[aRows last], [aColumns last]);
    
//    [aRows printMatrixWithName:@"aRows"];
    if(nM != M || nN != N) { //allocate new memory
        N = nN;
        M = nM;
        C = N*M; // # of cells
        self.T = 2*C; // # of triangles;
        
        if(self.triangles) free(self.triangles);
        if(self.uniformTriangles) free(self.uniformTriangles);
        self.triangles = malloc(self.T*sizeof(Triangle3D));
        self.uniformTriangles = malloc(self.T*sizeof(Triangle3D));
    } else {
        // nothing changes -> if even the rows and columns are the same we can stop immediately
        if([aRows equals:rows] && [aColumns equals:columns] && !self.needsRecalc) {
//            printf("nothing changed for the grid\n");
//            return;
            // -> not possible anymore since the rectangles could have changed...
        }
    }
    
    rows = [aRows copy];
    columns = [aColumns copy];

    // apply rectangle transformations to the rows and columns
    double r_offset = [rows first];
    double r_span = [rows last] - [rows first];
    for(int i = 0; i < [rows size]; i++) {
        [rows setEntryAtIndex:i toValue:(1.0*([rows entryAtIndex:i]-r_offset)/r_span*aRect.size.height + aRect.origin.y)];
    }
    double c_offset = [columns first];
    double c_span = [columns last] - [columns first];
    for(int i = 0; i < [columns size]; i++) {
        [columns setEntryAtIndex:i toValue:(1.0*([columns entryAtIndex:i]-c_offset)/c_span*aRect.size.width + aRect.origin.x)];
    }
//    printf("first rows and columns = %f %f\n",[rows first], [columns first]);
//    printf("r_span %f , c_span %f\n",r_span, c_span);
//    [columns printMatrixWithName:@"c rescaled"];
    // now we have allocated the memory and can start creating the coordinates

    //    printf("row sum %lf, col sum %lf",[aRows sum], [aColumns sum]);
    self.needsRecalc = NO;
    
    double x,xp,y,yp;
    double dTexY = 1.0/M*aUniformRect.size.height;
    double dTexX = 1.0/N*aUniformRect.size.width;
    double texOffX = aUniformRect.origin.x;
    double texOffY = aUniformRect.origin.y;
    
    int ti=0;
    for (int i=0; i<M; i++) {
        y = [rows entryAtRow:i andColumn:0];
        yp = [rows entryAtRow:i+1 andColumn:0];
        for(int j=0; j<N; j++) {
            x = [columns entryAtRow:j andColumn:0];
            xp = [columns entryAtRow:j+1 andColumn:0];
            
            // lower triange
            self.triangles[ti].v1 = Vertex3DMake(x, y, 0);
            self.triangles[ti].v2 = Vertex3DMake(xp, y, 0);
            self.triangles[ti].v3 = Vertex3DMake(x, yp, 0);
            if(self.showGrid) {
                self.uniformTriangles[ti].v1 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v2 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v3 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
            } else {
                self.uniformTriangles[ti].v1 = Vertex3DMake(j*dTexX+texOffX, i*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v2 = Vertex3DMake((j+1)*dTexX+texOffX, i*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v3 = Vertex3DMake(j*dTexX+texOffX, (i+1)*dTexY+texOffY, 0);
            }

            ti++;
            
            // upper triange
            self.triangles[ti].v1 = Vertex3DMake(xp, yp, 0);
            self.triangles[ti].v2 = Vertex3DMake(x, yp, 0);
            self.triangles[ti].v3 = Vertex3DMake(xp, y, 0);
            if(self.showGrid) {
                self.uniformTriangles[ti].v1 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v2 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v3 = Vertex3DMake((j+0.5)*dTexX+texOffX, (i+0.5)*dTexY+texOffY, 0);
            } else {
                self.uniformTriangles[ti].v1 = Vertex3DMake((j+1)*dTexX+texOffX, (i+1)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v2 = Vertex3DMake(j*dTexX+texOffX, (i+1)*dTexY+texOffY, 0);
                self.uniformTriangles[ti].v3 = Vertex3DMake((j+1)*dTexX+texOffX, i*dTexY+texOffY, 0);
            }
            ti++;
        }
    }
    
}
-(CGPoint)gridCoordinatesForUniformPoint:(CGPoint)p {
//    printf("point p %lf %lf\n",p.x,p.y);
    if(p.x<0 || p.x > 1 || p.y < 0 || p.x > 1) {
        printf("point out of bounds");
    }
    int m = p.y*M;
    int n = p.x*N;

    //border cases
    if(n==N) n--;
    if(m==M) m--;
    if(m>=M || n>=N || n<0 || m<0) {
        printf("index out of bounds");
    }
    double udx = 1.0/N;
    double udy = 1.0/M;
    double dx = (p.x-n*udx)/udx;
    double dy = (p.y-m*udy)/udy;
//    printf("dx %lf dy %lf\n",dx,dy);
//    printf("%lf %lf\n",[columns entryAtIndex:n],[columns entryAtIndex:n+1]);
    double x = [columns entryAtIndex:n] + dx*([columns entryAtIndex:n+1]-[columns entryAtIndex:n]);
    double y = [rows entryAtIndex:m] + dy*([rows entryAtIndex:m+1]-[rows entryAtIndex:m]);
//    printf("p mit x %lf y %lf\n",x,y);
    return CGPointMake(x, [rows last]-y);
}
-(CGPoint)uniformCoordinatesForGridPoint:(CGPoint)p {
    // takes a point out of [0,1]'2
    double x = p.x*[columns last];
    double y = (1.0-p.y)*[rows last];
//    [columns printMatrixWithName:@"columns"];
//    [rows printMatrixWithName:@"rows"];
    int m = 0,n = 0; // grid indices
    //search vertically
    for(m=1;m<M;m++) {
        if([rows entryAtIndex:m] > y) break;
    }
    m--;
    //search horizontally
    for(n=1;n<N;n++) {
        if([columns entryAtIndex:n] > x) break;
    }
    n--;
    double dx = ([columns entryAtIndex:n+1]-[columns entryAtIndex:n]);
    double dy = ([rows entryAtIndex:m+1]-[rows entryAtIndex:m]);
    
    //prohibit division by (almost) zero -> happens if last column is cropped
    if(dx < 1e-7)
        dx = 1;
    if(dy < 1e-7)
        dy = 1;
    
    double udx = 1.0/N;
    double udy = 1.0/M;
//    assert([columns entryAtIndex:n] <= x);
//    assert([columns entryAtIndex:n+1]>= x);
    double ux = n*udx + (x-[columns entryAtIndex:n])/dx*udx;
    double uy = m*udy + (y-[rows entryAtIndex:m])/dy*udy;
//    [columns printMatrixWithName:@"columns"];
    // clamping
    if(ux<0) ux = 0;
    if(ux>1) ux = 1;
    if(uy<0) uy = 0;
    if(uy>1) uy = 1;
    
//    printf("ux %f = n %d * udx %f\n",ux,n,udx);
//    printf("x %f, startpoint %f, dx %f\n",x,[columns entryAtIndex:n],dx);
    CGPoint res = CGPointMake(ux, uy);
//    printf("input point %f %f and output %f %f\n",p.x,p.y,res.x,res.y);
//    printf("grid cell n %d m %d\n",n,m);
    return res;
}
-(void)setShowGrid:(bool)showGrid {
    _showGrid = showGrid;
    [self setNeedsRecalc:YES];
}
-(void) dealloc {
    free(self.triangles);
    free(self.uniformTriangles);
}
@end
