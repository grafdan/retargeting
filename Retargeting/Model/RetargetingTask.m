//
//  RetargetingTask.m
//  Retargeting
//
//  Created by Daniel Graf on 30.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "RetargetingTask.h"

@implementation RetargetingTask
@synthesize Omega,M,N,W,H,Wp,Hp,LW,LH,sRows,sCols,wregL,upsamplingFactor,croppingFlag,croppingAlpha,croppingBeta,croppingGamma,cropBox,cropPreviewInnerRect;
@synthesize cropPreviewCols,cropPreviewRows, cropFirstCols, cropFirstRows;

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
                     cropBox:(TCropBox)aCropBox

{
    self = [super init];
    Omega = aOmega;
    M = aM;
    N = aN;
    W = aW;
    H = aH;
    Wp = aWp;
    Hp = aHp;
    LW = aLW;
    LH = aLH;
    wregL = aWregL;
    upsamplingFactor = aUpsamplingFactor;
    croppingFlag = aCroppingFlag;
    croppingAlpha = aCroppingAlpha;
    croppingBeta = aCroppingBeta;
    croppingGamma = aCroppingGamma;
    cropBox = aCropBox;
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"M %d\nN %d\nW %lf\nH %lf\nWp %lf\nHp %lf\nLW %lf\nLH %lf upsampling %d\n",
            M,N,W,H,Wp,Hp,LW,LH,upsamplingFactor];
}
-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    RetargetingTask *another = [[RetargetingTask alloc] initWithOmega:self.Omega M:self.M N:self.N
                                                                    W:self.W
                                                                    H:self.H
                                                                   Wp:self.Wp
                                                                   Hp:self.Hp
                                                                   LW:self.LW
                                                                   LH:self.LH
                                                                wregL:self.wregL
                                                     upsamplingFactor:self.upsamplingFactor
                                                         croppingFlag:self.croppingFlag
                                                         croppinAlpha:self.croppingAlpha
                                                          croppinBeta:self.croppingBeta
                                                         croppinGamma:self.croppingGamma
                                                              cropBox:self.cropBox];
    another.minW = self.minW;
    another.minH = self.minH;
    another.maxW = self.maxW;
    another.maxH = self.maxH;
    return another;
}
-(void)dumpMatlabExportToConsole {
    printf("%% Problem specification\n");
    printf("M = %d;\n",M);
    printf("N = %d;\n",N);
    printf("W = %lf;\n",W);
    printf("H = %lf;\n",H);
    printf("Wp = %lf;\n",Wp);
    printf("Hp = %lf;\n",Hp);
    printf("LW = %lf;\n",LW);
    printf("LH = %lf;\n",LH);
    printf("upsampling = %d;\n",upsamplingFactor);
    [Omega printMatrixAsMatlabCodeWithName:@"Omega"];
    [sRows printMatrixAsMatlabCodeWithName:@"sRows"];
    [sCols printMatrixAsMatlabCodeWithName:@"sCols"];
}
@end
