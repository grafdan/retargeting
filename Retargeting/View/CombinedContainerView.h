//
//  CombinedContainerView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetargetingViewController.h"
@interface CombinedContainerView : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,weak) RetargetingViewController * retargetingViewController;
@property (nonatomic,weak) PictureFrameView * combinedPictureFrameView;
@property (nonatomic,weak) CombinedSaliencyView * combinedSaliencyView;
@property (nonatomic, weak) IBOutlet id <WarpViewDataSource,SaliencyViewDataSource,CombinedViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id <SaliencyViewPaintingControllerDelegate> paintingDelegate;
@end
