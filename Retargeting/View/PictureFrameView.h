//
//  PictureFrameView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RoundedRectView.h"
#import "CombinedView.h"
@interface PictureFrameView : UIView {
    RoundedRectView * roundedRectView;
}
@property (nonatomic, weak) IBOutlet id <CombinedViewDataSource> dataSource;

@end
