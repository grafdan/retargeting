//
//  MatrixTests.m
//  Retargeting
//
//  Created by Daniel Graf on 20.11.12.
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

#import "MatrixTests.h"
#define DEBUG_PRINT 0
@implementation MatrixTests

-(void)printTesting {
    // first simple matrix for print testing
    Matrix * M = [[Matrix alloc] initWithSizeRows:5 andColumns:4];
    [M setEntryAtRow:1 andColumn:2 toValue:1.2];
    [M setEntryAtRow:4 andColumn:3 toValue:3.32];
    [M setEntryAtRow:2 andColumn:1 toValue:2.02];
    [M setEntryAtRow:0 andColumn:1 toValue:0.2];
    [M printMatrixWithName:@"M simple print"];
    [M printMatrixSpyWithName:@"M spy print"];
    [M printMatrixAsMatlabCodeWithName:@"M_matlab_print"];
    [M printMatrixAsCCodeWithName:@"M_C_print"];
}

-(void)testMultiplication {
    // ( 1 2 ) * (2 0) = (4  16)
    // ( 3 4 )   (1 8)   (10 32)
    
    Matrix * A = [[Matrix alloc] initWithSizeRows:2 andColumns:2];
    [A setEntryAtRow:0 andColumn:0 toValue:1];
    [A setEntryAtRow:1 andColumn:0 toValue:3];
    [A setEntryAtRow:0 andColumn:1 toValue:2];
    [A setEntryAtRow:1 andColumn:1 toValue:4];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    
    double Bdata[4] = {2,0,1,8};
    Matrix * B = [[Matrix alloc] initFromRowMajorData:Bdata withRows:2 andColumns:2];
    if(DEBUG_PRINT) [B printMatrixWithName:@"B"];
    
    Matrix * C = [A multiplyWith:B];
    if(DEBUG_PRINT) [C printMatrixWithName:@"C = A * B"];
    
    double Soldata[4] = {4,16,10,32};
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:Soldata withRows:2 andColumns:2];
    STAssertTrue([C equals:Sol], @"Matrix Multiplication of square Matrices");
    
    
    // (1 0 2)   (5)   (9 )
    // (0 1 1) * (9) = (11)
    //           (2)
    double Ddata[6] = {1,0,2,0,1,1};
    Matrix * D = [[Matrix alloc] initFromRowMajorData:Ddata withRows:2 andColumns:3];
    if(DEBUG_PRINT) [D printMatrixWithName:@"D"];
    double Edata[3] = {5,9,2};
    Matrix * E = [[Matrix alloc] initFromColumnMajorData:Edata withRows:3 andColumns:1];
    if(DEBUG_PRINT) [E printMatrixWithName:@"E"];
    
    // dimension mismatch
    STAssertThrows([E multiplyWith:D], @"Mismatching Multiplication");
    
    Matrix * F;
    F = [D multiplyWith:E];
    if(DEBUG_PRINT) [F printMatrixWithName:@"F = D * E"];

    Sol = [[Matrix alloc] initWithSizeRows:2 andColumns:1];
    [Sol setEntryAtRow:0 andColumn:0 toValue:9];
    [Sol setEntryAtRow:0 andColumn:1 toValue:11];
    STAssertTrue([F equals:Sol], @"Matrix Multiplication of non-square Matrices");
}

-(void)testAddSub {
    // (2 3 0) + (1 5 5) = (3 8 5 )
    // (1 5 3)   (0 2 7)   (1 7 10)
    double Adata[6] = {2,3,0,1,5,3};
    Matrix * A = [[Matrix alloc] initFromRowMajorData:Adata withRows:2 andColumns:3];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    double Bdata[6] = {1,0,5,2,5,7};
    Matrix * B = [[Matrix alloc] initFromColumnMajorData:Bdata withRows:2 andColumns:3];
    if(DEBUG_PRINT) [B printMatrixWithName:@"B"];
    
    Matrix * C = [A add:B];
    if(DEBUG_PRINT) [C printMatrixWithName:@"C = A + B"];
    
    double AddSoldata[6] = {3,8,5,1,7,10};
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:AddSoldata withRows:2 andColumns:3];
    STAssertTrue([C equals:Sol], @"Matrix Addition");

    // (1)   (0)   (1 )
    // (0) - (1) = (-1)
    // (0)   (0)   (0 )
    
    double Ddata[3] = {1,0,0};
    Matrix * D = [[Matrix alloc] initFromRowMajorData:Ddata withRows:3 andColumns:1];
    if(DEBUG_PRINT) [D printMatrixWithName:@"D"];
    double Edata[3] = {0,1,0};
    Matrix * E = [[Matrix alloc] initFromColumnMajorData:Edata withRows:3 andColumns:1];
    if(DEBUG_PRINT) [E printMatrixWithName:@"E"];
    
    Matrix * F = [D subtract:E];
    if(DEBUG_PRINT) [F printMatrixWithName:@"F = D - E"];

    double SubSoldata[3] = {1,-1,0};
    Sol = [[Matrix alloc] initFromRowMajorData:SubSoldata withRows:3 andColumns:1];
    STAssertTrue([F equals:Sol], @"Matrix Subtraction");

}

-(void)testNorm {
    // A = (2 3 0)
    //     (1 5 3)
    double Adata[6] = {2,3,0,1,5,3};
    Matrix * A = [[Matrix alloc] initFromRowMajorData:Adata withRows:2 andColumns:3];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    if(DEBUG_PRINT) printf("Max-Norm of A: %lf\n",[A MaxNorm]);
    if(DEBUG_PRINT) printf("L2-Norm of A: %lf\n",[A L2Norm]);
    STAssertEqualsWithAccuracy([A MaxNorm], 5.0000, 1e-3, @"Maximum Norm");
    STAssertEqualsWithAccuracy([A L2Norm], 6.9282, 1e-3, @"L2 Norm");
}

-(void)testTranspose {
    // A = (2 3 0)
    //     (1 5 3)
    double Adata[6] = {2,3,0,1,5,3};
    Matrix * A = [[Matrix alloc] initFromRowMajorData:Adata withRows:2 andColumns:3];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    Matrix * Ap = [A transpose];
    if(DEBUG_PRINT) [Ap printMatrixWithName:@"A transposed"];
    double Soldata[6] = {2,1,3,5,0,3};
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:Soldata withRows:3 andColumns:2];
    STAssertTrue([Ap equals:Sol], @"Transposing");
}

- (void)testConcatStack {
    // (1 2) , (5) = (1 2 5)
    // (3 4)   (6) = (3 4 6)
    double Adata[4] = {1,2,3,4};
    Matrix * A = [[Matrix alloc] initFromRowMajorData:Adata withRows:2 andColumns:2];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    double Bdata[2] = {5,6};
    Matrix * B = [[Matrix alloc] initFromColumnMajorData:Bdata withRows:2 andColumns:1];
    if(DEBUG_PRINT) [B printMatrixWithName:@"B"];
    Matrix * C = [A concatTo:B];
    if(DEBUG_PRINT) [C printMatrixWithName:@"C = [A|B]"];
    
    double ConcatSoldata[6] = {1,2,5,3,4,6};
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:ConcatSoldata withRows:2 andColumns:3];
    STAssertTrue([C equals:Sol], @"Concatenation");
    
    // dimension mismatch
    Matrix * D;
    STAssertThrows([A stackTo:B], @"Stacking mismatch");
    D = [A stackTo:[B transpose]];
    if(DEBUG_PRINT) [D printMatrixWithName:@"D = [A;B']"];
    
    double StackSoldata[6] = {1,2,3,4,5,6};
    Sol = [[Matrix alloc] initFromRowMajorData:StackSoldata withRows:3 andColumns:2];
    STAssertTrue([D equals:Sol], @"Stacking");

}

-(void)testSparseMultiplication {
    // ( 1 2 ) * (2 0) = (4  16)
    // ( 3 4 )   (1 8)   (10 32)
    
    SparseMatrix * A = [[SparseMatrix alloc] initWithSizeRows:2 andColumns:2];
    [A setEntryAtRow:0 andColumn:0 toValue:1];
    [A setEntryAtRow:1 andColumn:0 toValue:3];
    [A setEntryAtRow:0 andColumn:1 toValue:2];
    [A setEntryAtRow:1 andColumn:1 toValue:4];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    
    double Bdata[4] = {2,0,1,8};
    Matrix * B = [[Matrix alloc] initFromRowMajorData:Bdata withRows:2 andColumns:2];
    if(DEBUG_PRINT) [B printMatrixWithName:@"B"];
    
    Matrix * C = [A multiplyWith:B];
    if(DEBUG_PRINT) [C printMatrixWithName:@"C = A * B"];

    double * SolData = malloc(4*sizeof(double));
    SolData[0] = 4;
    SolData[1] = 16;
    SolData[2] = 10;
    SolData[3] = 32;
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:SolData withRows:2 andColumns:2];
    STAssertTrue([C equals:Sol], @"Sparse Multiplication");
}

-(void)testSparseInnerProduct {
    // sparse inner product
    // (5 0 1)    (5 0)   (26 0)
    // (0 3 0)  * (0 3) = (0  9)
    //            (1 0)
    Matrix * D = [[SparseMatrix alloc] initWithSizeRows:3 andColumns:2];
    [D setEntryAtRow:0 andColumn:0 toValue:5.0];
    [D setEntryAtRow:1 andColumn:1 toValue:3.0];
    [D setEntryAtRow:2 andColumn:0 toValue:1.0];
    if(DEBUG_PRINT) [D printMatrixWithName:@"D"];
    Matrix *DpD = [D innerProduct];
    if(DEBUG_PRINT) [DpD printMatrixWithName:@"D'*D (inner product)"];
    Matrix *Sol = [[FastCCSMatrix alloc] initWithSizeRows:2 columns:2 andMaxColSize:1];
    [Sol setEntryAtRow:0 andColumn:0 toValue:26];
    [Sol setEntryAtRow:1 andColumn:1 toValue:9];
    STAssertTrue([DpD equals:Sol], @"Sparse Inner Product");
}

-(void)testFastCCS {
    // ( 1 2 ) * (2 0) = (2 16)
    // ( 3 4 )   (0 8)   (6 32)
    FastCCSMatrix * A = [[FastCCSMatrix alloc] initWithSizeRows:2 columns:2 andMaxColSize:2];
    [A setEntryAtRow:0 andColumn:0 toValue:1];
    [A setEntryAtRow:1 andColumn:0 toValue:3];
    [A setEntryAtRow:1 andColumn:1 toValue:4];
    [A setEntryAtRow:0 andColumn:1 toValue:2];
    if(DEBUG_PRINT) [A printMatrixWithName:@"A"];
    
    FastCCSMatrix * B = [[FastCCSMatrix alloc] initWithSizeRows:2 columns:2 andMaxColSize:1];
    [B setEntryAtRow:0 andColumn:0 toValue:2];
    [B setEntryAtRow:1 andColumn:1 toValue:8];
    if(DEBUG_PRINT) [B printMatrixWithName:@"B"];
    
    Matrix * C = [A multiplyWith:B];
    if(DEBUG_PRINT) [C printMatrixWithName:@"C = A * B"];
    
    //should already be full:
    STAssertThrows([B setEntryAtRow:1 andColumn:0 toValue:3], @"Throws overful column exception");
    
    double * SolData = malloc(4*sizeof(double));
    SolData[0] = 2;
    SolData[1] = 16;
    SolData[2] = 6;
    SolData[3] = 32;
    Matrix * Sol = [[Matrix alloc] initFromRowMajorData:SolData withRows:2 andColumns:2];
    STAssertTrue([C equals:Sol], @"Fast CCS Multiplication");
}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
