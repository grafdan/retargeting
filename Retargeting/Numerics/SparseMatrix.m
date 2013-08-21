//
//  SparseMatrix.m
//  Retargeting
//
//  Created by Daniel Graf on 30.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "SparseMatrix.h"
#import "Matrix.h"

@implementation SparseMatrix

// initialization

-(SparseMatrix *)initWithSizeRows:(int)aRows andColumns:(int)aColumns {
    self = [self init];
    columns = aColumns;
    rows = aRows;
    data = [[NSMutableArray alloc] initWithCapacity:super.columns];
    for(int i=0;i<super.columns;i++) {
        data[i] = [[NSMutableDictionary alloc] initWithCapacity:super.rows];
    }
    return self;
}

// access

-(double)entryAtRow:(int)row andColumn:(int)column {
    double result;
    NSMutableDictionary * dict = data[column];
    result = [[dict objectForKey:[NSNumber numberWithInt:row]] doubleValue];
    return result;
}

-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value {
    NSMutableDictionary * dict = data[column];
    [dict setObject:[NSNumber numberWithDouble:value] forKey:[NSNumber numberWithInt:row]];
}

// calculations

-(Matrix *)innerProduct {
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.columns andColumns:self.columns];
    for(int rc = 0; rc<columns; rc++) {
        NSMutableDictionary * dict = data[rc];
        NSNumber * row;
        for (row in dict) {
            int r = [row intValue];
            for(int cc=0; cc<columns; cc++) {
                [result setEntryAtRow:rc andColumn:cc toValue:
                 [result entryAtRow:rc andColumn:cc] +
                 [[dict objectForKey:row] doubleValue] * [self entryAtRow:r andColumn:cc]];
            }
        }
    }
    return result;
}

@end
