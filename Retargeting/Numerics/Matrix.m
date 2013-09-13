//
//  Matrix.m
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

#import "Matrix.h"

@implementation Matrix

@synthesize columns, rows;

// initialization

// initialization
-(Matrix *)initWithSizeRows:(int)aRows andColumns:(int)aColumns {
    self = [super init];
    int size = MAX(1, aRows*aColumns*sizeof(double));
    rawData = malloc(size);
    memset(rawData, 0, size);
    needsMemoryFree = YES;
    rows = aRows;
    columns = aColumns;
    return self;
}

-(Matrix *)initVectorWithSize:(int)aSize {
    self = [self initWithSizeRows:aSize andColumns:1];
    return self;
}

-(Matrix *)initFromRowMajorDataWithoutCopying:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns {
    self = [super init];
    needsMemoryFree = YES;
    rows = aRows;
    columns = aColumns;
    rawData = aRawData;
    return self;
}

-(Matrix *)initFromColumnMajorData:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns {
    self = [self initWithSizeRows:aRows andColumns:aColumns];
    for(int c=0;c<columns;c++) {
        for(int r=0;r<rows;r++) {
            [self setEntryAtRow:r andColumn:c toValue:aRawData[c*rows + r]];
        }
    }
    return self;
}

-(Matrix *)initFromRowMajorData:(double *)aRawData withRows:(int)aRows andColumns:(int)aColumns {
    self = [self initWithSizeRows:aRows andColumns:aColumns];
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            [self setEntryAtRow:r andColumn:c toValue:aRawData[r*columns + c]];
        }
    }
    return self;
}

// standard matrices

+(Matrix *) emptyMatrix {
    Matrix * M = [[Matrix alloc] initWithSizeRows:0 andColumns:0];
    return M;
}
+(Matrix *) onesWithSizeRows:(int)aRows andColumns:(int)aColumns {
    Matrix * M = [[Matrix alloc] initWithSizeRows:aRows andColumns:aColumns];
    [M setAllEntriesToValue:1.0];
    return M;
}
+(Matrix *) onesVectorWithSize:(int)aSize {
    return [Matrix onesWithSizeRows:aSize andColumns:1];
}

// access
-(double)entryAtRow:(int)row andColumn:(int)column {
    return rawData[row*columns + column];
}
-(double)entryAtIndex:(int)index {
    return [self entryAtRow:index andColumn:0];
}
-(void)setEntryAtRow:(int)row andColumn:(int)column toValue:(double)value {
    rawData[row*columns + column] = value;
}
-(void)setEntryAtIndex:(int)index toValue:(double)value {
    [self setEntryAtRow:index andColumn:0 toValue:value];
}

-(void)setAllEntriesToValue:(double)value {
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [self setEntryAtRow:r andColumn:c toValue:value];
        }
    }
    
}
-(double)first {
    return [self entryAtRow:0 andColumn:0];
}
-(double)last {
    return [self entryAtRow:rows-1 andColumn:columns-1];
}

// calculations

-(Matrix *)multiplyWith:(Matrix *)other {
    if(self.columns != other.rows) {
        [NSException raise:@"Dimension Mismatch for Multiplication" format:@" when trying to multiply %dx%d with %dx%d",self.rows,self.columns,other.rows,other.columns];
        printf("Matrix dimension mismatch at multiplicaton!\n");
        return [Matrix emptyMatrix];
    }
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:other.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<other.columns;c++) {
            for(int k=0;k<self.columns;k++) {
                [result setEntryAtRow:r andColumn:c toValue:
                 [result entryAtRow:r andColumn:c] +
                 [self entryAtRow:r andColumn:k] * [other entryAtRow:k andColumn:c]];
            }
        }
    }
    return result;
}

-(Matrix *)add:(Matrix *)other {
    if((self.rows != other.rows) || (self.columns != other.columns)) {
        [NSException raise:@"Dimension Mismatch for Addition" format:@" when trying to add %dx%d to %dx%d",self.rows,self.columns,other.rows,other.columns];
//        printf("Matrix dimension mismatch at addition!\n");
        return [Matrix emptyMatrix];
    }
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:self.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:
             [self entryAtRow:r andColumn:c] + [other entryAtRow:r andColumn:c]];
        }
    }
    return result;    
}

-(Matrix *)subtract:(Matrix *)other {
    if((self.rows != other.rows) || (self.columns != other.columns)) {
        [NSException raise:@"Dimension Mismatch for Subtraction" format:@" when trying to subtract %dx%d from %dx%d",self.rows,self.columns,other.rows,other.columns];
//        printf("Matrix dimension mismatch at subtraction!\n");
        return [Matrix emptyMatrix];
    }
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:self.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:
             [self entryAtRow:r andColumn:c] - [other entryAtRow:r andColumn:c]];
        }
    }
    return result;
}
-(Matrix *)scalarMultiply:(double)factor {
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:self.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:
             [self entryAtRow:r andColumn:c]*factor];
        }
    }
    return result;
}
-(Matrix *)scalarAdd:(double)summand {
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:self.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:
             [self entryAtRow:r andColumn:c]+summand];
        }
    }
    return result;
}

-(Matrix *)innerProduct {
    return [[self transpose] multiplyWith:self];
}

-(Matrix *)outerProduct {
    return [self multiplyWith:[self transpose]];
}

// transformations

-(Matrix *)transpose {
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.columns andColumns:self.rows];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:c andColumn:r toValue:[self entryAtRow:r andColumn:c]];
        }
    }
    return result;    
}

-(Matrix *)concatTo:(Matrix *)other {
    if(self.rows != other.rows) {
        [NSException raise:@"Dimension Mismatch for Concatenation" format:@"Row counts %d and %d do not match",self.rows,other.rows];
//        printf("Matrix dimension mismatch at concatenation!\n");
        return [Matrix emptyMatrix];
    }
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows andColumns:self.columns+other.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:[self entryAtRow:r andColumn:c]];
        }
    }
    for(int r=0;r<other.rows;r++) {
        for(int c=0;c<other.columns;c++) {
            [result setEntryAtRow:r andColumn:c+self.columns toValue:[other entryAtRow:r andColumn:c]];
        }
    }
    return result;
}

-(Matrix *)stackTo:(Matrix *)other {
    if(self.columns != other.columns) {
        [NSException raise:@"Dimension Mismatch for Stacking" format:@"column counts %d and %d do not match",self.columns,other.columns];
//        printf("Matrix dimension mismatch at stacking!\n");
        return [Matrix emptyMatrix];
    }
    Matrix * result = [[Matrix alloc] initWithSizeRows:self.rows+other.rows andColumns:self.columns];
    for(int r=0;r<self.rows;r++) {
        for(int c=0;c<self.columns;c++) {
            [result setEntryAtRow:r andColumn:c toValue:[self entryAtRow:r andColumn:c]];
        }
    }
    for(int r=0;r<other.rows;r++) {
        for(int c=0;c<other.columns;c++) {
            [result setEntryAtRow:r+self.rows andColumn:c toValue:[other entryAtRow:r andColumn:c]];
        }
    }
    return result;
}

// submatrices
-(Matrix *)subvectorFromIndex:(int)startIndex withLength:(int)length {
    Matrix * result = [[Matrix alloc] initVectorWithSize:length];
    for(int i=0;i<length;i++) {
        [result setEntryAtIndex:i toValue:[self entryAtIndex:startIndex+i]];
    }
    return result;
}


// analyze

-(double)MaxNorm {
    double result = 0;
    double value = 0;
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            value = [self entryAtRow:r andColumn:c];
            if(result < ABS(value))
                result = ABS(value);
        }
    }
    return result;
}

-(double)L2Norm {
    double result = 0;
    double value = 0;
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            value = [self entryAtRow:r andColumn:c];
            result += ABS(value)*ABS(value);
        }
    }
    result = sqrt(result);
    return result;
}

-(double)L0Norm {
    double result = 0;
    double value = 0;
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            value = [self entryAtRow:r andColumn:c];
            result += ABS(value);
        }
    }
    return result;
}

-(double)sum {
    return [self L0Norm];
}

//export (callee has to free the memory)

// export
-(double *)rawDataVector {
    return rawData;
}

-(double *)rawDataAsRowMajor {
    return rawData;
}

-(double *)rawDataAsColumnMajor {
    double * resRawData = malloc(rows*columns*sizeof(double));
    needsMemoryFree = YES;
    for(int c=0;c<columns;c++) {
        for(int r=0;r<rows;r++) {
            resRawData[c*rows + r] = [self entryAtRow:r andColumn:c];
        }
    }
    return resRawData;
}

//-(double *)rawDataAsRowMajor {
//    double * rawData = malloc(rows*columns*sizeof(double));
//    for(int r=0;r<rows;r++) {
//        for(int c=0;c<columns;c++) {
//            rawData[r*columns + c] = [self entryAtRow:r andColumn:c];
//        }
//    }
//    return rawData;
//}

// extensions
-(double)SplineCubicInterpolateWithY0:(double)y0 y1:(double)y1 y2:(double)y2 y3:(double)y3 t:(double) t andSamplingFactor:(double)samplingFactor
{
    
    return 1.0/6.0*(t*t*t*(-y0+3*y1-3*y2+y3) + t*t*(3*y0-6*y1+3*y2) + t*(-3*y0+3*y2) + (y0+4*y1+y2));
    
//    //probably very inefficient
//    double ts[4] = {t*t*t,t*t,t,1};
//    double Mdata[16] = {-1,3,-3,1,
//                        3,-6,3,0,
//                        -3,0,3,0,
//                        1,4,1,0};
//
//    double ps[4] = {y0,y1,y2,y3};
//
//    // t' * M * ps
//    
//    Matrix * tv = [[Matrix alloc] initFromColumnMajorData:ts withRows:4 andColumns:1];
//    Matrix * M = [[Matrix alloc] initFromRowMajorData:Mdata withRows:4 andColumns:4];
//    [M printMatrixWithName:@"M"];
//    Matrix * pv = [[Matrix alloc] initFromColumnMajorData:ps withRows:4 andColumns:1];
//    Matrix * res = [[[tv transpose] multiplyWith:[M multiplyWith:pv]] scalarMultiply:1.0/(6.0)];
//    return [res entryAtRow:0 andColumn:0];
}

-(Matrix *)splineUpsampling:(int)samplingFactor {
    if(columns > 1) {
        printf("upsampling only works for column vectors");
        return nil;
    }
    
    Matrix * res = [[Matrix alloc] initWithSizeRows:samplingFactor*([self size]-1)+1 andColumns:1];
    for(int i=0;i<rows-1;i++) {
        // prepare the values
        double y0,y1,y2,y3;
        if(i-1<0) y0 = [self entryAtRow:0 andColumn:0] - ([self entryAtRow:1 andColumn:0]-[self entryAtRow:0 andColumn:0]);
        else y0 = [self entryAtRow:i-1 andColumn:0];
        y1 = [self entryAtRow:i andColumn:0];
        y2 = [self entryAtRow:i+1 andColumn:0];
        if(i+2>=rows) y3 = [self entryAtRow:i+1 andColumn:0] + ([self entryAtRow:i+1 andColumn:0]-[self entryAtRow:i andColumn:0]);
        else y3 = [self entryAtRow:i+2 andColumn:0];
        
        for(int j=0;j<samplingFactor;j++) {
            double t = 1.0/samplingFactor*j;
            [res setEntryAtRow:samplingFactor*i+j andColumn:0 toValue:[self SplineCubicInterpolateWithY0:y0 y1:y1 y2:y2 y3:y3 t:t andSamplingFactor:samplingFactor]];
        }
    }
    [res setEntryAtRow:[res size]-1 andColumn:0 toValue:[self entryAtRow:[self size]-1 andColumn:0]];
    return res;
}

-(Matrix *)prefixSums {
    if(columns > 1) {
        printf("upsampling only works for column vectors");
        return nil;
    }
    Matrix * res = [[Matrix alloc] initWithSizeRows:[self size]+1 andColumns:1];
    [res setEntryAtRow:0 andColumn:0 toValue:0];
    for(int i=0;i<rows;i++) {
        [res setEntryAtRow:i+1 andColumn:0 toValue:[self entryAtRow:i andColumn:0]+[res entryAtRow:i andColumn:0]];
    }
    return res;    
}

//comparison

-(bool) equals:(Matrix *)other {
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            if(ABS([self entryAtRow:r andColumn:c]-[other entryAtRow:r andColumn:c])>1e-5) return false;
        }
    }
    return true;
}

-(int) size {
    return rows*columns;
}

// printing

-(void)printMatrixWithName:(NSString *)name {
    for(int c=0;c<columns;c++) printf("------");
    printf("\n");
    printf("Matrix %s (%d x %d)\n",[name cStringUsingEncoding:NSASCIIStringEncoding], rows,columns);
    for(int c=0;c<columns;c++) printf("------");
    printf("\n");
    for(int r=0;r<rows;r++) {
        printf("|");
        for(int c=0;c<columns;c++) {
            printf(" %.3lf",[self entryAtRow:r andColumn:c]);
        }
        printf(" |\n");
    }
    for(int c=0;c<columns;c++) printf("------");
    printf("\n");
}

-(void)printMatrixSpyWithName:(NSString *)name {
    printf(" ");
    for(int c=0;c<columns;c++) printf("-");
    printf(" \n");
    printf("Matrix %s (%d x %d)\n",[name cStringUsingEncoding:NSASCIIStringEncoding], rows,columns);
    printf(" ");
    for(int c=0;c<columns;c++) printf("-");
    printf(" \n");
    for(int r=0;r<rows;r++) {
        printf("|");
        for(int c=0;c<columns;c++) {
            printf("%c",(ABS([self entryAtRow:r andColumn:c])>1e-5)?'*':' ');
        }
        printf("|\n");
    }
    printf(" ");
    for(int c=0;c<columns;c++) printf("-");
    printf(" \n");    
}

-(void)printMatrixAsMatlabCodeWithName:(NSString *)name {
    printf("%s = [",[name cStringUsingEncoding:NSASCIIStringEncoding]);
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            printf("%lf%c",[self entryAtRow:r andColumn:c],
                   (c==columns-1)?((r==rows-1)?']':';'):',');
        }
    }
    printf(";\n");
}

-(void)printMatrixAsCCodeWithName:(NSString *)name {
    printf("double %s[%d] = {",[name cStringUsingEncoding:NSASCIIStringEncoding],
           rows*columns);
    for(int r=0;r<rows;r++) {
        for(int c=0;c<columns;c++) {
            printf("%lf%c",[self entryAtRow:r andColumn:c],
                   (c==columns-1 && (r==rows-1))?'}':',');
        }
    }
    printf(";\n");
}

-(void)dealloc {
    if(needsMemoryFree) free(rawData);
}

-(id)copyWithZone:(NSZone *)zone
{
    Matrix * another = [[Matrix alloc] initFromRowMajorData:[self rawDataAsRowMajor] withRows:[self rows] andColumns:[self columns]];
    return another;
}
@end
