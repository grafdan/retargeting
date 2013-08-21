//
//  CombinedView.h
//  Retargeting
//
//  Created by Daniel Graf on 12.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarpImageView.h"
#import "SaliencyImageView.h"
#import "CombinedPictureView.h"
#import "CombinedSaliencyView.h"

@class CombinedSaliencyView;
@class CombinedPictureView;

@protocol CombinedViewDataSource
- (double)zoomFactor;
- (void)setZoomFactor:(double)aFactor;
- (void)setZoomFactor:(double)aFactor animated:(bool)animated;
- (bool)showSaliency;
- (void)setShowSaliency:(bool)aShowSaliency;
- (CGPoint)translationVector;
- (void)setTranslationVector:(CGPoint)aVector;
- (void)setTranslationVector:(CGPoint)aVector animated:(bool)animated;
- (bool)motionCompensation;
- (bool)croppingFlag;
- (CGSize)cropPreviewSize;
- (CGRect)cropPreviewInnerRect;
- (double)cropPreviewRatio;
@end

@interface CombinedView : GLKView {
}
@property (nonatomic) CGSize imageSize;
@property (nonatomic, weak) IBOutlet id <WarpViewDataSource,SaliencyViewDataSource,CombinedViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id <SaliencyViewPaintingControllerDelegate> paintingDelegate;
@property (nonatomic) BOOL needsSaliencyRebind;
@property (nonatomic, strong) CombinedPictureView *pictureView;
@property (nonatomic, strong) CombinedSaliencyView *saliencyView;

-(void)reloadImage;
-(void)bindSaliencyTexture;
-(void)setShowSaliency:(bool)showSaliency;
- (void)unloadTextures;

@end
