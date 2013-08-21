//
//  MorphedImageView.h
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "OpenGLCommon.h"
#import "RetargetingState.h"
#import "RetargetingContext.h"
#import "RetargetingTask.h"
#import "Grid.h"

#define MAXNM 100

@class RetargetingState;
@class RetargetingTask;

@protocol WarpViewDataSource
- (RetargetingTask *)task;
- (NSString *)name;
- (UIImage *)originalImage;
- (void *)imageTexture;
- (CGSize)targetImageSize;
- (double)targetRatio;
- (void)setTargetRatio:(double)factor;
- (void)changeTargetRatio:(double)factor;
- (bool)showGrid;
- (bool)useMipMaps;
- (CGSize)textureSize;
- (CGSize)originalSize;

@end

@interface WarpImageView : GLKView {
    Grid * grid;
}
@property (nonatomic) CGSize imageSize;
@property (nonatomic, weak) IBOutlet id <WarpViewDataSource> dataSource;

-(void)reloadImage;
- (void)unloadTextures;
@end
