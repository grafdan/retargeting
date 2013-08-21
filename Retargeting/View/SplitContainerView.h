//
//  SplitContainerView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetargetingViewController.h"
#import "LayoutHelper.h"

@interface SplitContainerView : UIView
@property (nonatomic, weak) PictureFrameView * saliencyPictureFrameView;
@property (nonatomic, weak) PictureFrameView * warpPictureFrameView;
@property (nonatomic, weak) RetargetingViewController * retargetingViewController;

@end
