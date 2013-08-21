//
//  CombinedView.m
//  Retargeting
//
//  Created by Daniel Graf on 12.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "CombinedView.h"

@implementation CombinedView {
    int N, M;
}
@synthesize dataSource = _dataSource;
@synthesize imageSize = _imageSize;
@synthesize paintingDelegate = _paintingDelegate;
@synthesize needsSaliencyRebind = _needsSaliencyRebind;
@synthesize pictureView = _pictureView;
@synthesize saliencyView = _saliencyView;
-(void) bindSaliencyTexture {
    [self.saliencyView bindSaliencyTexture];
}


- (void)setup {
    self.pictureView = [[CombinedPictureView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andCombinedView:self];
    [self addSubview:self.pictureView];
    self.saliencyView = [[CombinedSaliencyView alloc] initWithFrame:self.bounds andCombinedView:self];
    [self addSubview:self.saliencyView];

    [self setNeedsDisplay];
}


-(void) reloadImage {
    //NSLog(@"reload Saliency Image Ground Picture");
    [self.pictureView reloadImage];
    [self.saliencyView reloadImage];
}

-(void) unloadTextures {
    [self.pictureView unloadTextures];
    [self.saliencyView unloadTextures];
}

- (void)awakeFromNib
{
    //NSLog(@"Saliency Image View awake from nib");
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    //NSLog(@"Saliency Image View init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect cropRect = self.dataSource.cropPreviewInnerRect;
    CGSize cropSize = self.dataSource.cropPreviewSize;
    // saliency view
    // should go over the border of the screen if saliency is not shown
    if(!self.dataSource.showSaliency && self.dataSource.croppingFlag) {
        self.saliencyView.frame = CGRectMake(-cropRect.origin.x/cropRect.size.width*self.bounds.size.width,
                                             -(cropSize.height-cropRect.size.height-cropRect.origin.y)/cropRect.size.height*self.bounds.size.height,
                                             cropSize.width/cropRect.size.width*self.bounds.size.width,
                                             cropSize.height/cropRect.size.height*self.bounds.size.height);
        // place the picture view just right under the same image part in the saliency view, such that the transition is as smooth as possible
        
    }
    else {
        self.saliencyView.frame = self.bounds;
    }

    // picture view -> hide behind saliency
    if(self.dataSource.showSaliency && self.dataSource.croppingFlag) {
//        NSLog(@"Crop Preview Inner Rect %lf %lf %lf %lf",cropRect.origin.x,
//              cropRect.origin.y,cropRect.size.width,cropRect.size.height);
//        NSLog(@"Crop Preview Size %lf %lf",cropSize.width, cropSize.height);
        self.pictureView.frame = CGRectMake(cropRect.origin.x/cropSize.width*self.bounds.size.width,
                                            (cropSize.height-cropRect.size.height-cropRect.origin.y)/cropSize.height*self.bounds.size.height,
                                            cropRect.size.width/cropSize.width*self.bounds.size.width,
                                            cropRect.size.height/cropSize.height*self.bounds.size.height); // place the picture view just right under the same image part in the saliency view, such that the transition is as smooth as possible
    } else {
        self.pictureView.frame = self.bounds;
    }
}

- (void)setNeedsDisplay {
    [self.pictureView setNeedsDisplay];
    [self.saliencyView setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [self.pictureView setNeedsDisplay];
    [self.saliencyView setNeedsDisplay];
}

-(void)setShowSaliency:(bool)showSaliency {
//    [UIView animateWithDuration:0.5 animations:^{
        self.saliencyView.alpha = 0.75*showSaliency;
        // make a little bit transparent if shown, such that picture frame can shine through, when cropped
//        self.pictureView.alpha = !showSaliency;
//    }];
}
@end
