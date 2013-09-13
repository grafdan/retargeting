//
//  RetargetingSolver.m
//  Retargeting
//
//  Created by Daniel Graf on 23.10.12.
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

#import "RetargetingSolver.h"
#import "CVXGenRangeSolver25x25.h"

#define PRINT_DEBUG 0
#define PRINT_CROP_PREVIEW 0
@implementation RetargetingSolver {
    CVXGenRangeSolver25x25 *rangeSolver;
}

int r(int k, int N) { return (k+1)/N; }
int c(int k, int N) { return k%N; }

-(RetargetingSolver *) init {
    self = [super init];
    rangeSolver = [[CVXGenRangeSolver25x25 alloc] init];
    return self;
}
-(void)dealloc {
    rangeSolver = nil;
}

-(void) printArrayAsMatlabCodeWithName:(NSString *)s Array:(double*) A andLength:(int) len {
    const char * str = [s cStringUsingEncoding:NSASCIIStringEncoding];
    printf("%s = ", str);
    for(int i=0;i<len;i++) printf("%c%lf",(i==0)?'[':',',A[i]);
    printf("];\n");
}

-(RetargetingTask *)solveAndPostprocessWithTask:(RetargetingTask *)task {
    
    // call the appropriate solver
    if(task.croppingFlag) {
        task = [self solveWithCropping:task];
    } else {
        task = [self solveASAPWithTask:task];
    }
    
    // build prefix sums
    //(such that we don't need to that afterwards in the grid creation code
    // and can upsample without problems)
    task.sCols = [task.sCols prefixSums];
    task.sRows = [task.sRows prefixSums];
    
    //upsampling
    
    //    [task.sCols printMatrixAsMatlabCodeWithName:@"sCols"];
    //    [[task.sCols splineUpsampling:4] printMatrixAsMatlabCodeWithName:@"sColsSpline"];
    if(task.upsamplingFactor > 1.0 && !task.croppingFlag) {
            task.sCols = [task.sCols splineUpsampling:task.upsamplingFactor];
            task.sRows = [task.sRows splineUpsampling:task.upsamplingFactor];
    }
    if (task.croppingFlag) {
        // upsample the columns
        //            [task.sCols printMatrixAsMatlabCodeWithName:@"unupsampled"];
        //            [[task.sCols splineUpsampling:task.upsamplingFactor] printMatrixAsMatlabCodeWithName:@"wrong_upsampling"];
        Matrix * leftPad = [[Matrix alloc] initVectorWithSize:task.upsamplingFactor * task.cropBox.left];
        Matrix * colCenter = [task.sCols subvectorFromIndex:task.cropBox.left
                                                 withLength:[task.sCols size]-task.cropBox.left-task.cropBox.right];
        //            [task.sCols printMatrixWithName:@"scols"];
        //            [colCenter printMatrixWithName:@"colCenter"];
        colCenter = [colCenter splineUpsampling:task.upsamplingFactor];
        Matrix * rightPad = [[Matrix alloc] initVectorWithSize:task.upsamplingFactor * task.cropBox.right];
        [rightPad setAllEntriesToValue:[colCenter last]];
        task.sCols = [[leftPad stackTo:colCenter] stackTo:rightPad];
        //            [[task.sCols transpose] printMatrixWithName:@"upsampled solutions"];
        //            [task.sCols printMatrixAsMatlabCodeWithName:@"correct_upsampling"];
        
        // prepare the preview columns
        Matrix * leftCropPreview = [task.cropFirstCols subvectorFromIndex:0
                                                               withLength:task.cropBox.left];
        leftCropPreview = [leftCropPreview prefixSums];
        leftCropPreview = [leftCropPreview splineUpsampling:task.upsamplingFactor];
        if(PRINT_CROP_PREVIEW) [leftCropPreview printMatrixAsMatlabCodeWithName:@"leftCropPreview"];
        double leftOffset = [leftCropPreview last];
        colCenter = [colCenter scalarAdd:leftOffset];
        double rightOffset = [colCenter last];
        Matrix * rightCropPreview = [task.cropFirstCols subvectorFromIndex:[task.cropFirstCols size]-2-task.cropBox.right
                                                                withLength:task.cropBox.right];
        rightCropPreview = [rightCropPreview prefixSums];
        if(PRINT_CROP_PREVIEW) [rightCropPreview printMatrixAsMatlabCodeWithName:@"rightCropPreview"];
        rightCropPreview = [rightCropPreview scalarAdd:rightOffset];
        rightCropPreview = [rightCropPreview splineUpsampling:task.upsamplingFactor];
        colCenter = [colCenter subvectorFromIndex:1 withLength:[colCenter size]-2]; // cut off the to connection entries to left and right
        task.cropPreviewCols = [[leftCropPreview stackTo:colCenter] stackTo:rightCropPreview];
        if(PRINT_CROP_PREVIEW) [task.cropPreviewCols printMatrixWithName:@"cropPreviewCols"];
        if(PRINT_CROP_PREVIEW) [task.cropPreviewCols printMatrixAsMatlabCodeWithName:@"cropPreviewCols"];
        
        
        // upsample the rows
        Matrix * bottomPad = [[Matrix alloc] initVectorWithSize:task.upsamplingFactor * task.cropBox.bottom];
        Matrix * rowCenter = [task.sRows subvectorFromIndex:task.cropBox.bottom
                                                 withLength:[task.sRows size]-task.cropBox.bottom-task.cropBox.top];
        rowCenter = [rowCenter splineUpsampling:task.upsamplingFactor];
        Matrix * topPad = [[Matrix alloc] initVectorWithSize:task.upsamplingFactor * task.cropBox.top];
        [topPad setAllEntriesToValue:[rowCenter last]];
        task.sRows = [[bottomPad stackTo:rowCenter] stackTo:topPad];

        // prepare the preview rows
        Matrix * bottomCropPreview = [task.cropFirstRows subvectorFromIndex:0
                                                               withLength:task.cropBox.bottom];
        bottomCropPreview = [bottomCropPreview prefixSums];
        bottomCropPreview = [bottomCropPreview splineUpsampling:task.upsamplingFactor];
        if(PRINT_CROP_PREVIEW) [bottomCropPreview printMatrixAsMatlabCodeWithName:@"bottomCropPreview"];
        double bottomOffset = [bottomCropPreview last];
        rowCenter = [rowCenter scalarAdd:bottomOffset];
        double topOffset = [rowCenter last];
        Matrix * topCropPreview = [task.cropFirstRows subvectorFromIndex:[task.cropFirstRows size]-2-task.cropBox.top
                                                                withLength:task.cropBox.top];
        topCropPreview = [topCropPreview prefixSums];
        if(PRINT_CROP_PREVIEW) [topCropPreview printMatrixAsMatlabCodeWithName:@"topCropPreview"];
        topCropPreview = [topCropPreview scalarAdd:topOffset];
        topCropPreview = [topCropPreview splineUpsampling:task.upsamplingFactor];
        rowCenter = [rowCenter subvectorFromIndex:1 withLength:[rowCenter size]-2]; // cut off the to connection entries to bottom and top
        task.cropPreviewRows = [[bottomCropPreview stackTo:rowCenter] stackTo:topCropPreview];
        if(PRINT_CROP_PREVIEW) [task.cropPreviewRows printMatrixWithName:@"cropPreviewRows"];
        if(PRINT_CROP_PREVIEW) [task.cropPreviewRows printMatrixAsMatlabCodeWithName:@"cropPreviewRows"];
        
        // store the position of the inner rectangle for the inner image to be shown
        task.cropPreviewInnerRect = CGRectMake(leftOffset, bottomOffset, rightOffset-leftOffset, topOffset-bottomOffset);
        
    }
    return task;
}


-(double) croppingRampWidth:(int)alreadyCropped withTask:(RetargetingTask *)t {
    // using the notation from section "3.2.4 additional parameters"
    double rs = t.W / t.H;
    double rt = t.Wp / t.Hp;
    double LWavg = (rs>rt)?(t.Wp/t.N):(rs*t.Hp/t.N);
    double LHavg = (rt>rs)?(t.Hp/t.M):(1.0/rs*t.Wp/t.M);
    double LFactor = MAX(t.LW/LWavg,t.LH/LHavg);    // reconstruct LFactor
    double LWmin = LWavg * LFactor;
    double LWcrop = LWmin * t.croppingAlpha;
    double LWlow = LWmin - t.croppingBeta*(LWmin-LWcrop);
    double LWhigh = LWmin + t.croppingGamma*(LWavg-LWmin);
    double p = 1.0*alreadyCropped/t.N; // i/N in the thesis
    return p*LWlow + (1-p)*LWhigh;
}
-(double) croppingRampHeight:(int)alreadyCropped withTask:(RetargetingTask *)t {
    // using the notation from section "3.2.4 additional parameters"
    double rs = t.W / t.H;
    double rt = t.Wp / t.Hp;
    double LWavg = (rs>rt)?(t.Wp/t.N):(rs*t.Hp/t.N);
    double LHavg = (rt>rs)?(t.Hp/t.M):(1.0/rs*t.Wp/t.M);
    double LFactor = MAX(t.LW/LWavg,t.LH/LHavg);    // reconstruct LFactor
    double LHmin = LHavg * LFactor;
    double LHcrop = LHmin * t.croppingAlpha;
    double LHlow = LHmin - t.croppingBeta*(LHmin-LHcrop);
    double LHhigh = LHmin + t.croppingGamma*(LHavg-LHmin);
    double p = 1.0*alreadyCropped/t.M; // i/M in the thesis
    return p*LHlow + (1-p)*LHhigh;
}

-(RetargetingTask *)solveWithCropping:(RetargetingTask *)task {
    int M = task.M;
    int N = task.N;
    // add standard bounds
    //        double LW = task.LW;
    
    double LWp = task.croppingAlpha*task.LW;
    Matrix * minW = [[Matrix alloc] initVectorWithSize:N];
    [minW setAllEntriesToValue:LWp];
    
    Matrix * maxW = [[Matrix alloc] initVectorWithSize:N];
    [maxW setAllEntriesToValue:task.Wp];
    
    //        double LH = task.LH;
    double LHp = task.croppingAlpha*task.LH;
    Matrix * minH = [[Matrix alloc] initVectorWithSize:M];
    [minH setAllEntriesToValue:LHp];
    
    Matrix * maxH = [[Matrix alloc] initVectorWithSize:M];
    [maxH setAllEntriesToValue:task.Hp];
    
    RetargetingTask * prepareTask;
    prepareTask = [task copy];
    prepareTask.croppingFlag = NO;
    prepareTask.LW = LWp;
    prepareTask.LH = LHp;
    prepareTask.minW = minW;
    prepareTask.maxW = maxW;
    prepareTask.minH = minH;
    prepareTask.maxH = maxH;
    // solve with range solver to get an idea of what to crop
    prepareTask = [self solveASAPWithTask:prepareTask];
    
    // store this first result for possible later usesh
    task.cropFirstCols = prepareTask.sCols;
    task.cropFirstRows = prepareTask.sRows;
    
    //decide what to crop
    [minW setAllEntriesToValue:task.LW];
    [minH setAllEntriesToValue:task.LH];
    
//    Matrix * solF = [[Matrix alloc] initFromColumnMajorData:sol withRows:50 andColumns:1];
    //        [solF printMatrixWithName:@"s before cropping"];
    
    int crop_left=0, crop_right=0, crop_top=0, crop_bottom=0;
    
    // decide how much to crop from each side and adapt the conditions accordingly
    while([prepareTask.sCols entryAtIndex:crop_left] < [self croppingRampWidth:crop_left withTask:task]) {
        [minW setEntryAtIndex:crop_left toValue:0.0];
        [maxW setEntryAtIndex:crop_left toValue:0.0];
        crop_left++;
    }
    while([prepareTask.sCols entryAtIndex:N-crop_right-1] < [self croppingRampWidth:crop_right withTask:task]) {
        [minW setEntryAtIndex:N-crop_right-1 toValue:0.0];
        [maxW setEntryAtIndex:N-crop_right-1 toValue:0.0];
        crop_right++;
    }
    while([prepareTask.sRows entryAtIndex:crop_bottom] < [self croppingRampHeight:crop_bottom withTask:task]) {
        [minH setEntryAtIndex:crop_bottom toValue:0.0];
        [maxH setEntryAtIndex:crop_bottom toValue:0.0];
        crop_bottom++;
    }
    while([prepareTask.sRows entryAtIndex:M-crop_top-1] < [self croppingRampHeight:crop_top withTask:task]) {
        [minH setEntryAtIndex:M-crop_top-1 toValue:0.0];
        [maxH setEntryAtIndex:M-crop_top-1 toValue:0.0];
        crop_top++;
    }
    
    // solve again with the new bounds
    task.minW = minW;
    task.maxW = maxW;
    task.minH = minH;
    task.maxH = maxH;
    
    // debug for cropping
//    [task.minH printMatrixAsMatlabCodeWithName:@"minH"];
//    [task.minW printMatrixAsMatlabCodeWithName:@"minW"];
    
    
    TCropBox C;
    C.left = crop_left;
    C.right = crop_right;
    C.top = crop_top;
    C.bottom = crop_bottom;
    task.cropBox = C;
    
    task = [self solveASAPWithTask:task];
//    printf("Crop decision l %d, r %d, t %d, b %d\n",
//           crop_left, crop_right, crop_top, crop_bottom);
    return task;
}
-(RetargetingTask *)solveASAPWithTask:(RetargetingTask *)task
{
//    TCropBox cropBox;
//    if(cropping) {
//        cropBox = task.cropBox;
//    } else {
//        cropBox.left = 0;
//        cropBox.right = 0;
//        cropBox.top = 0;
//        cropBox.bottom = 0;
//    }

//    printf("solve with crop Box %.2f %.2f %.2f %.2f\n",task.cropBox.left,task.cropBox.right,task.cropBox.top,task.cropBox.bottom);
    
    int M = task.M;
    int N = task.N;
    double W = task.W;
    double H = task.H; // do not adopt the original width and height for the second solving after the cropping, as they define the optimal ratio of each cell and this is still W/H
    W /= H; // normalize the original size -> this step seems to be crucial for the numerical stability
    H /= H; // I think mathematically this should not matter, but if I omit this normalization
    // in some cases the solutions get "jumpy", meaning that only minimal target ratio changes
    // can lead to huge variations in the solutions
    
    Matrix * b = [[Matrix alloc] initWithSizeRows:M+N andColumns:1];
    
    Matrix * Q; // will be K'*K later
    
    // fast numerical versions
    FastCCSMatrix * K = [[FastCCSMatrix alloc] initWithSizeRows:M*N columns:M+N andMaxColSize:M+N];
    
    // build ASAP matrix
    double w = sqrt(1-task.wregL); // weighting
    for(int i=0; i < N; ++i)
    {
        for(int j=0; j < M; ++j)
        {
            int row = i*M+j;
            [K setEntryAtRow:row andColumn:i toValue:(1.0*w*[task.Omega entryAtRow:j andColumn:i] * N/W)];
            [K setEntryAtRow:row andColumn:j+M toValue:(-1.0*w*[task.Omega entryAtRow:j andColumn:i] * M/H)];
        }
    }
    
    // add laplacian term
    FastCCSMatrix * L = [[FastCCSMatrix alloc] initWithSizeRows:M+N columns:M+N andMaxColSize:2];
    double lW = 1.0*N/W * sqrt(task.wregL);
    for(int i=0+task.cropBox.left; i<M-1-task.cropBox.right; i++) {
        [L setEntryAtRow:i andColumn:i toValue:-lW];
        [L setEntryAtRow:i andColumn:i+1 toValue:lW];
    }
    double lH = 1.0*M/H * sqrt(task.wregL);
    for(int i=0+task.cropBox.bottom; i<N-1-task.cropBox.top; i++) {
        [L setEntryAtRow:M+i andColumn:M+i toValue:-lH];
        [L setEntryAtRow:M+i andColumn:M+i+1 toValue:lH];
    }
    if(PRINT_DEBUG) [[L innerProduct] printMatrixSpyWithName:@"L'*L"];
    //print Omega and K for debugging:
    if(PRINT_DEBUG) [task.Omega printMatrixAsMatlabCodeWithName:@"Omega"];
    
    //calculate Q as K'*K + L
    Q = [[K innerProduct] add:[L innerProduct]];
    if(PRINT_DEBUG) [Q printMatrixAsMatlabCodeWithName:@"Q"];

    double * sol;
    double * Qraw = [Q rawDataAsColumnMajor]; // Qp
    double * braw = [b rawDataAsColumnMajor];

    if(task.croppingFlag) {
        sol = [rangeSolver solveWithS:Qraw
                                    B:braw
                                    W:task.Wp
                                    H:task.Hp
                                 minW:[task.minW rawDataVector]
                                 maxW:[task.maxW rawDataVector]
                                 minH:[task.minH rawDataVector]
                                 maxH:[task.maxH rawDataVector]];
    } else {
        // create the bound vectors for the range solver on the fly
        Matrix * minW = [[Matrix alloc] initVectorWithSize:N];
        [minW setAllEntriesToValue:task.LW];
        Matrix * maxW = [[Matrix alloc] initVectorWithSize:N];
        [maxW setAllEntriesToValue:task.Wp];
        
        Matrix * minH = [[Matrix alloc] initVectorWithSize:M];
        [minH setAllEntriesToValue:task.LH];
        Matrix * maxH = [[Matrix alloc] initVectorWithSize:M];
        [maxH setAllEntriesToValue:task.Hp];

        sol = [rangeSolver solveWithS:Qraw
                               B:braw
                               W:task.Wp
                               H:task.Hp
                            minW:[minW rawDataVector]
                            maxW:[maxW rawDataVector]
                            minH:[minH rawDataVector]
                            maxH:[maxH rawDataVector]];
    }

    
    task.sCols = [[Matrix alloc] initFromColumnMajorData:sol withRows:M andColumns:1];
    task.sRows = [[Matrix alloc] initFromColumnMajorData:sol+M withRows:N andColumns:1];

    
//    printf("K L2 %lf\n",[K L2Norm]);
//    printf("L L2 %lf\n",[L L2Norm]);
//    [Q printMatrixWithName:@"Q"];
//    [b printMatrixWithName:@"b"];
//    [task dumpMatlabExportToConsole];
    
    free(sol);
    free(Qraw);
    free(braw);
    return task;
}

@end
