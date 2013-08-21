//
//  SplitContainerView.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "SplitContainerView.h"

@implementation SplitContainerView
@synthesize saliencyPictureFrameView = _saliencyPictureFrameView;
@synthesize warpPictureFrameView = _warpPictureFrameView;
@synthesize retargetingViewController = _retargetingViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews {
    double retarget_w = self.frame.size.width;
    double retarget_h = self.frame.size.height;
    double margin = 10;
    
    // reposition saliency view
    CGFloat saliency_x = margin+10;
    CGFloat saliency_y = margin+10;
    CGFloat saliency_w = 0.5*(retarget_w-3*margin)-20;
    CGFloat saliency_h = retarget_h-2*margin-20;
    CGRect saliency_box = CGRectMake(saliency_x,
                                     saliency_y,
                                     saliency_w,
                                     saliency_h);
    CGRect saliency_frame = [LayoutHelper centeredRectInBoundingBox:saliency_box
                                                  withRatio:self.retargetingViewController.retargetingState.sourceRatio];
    self.saliencyPictureFrameView.frame = CGRectMake(saliency_frame.origin.x-10,
                                                     saliency_frame.origin.y-10,
                                                     saliency_frame.size.width+20,
                                                     saliency_frame.size.height+20);
    [self.saliencyPictureFrameView layoutSubviews];
    
    //warp view -> keep aspect ratio
    CGFloat warp_x = 0.5*(retarget_w+margin)+10;
    CGFloat warp_y = margin+10;
    CGFloat warp_w = 0.5*(retarget_w-3*margin)-2*10;
    CGFloat warp_h = retarget_h-2*margin - 2*10;
    CGRect warp_box = CGRectMake(warp_x,
                                 warp_y,
                                 warp_w,
                                 warp_h);
    CGRect warp_frame = [LayoutHelper centeredRectInBoundingBox:warp_box
                                              withRatio:self.retargetingViewController.retargetingState.targetRatio];
    self.warpPictureFrameView.frame = CGRectMake(warp_frame.origin.x-10,
                                                 warp_frame.origin.y-10,
                                                 warp_frame.size.width+20,
                                                 warp_frame.size.height+20);
    [self.warpPictureFrameView layoutSubviews];
    
    //keep model up to date
    self.retargetingViewController.retargetingState.sourceSize = self.retargetingViewController.saliencyImageView.frame.size;
//    self.retargetingViewController.retargetingState.targetSize = self.retargetingViewController.warpImageView.frame.size;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
