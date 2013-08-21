//
//  RetargetingToolbar.h
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetargetingViewController.h"

@class RetargetingViewController;


@interface RetargetingToolbar : UIToolbar {
    UIBarButtonItem *saliencyToggleButton, *paintToggleButton, *layoutToggleButton;
    
}
@property (nonatomic,weak) RetargetingViewController * retargetingViewController;
- (id)initWithFrame:(CGRect)frame andRetargetingViewController:(RetargetingViewController *)retargetingViewController;
- (void)showLayoutButton;
- (void)showPaintButton;
- (void)showSaliencyButton;
@end
