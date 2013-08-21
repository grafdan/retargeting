//
//  FastCCSMatrix.h
//  Retargeting
//
//  Created by Daniel Graf on 06.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "Matrix.h"

@interface FastCCSMatrix : Matrix {
    int maxColSize;
    double * values;
    int * indices;
    int * colSizes;
}
// initialization
-(FastCCSMatrix *)initWithSizeRows:(int)aRows columns:(int)aColumns andMaxColSize:(int)aMaxColSize;

// access
-(double)entryAtRow:(int)row andColumn:(int)column;
-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value;

// calculations
-(Matrix *)innerProduct;

@end
