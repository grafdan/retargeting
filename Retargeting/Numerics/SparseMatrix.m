//
//  SparseMatrix.m
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
