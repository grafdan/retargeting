//
//  RetargetingState.h
//  Retargeting
//
//  Created by Daniel Graf on 16.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import "SaliencyImageView.h"
#import "WarpImageView.h"
#import "Matrix.h"
#import "RetargetingTask.h"
#import "UIApplication+DeviceSize.h"
#import "Types.h"

#define MAXNM 100

typedef enum {
    kLayoutModeConcatenateBoth,
    kLayoutModeStackBoth,
    kLayoutModeConcatenateAll,
    kLayoutModeStackAll,
    kLayoutModeCombined
} LayoutType;

@class RetargetingTask;


@interface RetargetingState : NSObject {
}
//@property (nonatomic,strong) NSMutableArray * warpDescriptionVector;
@property (nonatomic) void * imageTexture;
@property (nonatomic) void * saliencyExtractionImageBitmap;
@property (nonatomic,strong) UIImage * saliencyExtractionImage;
@property (nonatomic) GLubyte * saliencyMap;
@property (nonatomic,strong) Matrix * saliencyMatrix;
@property (nonatomic) CGSize originalSize; // the size of the unretargeted image texture that is stored in a quadratic bitmap for mipmapping
@property (nonatomic) CGSize originalUIImageSize; // the size of the image that was loaded from the gallery and is stored as the original (this might exceed the maximum texture size of the device)
@property (nonatomic) CGSize textureSize;
@property (nonatomic) CGSize saliencyMapSize;
@property (nonatomic) CGSize saliencyTextureSize;
@property (nonatomic) CGSize sourceSize;
@property (nonatomic) CGSize targetSize;
@property (nonatomic) double sourceRatio;
@property (nonatomic) double targetRatio;

@property (nonatomic) bool useMipMaps;

@property (nonatomic) int gridM;
@property (nonatomic) int gridN;
@property (nonatomic) double laplacianRegularizationWeight;
@property (nonatomic) double LFactor; //minimum cell size compared to original
@property (nonatomic) bool paintMode;
@property (nonatomic) double brushSize;
@property (nonatomic) int upsamplingFactor;
@property (nonatomic) LayoutType layoutMode;
@property (nonatomic) double zoomFactor;
@property (nonatomic) CGPoint translationVector;
@property (nonatomic) bool showGrid;
@property (nonatomic) bool showSaliency;
@property (nonatomic) bool motionCompensation;
@property (nonatomic) bool croppingFlag;
@property (nonatomic) double croppingAlpha;
@property (nonatomic) double croppingBeta;
@property (nonatomic) double croppingGamma;
@property (nonatomic) TCropBox cropBox;
@property (nonatomic) CGSize cropPreviewSize;
@property (nonatomic) double cropPreviewRatio;

@property (nonatomic,strong) UIImage * originalImage;
@property (nonatomic) BOOL needsRecalc;

@property (nonatomic,strong) RetargetingTask *task;

- (void) calculateWarp;
- (void) loadImageFromPath:(NSString*)path;
- (void) loadImage:(UIImage*)path;
- (void) unloadImage;
- (void) createSaliencyResolutionImage;
- (void) createInitialSaliency;
- (void) loadSaliencyImage:(UIImage *)saliencyImage;
- (UIImage *) saveSaliencyImage;
- (void) resetSaliency;
- (void) automaticSaliency;
- (void) paintAtPosition:(CGPoint)point;
- (CGRect)cropPreviewInnerRect;
- (void)resetDefaultParameterSettings;
- (void)setDefaultParameterSettingsWithCropping:(bool)croppingFlag;

@end
