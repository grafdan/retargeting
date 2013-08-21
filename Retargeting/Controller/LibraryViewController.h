//
//  LibraryViewController.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryToolbar.h"
#import "GalleryView.h"
#import "RetargetingViewController.h"
#import "ProjectController.h"
#import "WebViewController.h"


@class LibraryToolbar;
@class GalleryView;
@class WebViewController;

@protocol WebViewDelegateProtocol <NSObject>
-(void)didFinishReadingWebsite:(id)sender;
@end


@interface LibraryViewController : UIViewController<UIPopoverControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WebViewDelegateProtocol>
    
@property(nonatomic,strong) LibraryToolbar *toolbar;
@property(nonatomic,strong) GalleryView *galleryView;
@property(nonatomic,strong) RetargetingViewController *retargetingViewController;
@property(nonatomic,strong) ProjectController * projectController;
@property(nonatomic,strong) UIPopoverController *libraryImagePickerPopover;
@property(nonatomic,strong) UIPopoverController *cameraImagePickerPopover;
@property(nonatomic,strong) UIPopoverController *settingsPopover;
@property(nonatomic,strong) WebViewController * webViewController;

- (void)openTest:(id)sender;
- (void)showInfo:(id)sender;
- (void)showHelp:(id)sender;
- (void)editProject:(Project *)project;
- (void)closeProject:(Project *)project;
@end
