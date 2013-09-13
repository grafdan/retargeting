//
//  MorphedImageView.h
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
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
