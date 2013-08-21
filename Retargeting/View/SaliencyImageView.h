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
#import "RetargetingContext.h"
#import "Matrix.h"
#import "Grid.h"

@protocol SaliencyViewDataSource
- (GLubyte *)saliencyImage;
- (CGSize)saliencyMapSize;
- (CGSize)saliencyTextureSize;
- (UIImage *)originalImage;
- (void *)imageTexture;
- (double)sourceRatio;
- (bool)useMipMaps;
- (CGSize)originalSize;
- (CGSize)textureSize;
- (bool)showSaliency;
- (void)setShowSaliency:(bool)aShowSaliency;
@end
@protocol SaliencyViewPaintingControllerDelegate
- (void)paintAtPosition:(CGPoint)point;
@end

@interface SaliencyImageView : GLKView {
    GLuint imageTexture;
    GLuint saliencyTexture;
    @public
    Grid * imageGrid;
    Grid * saliencyGrid;
}

@property (nonatomic, weak) IBOutlet id <SaliencyViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id <SaliencyViewPaintingControllerDelegate> paintingDelegate;
@property (nonatomic) BOOL needsSaliencyRebind;
-(void) bindSaliencyTexture;
-(void) reloadImage;
- (void)unloadTextures;
@end
