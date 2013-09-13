//
//  FastCCSMatrix.m
//  Retargeting
//
//  Created by Daniel Graf on 06.11.12.
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

#import "FastCCSMatrix.h"

@implementation FastCCSMatrix
// initialization
-(FastCCSMatrix *)initWithSizeRows:(int)aRows columns:(int)aColumns andMaxColSize:(int)aMaxColSize {
    self = [super init];

    rows = aRows;
    columns = aColumns;
    maxColSize = aMaxColSize;

    values = malloc(maxColSize*aColumns*sizeof(double));
    indices = malloc(maxColSize*aColumns*sizeof(int));
    colSizes = malloc(aColumns*sizeof(int));
    memset(colSizes, 0, aColumns*sizeof(int));
    return self;
 
}

// access
-(void) debugPrint{
    printf("column sizes: ");
    for (int i=0;i<columns;i++) {
        printf("%d ",colSizes[i]);
    }
    printf("\n");
    printf("indices: ");
    for(int i=0;i<columns*maxColSize;i++) {
        printf("%d ",indices[i]);
    }
    printf("\n");
    printf("values: ");
    for(int i=0;i<columns*maxColSize;i++) {
        printf("%lf ",values[i]);
    }
    printf("\n");
}

#define ROW_NOT_FOUND -1

-(int) searchLowerBoundRowIndex:(int)row inColumn:(int)column {
    // binary search
    int l = column*maxColSize;
    int r = column*maxColSize+colSizes[column]-1;
    int m = 0;
    if(row < indices[l]) return ROW_NOT_FOUND; //request is smaller than all existing rows
    
    while(r>l) {
        m=(l+r)/2;
        if(indices[m] < row) l = m+1;
        else r = m;
    }
    l -= column*maxColSize;
    //printf("result of bin search for row %d in column %d is l %d with indices[l] = %d \n",row,column,l,indices[column*maxColSize + l]);
    return l;
}

-(int) searchRowIndex:(int)row inColumn:(int)column {
    // use the binary search and indicate if not found
    int index = [self searchLowerBoundRowIndex:row inColumn:column];
    if(indices[column*maxColSize + index] != row) return ROW_NOT_FOUND;
    else return index;
}

-(double)entryAtRow:(int)row andColumn:(int)column {
    //printf("CCS EntryAtRow %d %d\n",row,column);
    //simple linear search, not even binary search -> should not be used
    int index = [self searchRowIndex:row inColumn:column];
    if(index == ROW_NOT_FOUND) return 0.0;
    else return values[column*maxColSize + index];
}

-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value {
    //if not make room and insert the new row
    if(colSizes[column]>=maxColSize) {
//        printf("Error adding to many entries to a column of a CCS matrix!\n");
        [NSException raise:@"Overfull column error" format:@" for fast CCS Matrix"];
        return;
    }
    //printf("CCS setEntryAtRow %d %d to value %lf\n",row,column,value);
    //check if new row is bigger than all previous -> then just add it to the end
    if(colSizes[column]==0 || (indices[column*maxColSize+colSizes[column]-1] < row)) {
        colSizes[column]++;
        //printf("can just be added -> now colSize %d\n",colSizes[column]);
        indices[column*maxColSize+colSizes[column]-1] = row;
        values[column*maxColSize+colSizes[column]-1] = value;
        //[self debugPrint];
        return;
    }
    
    // otherwise search whether it is already in there
    int index = [self searchRowIndex:row inColumn:column];
    if(index != ROW_NOT_FOUND) {
        values[column*maxColSize + index] = value;
        return;
    } else {
        // make room for the additional value
        colSizes[column]++;
        index = [self searchLowerBoundRowIndex:row inColumn:column];
        for(int i = column*maxColSize+colSizes[column]-1; i>column*maxColSize+index+1; i--) {
        //    printf("move %d to %d\n",i-1,i);
            indices[i] = indices[i-1];
            values[i] = values[i-1];
        }
        indices[column*maxColSize+index+1] = row;
        values[column*maxColSize+index+1] = value;
    }
}

// calculations

-(Matrix *)innerProduct {
    // calculate Q = K' * K; where K = self and Q is the result
    double * QP = malloc(columns*columns*sizeof(double));
    memset(QP, 0, columns*columns*sizeof(double));
    // this is one of the core parts of the program and takes about 9% of the CPU
    for (int i=0; i<columns; i++) {
        for (int j=0; j<columns; j++) {
            int l=0;
            int colI = colSizes[i];
            int colJ = colSizes[j];
            int imaxCol = i*maxColSize;
            int jmaxCol = j*maxColSize;
            for (int k=0; k<colI && l<colJ; k++) {
                while(l<colJ && indices[jmaxCol+l] < indices[imaxCol+k]) l++;
                if(l<colJ && indices[imaxCol+k] == indices[jmaxCol+l]) {
                    QP[i*columns+j] += values[imaxCol+k] * values[jmaxCol+l];
                }
            }
        }
    }
    
    Matrix * Q = [[Matrix alloc] initFromRowMajorDataWithoutCopying:QP withRows:columns andColumns:columns];
    return Q;
}
-(void)dealloc {
    free(values);
    free(indices);
    free(colSizes);
}

@end
