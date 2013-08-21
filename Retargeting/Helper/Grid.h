//
//  Grid.h
//  Retargeting
//
//  Created by Daniel Graf on 12.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Matrix.h"
#import "OpenGLCommon.h"

@interface Grid : NSObject {
    Matrix * rows;
    Matrix * columns;
}
@property (nonatomic) Triangle3D * triangles;
@property (nonatomic) Triangle3D * uniformTriangles;
@property (nonatomic) int T;
@property (nonatomic) bool showGrid;
@property (nonatomic) BOOL needsRecalc;

-(Grid *)init;
-(void) printInfo;
-(void) createGridWithRows:(Matrix *)aRows andColumns:(Matrix *)aColumns;
-(void) createGridWithRows:(Matrix *)aRows columns:(Matrix *)aColumns inRect:(CGRect)aRect andUniformRect:(CGRect)aUniformRect;
-(CGPoint)gridCoordinatesForUniformPoint:(CGPoint)p;
-(CGPoint)uniformCoordinatesForGridPoint:(CGPoint)p;
@end
