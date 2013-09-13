//
//  LibraryViewController.m
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

#import "LibraryViewController.h"

@interface LibraryViewController ()

@end

@implementation LibraryViewController

@synthesize toolbar = _toolbar;
@synthesize retargetingViewController = _retargetingViewController;
@synthesize projectController = _projectController;
@synthesize galleryView = _galleryView;
@synthesize webViewController = _webViewController;
@synthesize libraryImagePickerPopover = _libraryImagePickerPopover;
@synthesize cameraImagePickerPopover = _cameraImagePickerPopover;
@synthesize settingsPopover = _settingsPopover;

- (void) setupBackground {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LinenBackground" ofType:@"png"];
    UIImage * linenBackgroundImage = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithImage:linenBackgroundImage];
    [self.view addSubview:backgroundImageView];

}

- (void) setupToolbar {
    // setup toolbar
    self.toolbar = [[LibraryToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) andLibraryViewController:self];
    self.toolbar.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    self.toolbar.barStyle = UIBarStyleDefault;
    [self.view addSubview:self.toolbar];
}

- (void) setupScrollView {
    CGRect galleryRect = CGRectMake(0,44,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height-44);
    self.galleryView = [[GalleryView alloc] initWithFrame:galleryRect andLibraryViewController:self];
    self.galleryView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                         UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.galleryView];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.projectController = [ProjectController sharedProjectController];
    self.retargetingViewController = [[RetargetingViewController alloc] init];
    self.retargetingViewController.libraryViewController = self;
    self.webViewController = [[WebViewController alloc] init];
    self.webViewController.delegate = self;
    [self setupBackground];
    [self setupToolbar];
    [self setupScrollView];
}
- (void) viewDidAppear:(BOOL)animated {
    // show Info screen on very first startup
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"NotInitialStartup"] == NO) {
        // executed whenever the key is not set or set to NO -> display info
        [self showInfo:self.toolbar.items[2]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NotInitialStartup"];
    }
}

- (void)openTest:(id)sender {
    [self presentViewController:self.retargetingViewController animated:YES completion:nil];
}

- (void) presentWebView {
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:self.webViewController];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController:navigationController animated:YES];
    } else {
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}
- (void) didFinishReadingWebsite:(id)sender {
    [self.webViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"Close Website");
}
- (void)showInfo:(id)sender {
    self.webViewController = [[WebViewController alloc] init];
    self.webViewController.delegate = self;
    [self.webViewController setFilename:@"info"];
    [self presentWebView];
}
- (void)showHelp:(id)sender {
    self.webViewController = [[WebViewController alloc] init];
    self.webViewController.delegate = self;
    [self.webViewController setFilename:@"help"];
    [self presentWebView];
}
- (IBAction)takePictureWithCamera:(id)sender
{
    NSLog(@"Take Picture");
    [self dismissAllPopovers];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        [controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
        [controller setDelegate:self];
        self.cameraImagePickerPopover = [self setupImagePickerPopoverOrModalWithPickerController:controller andSender:sender];
    } else {
        // no camera
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Camera Found" message:@"I am really sorry, but your device does not have a built-in camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
- (IBAction)choosePictureFromLibrary:(id)sender
{
    NSLog(@"Choose Picture");
    [self dismissAllPopovers];
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[controller setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
	[controller setDelegate:self];
    self.libraryImagePickerPopover = [self setupImagePickerPopoverOrModalWithPickerController:controller andSender:sender];
}
-(UIPopoverController *) setupImagePickerPopoverOrModalWithPickerController:(UIImagePickerController *)controller
                                                                  andSender:(id)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverController * popoverController;
        popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popoverController setDelegate:self];
        [popoverController presentPopoverFromBarButtonItem:sender
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
        return popoverController;
    }
    else {
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        return nil;
    }
}
- (void)dismissAllPopovers {
    if(self.libraryImagePickerPopover) {
        [self.libraryImagePickerPopover dismissPopoverAnimated:YES];
        self.libraryImagePickerPopover = nil;
    }
    if(self.cameraImagePickerPopover) {
        [self.cameraImagePickerPopover dismissPopoverAnimated:YES];
        self.cameraImagePickerPopover = nil;
    }
    if(self.settingsPopover) {
        [self.settingsPopover dismissPopoverAnimated:YES];
        self.settingsPopover = nil;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"did finish picking media");
    
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self dismissAllPopovers];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    if(image != nil) {
        RetargetingImage * retargetingImage = [[RetargetingImage alloc] init];
        retargetingImage.image = image;
        [retargetingImage rotateImageToOrientation];
        
        Project * project = [self.projectController createProject];
        project.originalImage = retargetingImage.image;
        [retargetingImage scaleImageToSize:600];
        project.previewImage = retargetingImage.image;
        [self.galleryView loadProjects];
        [self.galleryView layoutSubviews];
        [self.galleryView scrollToEnd];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self dismissAllPopovers];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)editProject:(Project *)project {
    [self.projectController openProject:project];
    [self.retargetingViewController loadProject];
    [self.retargetingViewController setShowSaliency:NO];
    [self presentViewController:self.retargetingViewController animated:YES completion:nil];
    [self.retargetingViewController setShowSaliency:NO];
}
- (void)closeProject:(Project *)project {
    [self.galleryView reloadProject:project.projectID];
    [self.galleryView layoutSubviews];
}
#pragma mark UIViewController Methods

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (BOOL)shouldAutorotate {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
