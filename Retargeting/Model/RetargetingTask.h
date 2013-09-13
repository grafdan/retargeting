//
//  RetargetingTask.h
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
#import "Matrix.h"
#import "RetargetingState.h"
#import "OpenGLCommon.h"
#import "Types.h"
#import "DeviceType.h"
@interface RetargetingTask : NSObject

@property (nonatomic, strong) Matrix * Omega;
@property (nonatomic) int M,N;
@property (nonatomic) double W,H,Wp,Hp,LW,LH,wregL;
@property (nonatomic, strong) Matrix * sRows;
@property (nonatomic, strong) Matrix * sCols;
@property (nonatomic) int upsamplingFactor;
@property (nonatomic) bool croppingFlag;
@property (nonatomic) double croppingAlpha; //cropping tail ratio
@property (nonatomic) double croppingBeta; //cropping lower ramp ratio
@property (nonatomic) double croppingGamma; //cropping upper ramp ratio
@property (nonatomic) TCropBox cropBox; //cropping box
@property (nonatomic, strong) Matrix *minW, *maxW, *minH, *maxH;
@property (nonatomic, strong) Matrix *cropPreviewRows;
@property (nonatomic, strong) Matrix *cropPreviewCols;
@property (nonatomic, strong) Matrix *cropFirstRows;
@property (nonatomic, strong) Matrix *cropFirstCols;
@property (nonatomic) CGRect cropPreviewInnerRect;


-(RetargetingTask *)initWithOmega:(Matrix *)aOmega
                                M:(int)aM
                                N:(int)aN
                                W:(double)aW
                                H:(double)aH
                               Wp:(double)aWp
                               Hp:(double)aHp
                               LW:(double)aLW
                               LH:(double)aLH
                            wregL:(double)aWregL
                 upsamplingFactor:(int)aUpsamplingFactor
                     croppingFlag:(bool)aCroppingFlag
                     croppinAlpha:(double)aCroppingAlpha
                      croppinBeta:(double)aCroppingBeta
                     croppinGamma:(double)aCroppingGamma
                          cropBox:(TCropBox)aCropBox;

-(NSString *)description;
-(void)dumpMatlabExportToConsole;

@end
