//
//  ViewController.h
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
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
#import "RetargetingView.h"
#import "WarpImageView.h"
#import "SaliencyImageView.h"
#import "PictureFrameView.h"
#import "CombinedView.h"
#import "RetargetingState.h"
#import "RetargetingToolbar.h"
#import "SettingsViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIApplication+DeviceSize.h"
#import "CombinedContainerView.h"
#import "SplitContainerView.h"
#import "RetargetingContext.h"
#import <QuartzCore/QuartzCore.h>
#import "RetargetingImage.h"
#import "ExportRenderer.h"
#import "ProjectController.h"
#import "LibraryViewController.h"
#import "RatioPicker.h"

@class RetargetingView;
@class RetargetingToolbar;
@class SplitContainerView;
@class CombinedContainerView;

@protocol RetargetingToolbarDelegate <NSObject>
-(void)toggleSaliencyButton;
-(void)togglePaintButton;
-(void)toggleLayoutButton;
@end

@interface RetargetingViewController : UIViewController<SettingsViewDataSourceAndDelegate,CombinedViewDataSource,WarpViewDataSource, SaliencyViewDataSource,SaliencyViewPaintingControllerDelegate, RetargetingToolbarDelegate, ExportRendererDataSource,RatioPickerDataSourceAndDelegate>
@property(nonatomic,strong) IBOutlet RetargetingToolbar *toolbar;
@property(nonatomic,strong) IBOutlet RetargetingView *retargetingView;
@property(nonatomic,strong) IBOutlet WarpImageView *warpImageView;
@property(nonatomic,strong) IBOutlet SaliencyImageView *saliencyImageView;
@property(nonatomic,strong) IBOutlet CombinedView *combinedView;
@property(nonatomic,strong) IBOutlet PictureFrameView *combinedPictureFrameView;
@property(nonatomic,strong) IBOutlet PictureFrameView *saliencyPictureFrameView;
@property(nonatomic,strong) IBOutlet PictureFrameView *warpPictureFrameView;
@property(nonatomic,strong) IBOutlet CombinedContainerView * combinedContainerView;
@property(nonatomic,strong) IBOutlet SplitContainerView * splitContainerView;

@property(nonatomic,strong) RetargetingState *retargetingState;
@property(nonatomic,strong) UIPopoverController *libraryImagePickerPopover;
@property(nonatomic,strong) UIPopoverController *cameraImagePickerPopover;
@property(nonatomic,strong) UIPopoverController *settingsPopover;
@property(nonatomic,strong) UIPopoverController *ratioPickerPopover;
@property(nonatomic,strong) SettingsViewController * settingViewController;
@property(nonatomic,strong) RatioPicker * ratioPicker;
@property(nonatomic,strong) ProjectController *projectController;
@property(nonatomic,strong) IBOutlet LibraryViewController * libraryViewController;

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)loadImageWithPath:(NSString *)path;
- (void)loadImage:(UIImage *)imag;
- (IBAction)takePictureWithCamera:(id)sender;
- (IBAction)choosePictureFromLibrary:(id)sender;
- (IBAction)exportImage:(id)sender;
- (IBAction)closeProject:(id)sender;
- (IBAction)automaticSaliency:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)ratioPicker:(id)sender;
- (IBAction)resetSaliency:(id)sender;
- (void)layoutRetargetingSubviews;
- (void)loadProject;

@end
