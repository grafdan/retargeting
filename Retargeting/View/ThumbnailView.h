//
//  ThumbnailView.h
//  Retargeting
//
//  Created by Daniel Graf on 25.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "ProjectController.h"
#import "LibraryViewController.h"

#import <QuartzCore/QuartzCore.h>
@interface ThumbnailView : UIView <UIAlertViewDelegate>
@property (nonatomic,weak) LibraryViewController * libraryViewController;
@property (nonatomic,strong) Project * project;
- (ThumbnailView *) setProjectID:(NSString *) projectID;
- (void)reloadImage;
- (void)setPaddingFactor:(int)factor;
@end
