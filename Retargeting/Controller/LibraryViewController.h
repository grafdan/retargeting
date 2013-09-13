//
//  LibraryViewController.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//
//    This file is part of Refooormat.
//
//    Refooormat is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Refooormat is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Refooormat.  If not, see <http://www.gnu.org/licenses/>.

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
