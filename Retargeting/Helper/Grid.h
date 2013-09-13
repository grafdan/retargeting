//
//  Grid.h
//  Retargeting
//
//  Created by Daniel Graf on 12.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//
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
