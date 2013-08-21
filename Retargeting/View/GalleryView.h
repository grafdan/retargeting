//
//  GalleryView.h
//  Retargeting
//
//  Created by Daniel Graf on 25.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectController.h"
#import "ThumbnailView.h"
#import "LibraryViewController.h"
@interface GalleryView : UIView
@property (nonatomic,retain) ProjectController * projectController;
@property (nonatomic,weak) LibraryViewController * libraryViewController;
- (void)loadProjects;
- (void)reloadProject:(NSString *)projectID;
- (id)initWithFrame:(CGRect)frame andLibraryViewController:(LibraryViewController *)libraryViewController;
- (void)scrollToEnd;
@end
