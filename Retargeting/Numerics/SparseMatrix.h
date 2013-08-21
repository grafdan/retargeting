//
//  SparseMatrix.h
//  Retargeting
//
//  Created by Daniel Graf on 30.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "Matrix.h"

@interface SparseMatrix : Matrix {
    @protected
    NSMutableArray * data;

}
// initialization
-(SparseMatrix *)initWithSizeRows:(int)aRows andColumns:(int)aColumns;

// access
-(double)entryAtRow:(int)row andColumn:(int)column;
-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value;

@end
