//
//  Matrix.h
//  Retargeting
//
//  Created by Daniel Graf on 30.10.12.
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

@interface Matrix : NSObject {
    @protected
    double * rawData; // saves the entries internally as rowMajor
    bool needsMemoryFree;
//    NSMutableArray * data;
    int columns;
    int rows;
}
@property (nonatomic,readonly) int columns, rows;

// initialization
-(Matrix *)initWithSizeRows:(int)aRows andColumns:(int)aColumns;
-(Matrix *)initVectorWithSize:(int)aSize;
-(Matrix *)initFromRowMajorDataWithoutCopying:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns;
-(Matrix *)initFromColumnMajorData:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns;
-(Matrix *)initFromRowMajorData:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns;

// standard matrices
+(Matrix *) emptyMatrix;
+(Matrix *) onesWithSizeRows:(int)aRows andColumns:(int)aColumns;
+(Matrix *) onesVectorWithSize:(int)aSize;

// access
-(double)entryAtRow:(int)row andColumn:(int)column;
-(double)entryAtIndex:(int)index;
-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value;
-(void)setEntryAtIndex:(int)index toValue:(double)value;
-(void)setAllEntriesToValue:(double)value;
-(double)first;
-(double)last;

// calculations
-(Matrix *)multiplyWith:(Matrix *)other;
-(Matrix *)add:(Matrix *)other;
-(Matrix *)subtract:(Matrix *)other;
-(Matrix *)scalarMultiply:(double)factor;
-(Matrix *)scalarAdd:(double)summand;
-(Matrix *)innerProduct;
-(Matrix *)outerProduct;

// transformations
-(Matrix *)transpose;
-(Matrix *)concatTo:(Matrix *)other;
-(Matrix *)stackTo:(Matrix *)other;

// submatrices
-(Matrix *)subvectorFromIndex:(int)startIndex withLength:(int)length;


// analyze
-(double)MaxNorm;
-(double)L2Norm;
-(double)L0Norm;
-(double)sum;

// extensions
-(Matrix *)splineUpsampling:(int)samplingFactor;
-(Matrix *)prefixSums;

//export (callee has to free the memory)
// just return the pointer -> no new memory
-(double *)rawDataVector;
-(double *)rawDataAsRowMajor;

// actually copying into a newly allocated block of memory
-(double *)rawDataAsColumnMajor;

//comparison
-(bool) equals:(Matrix *)other;
-(int) size;

// printing
-(void)printMatrixWithName:(NSString *)name;
-(void)printMatrixSpyWithName:(NSString *)name;
-(void)printMatrixAsMatlabCodeWithName:(NSString *)name;
-(void)printMatrixAsCCodeWithName:(NSString *)name;
@end
