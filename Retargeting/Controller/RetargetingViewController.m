//
//  ViewController.m
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

#import "RetargetingViewController.h"
@interface RetargetingViewController() <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate> {
    UIAlertView *exportAlertView;
    UIActivityIndicatorView * exportActivityIndicatorView;
}
@end

@implementation RetargetingViewController
@synthesize toolbar = _toolbar;
@synthesize retargetingView = _retargetingView;
@synthesize warpImageView = _morphedImageView;
@synthesize saliencyImageView = _saliencyImageView;
@synthesize retargetingState = _retargetingState;
@synthesize libraryImagePickerPopover = _libraryImagePickerPopover;
@synthesize cameraImagePickerPopover = _cameraImagePickerPopover;
@synthesize settingsPopover = _settingsPopover;
@synthesize settingViewController = _settingViewController;
@synthesize ratioPicker = _ratioPicker;
@synthesize ratioPickerPopover = _ratioPickerPopover;
@synthesize combinedView = _combinedView;
@synthesize combinedPictureFrameView = _combinedPictureFrameView;
@synthesize saliencyPictureFrameView = _saliencyPictureFrameView;
@synthesize warpPictureFrameView = _warpPictureFrameView;
@synthesize combinedContainerView = _combinedContainerView;
@synthesize splitContainerView = _splitContainerView;
@synthesize projectController = _projectController;
@synthesize libraryViewController = _libraryViewController;

- (void)loadImageWithPath:(NSString *)path {
    [self.retargetingState loadImageFromPath:path];
    [self.warpImageView reloadImage];
    [self.saliencyImageView reloadImage];
    [self.combinedView reloadImage];
    [self layoutRetargetingSubviews];
}
- (void)loadImage:(UIImage *)image {
//    printf("max texture size %d\n",GL_MAX_TEXTURE_SIZE);
    [self.retargetingState loadImage:image];
    [self.warpImageView reloadImage];
    [self.saliencyImageView reloadImage];
    [self.combinedView reloadImage];
    [self layoutRetargetingSubviews];
}

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

#pragma mark Layout methods

- (void)layoutRetargetingSubviews {
    //setup all the subviews:
    CGFloat retarget_w = self.retargetingView.frame.size.width;
    CGFloat retarget_h = self.retargetingView.frame.size.height;
    if(self.layoutMode == kLayoutModeCombined) {
        self.combinedContainerView.frame = CGRectMake(self.combinedContainerView.frame.origin.x,
                                                      self.combinedContainerView.frame.origin.y,
                                                      retarget_w, retarget_h);
        [self.combinedContainerView layoutSubviews];
    }
    if(self.layoutMode == kLayoutModeConcatenateBoth) {
        self.splitContainerView.frame = CGRectMake(self.splitContainerView.frame.origin.x,
                                                   self.splitContainerView.frame.origin.y,
                                                   retarget_w, retarget_h);
        [self.splitContainerView layoutSubviews];
    }
//    NSLog(@"retarget w %lf and retarget h %lf",retarget_w,retarget_h);
//    self.retargetingState.needsRecalc = YES;
//
//
//    if(self.layoutMode == kLayoutModeCombined) {
//        self.retargetingState.sourceSize = self.combinedView.frame.size;
//        self.retargetingState.targetSize = self.combinedView.frame.size;
//        [self.combinedView setNeedsDisplay];
//        [self.saliencyImageView setNeedsDisplay];
//        [self.warpImageView setNeedsDisplay];
//        self.combinedPictureFrameView.hidden = NO;
//        self.warpImageView.hidden = YES;
//        self.saliencyImageView.hidden = YES;
//    }
//    if(self.layoutMode == kLayoutModeConcatenateBoth) {
//        //keep model up to date
//        self.retargetingState.sourceSize = self.saliencyImageView.frame.size;
//        self.retargetingState.targetSize = self.warpImageView.frame.size;
//        [self.saliencyImageView setNeedsDisplay];
//        [self.warpImageView setNeedsDisplay];
//        self.combinedPictureFrameView.hidden = YES;
//        self.warpImageView.hidden = NO;
//        self.saliencyImageView.hidden = NO;
//    }
}

-(void) showCombinedLayout {
    self.combinedContainerView.frame = CGRectMake(0, 0, self.retargetingView.frame.size.width, self.retargetingView.frame.size.height);
    self.combinedContainerView.alpha = 1.0;
    self.splitContainerView.frame = CGRectMake(-self.retargetingView.frame.size.width, 0, self.retargetingView.frame.size.width, self.retargetingView.frame.size.height);
    self.splitContainerView.alpha = 0.0;
}
-(void) showSplitLayout {
    self.splitContainerView.frame = CGRectMake(0, 0, self.retargetingView.frame.size.width, self.retargetingView.frame.size.height);
    self.splitContainerView.alpha = 1.0;
    self.combinedContainerView.frame = CGRectMake(self.retargetingView.frame.size.width, 0, self.retargetingView.frame.size.width, self.retargetingView.frame.size.height);
    self.combinedContainerView.alpha = 0.0;
}

#pragma mark setup view hierarchy
- (void)setupRetargetingView {
    self.retargetingView = [[RetargetingView alloc] initWithFrame:CGRectMake(0,
                                                                             44,
                                                                             self.view.frame.size.width,
                                                                             self.view.frame.size.height-44)];
    self.retargetingView.retargetingViewController = self;
    self.retargetingView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                             UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.retargetingView];
}
- (void) setupSplitContainer {
    //setup split view container
    self.splitContainerView = [[SplitContainerView alloc] initWithFrame:CGRectMake(-10000, 0, 10, 10)];
    self.splitContainerView.retargetingViewController = self;
    [self.retargetingView addSubview:self.splitContainerView];
    
    //setup saliency view picture frame
    self.saliencyPictureFrameView = [[PictureFrameView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    [self.splitContainerView addSubview:self.saliencyPictureFrameView];
    self.saliencyImageView = [[SaliencyImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.saliencyImageView.dataSource = self;
    self.saliencyImageView.paintingDelegate = self;
    [self.saliencyPictureFrameView addSubview:self.saliencyImageView];
    
    //setup warp view picture frame
    self.warpPictureFrameView = [[PictureFrameView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    [self.splitContainerView addSubview:self.warpPictureFrameView];
    self.warpImageView = [[WarpImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.warpImageView.dataSource = self;
    [self.warpPictureFrameView addSubview:self.warpImageView];
    
    self.splitContainerView.saliencyPictureFrameView = self.saliencyPictureFrameView;
    self.splitContainerView.warpPictureFrameView = self.warpPictureFrameView;    
}
- (void) setupCombinedContainer {
    //setup combined container view
    self.combinedContainerView = [[CombinedContainerView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.combinedContainerView.retargetingViewController = self;
    self.combinedContainerView.dataSource = self;
    self.combinedContainerView.paintingDelegate = self;
    [self.retargetingView addSubview:self.combinedContainerView];
    
    //setup combined view picture frame
    self.combinedPictureFrameView = [[PictureFrameView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.combinedPictureFrameView.dataSource = self;
    [self.combinedContainerView addSubview:self.combinedPictureFrameView];
    //setup combined view
    self.combinedView = [[CombinedView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.combinedView.dataSource = self;
    self.combinedView.paintingDelegate = self;
    [self.combinedPictureFrameView addSubview:self.combinedView];
    self.combinedContainerView.combinedPictureFrameView = self.combinedPictureFrameView;
    self.combinedContainerView.combinedSaliencyView = self.combinedView.saliencyView;    
}

- (void) setupToolbar {
    // setup toolbar
    self.toolbar = [[RetargetingToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) andRetargetingViewController:self];
    self.toolbar.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    self.toolbar.barStyle = UIBarStyleDefault;
    [self.view addSubview:self.toolbar];    
}
#pragma mark ViewController methods

- (RetargetingViewController *) init {
    self = [super init];
    self.projectController = [ProjectController sharedProjectController];
    self.retargetingState = [[RetargetingState alloc] init];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRetargetingView];
    [self setupSplitContainer];
    [self setupCombinedContainer];
    [self setupToolbar];
    [self setLayoutMode:[self layoutMode]];
    
    //initialize with first image
//    self.retargetingState.targetSize=self.warpImageView.frame.size;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"child" ofType:@"png"];
//    [self loadImageWithPath:path];
    // -> not needed anymore -> projects
    [self.warpImageView reloadImage];
    [self.saliencyImageView reloadImage];
    [self.combinedView reloadImage];
    [self layoutRetargetingSubviews];
    
    // settings preparations
    self.settingViewController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped andDataSourceDelegate:self];
    
    // setup ratio picker
    self.ratioPicker = [[RatioPicker alloc] initWithStyle:UITableViewStyleGrouped andDataSourceDelegate:self];
    
    NSLog(@"maximal texture size on this device: %d",GL_MAX_TEXTURE_SIZE);
}

- (void) viewWillAppear:(BOOL)animated
{
    //NSLog(@"ViewWillAppear");
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

- (IBAction)settings:(id)sender {
    NSLog(@"Settings");
    [self dismissAllPopovers];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.settingsPopover = [[UIPopoverController alloc] initWithContentViewController:self.settingViewController];
        self.settingsPopover.popoverContentSize = CGSizeMake(360, 600);
        self.settingsPopover.delegate = self;
        [self.settingsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:self.settingViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

- (IBAction)ratioPicker:(id)sender {
    NSLog(@"ratio picker");
    [self dismissAllPopovers];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.ratioPickerPopover = [[UIPopoverController alloc] initWithContentViewController:self.ratioPicker];
        self.ratioPickerPopover.popoverContentSize = CGSizeMake(280, 700);
        self.ratioPickerPopover.delegate = self;
        [self.ratioPickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:self.ratioPicker];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
}
-(void)didFinishEditingSetting:(id)sender {
    [self.settingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)didFinishChoosingRatio:(id)sender {
    [self.ratioPicker dismissViewControllerAnimated:YES completion:nil];
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
        //todo make it work on iphones as well -> modal
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
    if(self.ratioPickerPopover) {
        [self.ratioPickerPopover dismissPopoverAnimated:YES];
        self.ratioPickerPopover = nil;
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
        
        [self saveOpenProject];

        Project * project = [self.projectController createProject];
        project.originalImage = retargetingImage.image;
        [retargetingImage scaleImageToSize:600];
        project.previewImage = retargetingImage.image;
        [self.projectController openProject:project];
        [self.libraryViewController.galleryView loadProjects];
        [self.libraryViewController.galleryView layoutSubviews];
        [self loadProject];
        [self setShowSaliency:NO];
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

- (void)               image: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo {
    
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(exportAlertView != Nil) {
        //stop indicator
        [exportActivityIndicatorView stopAnimating];
//        exportAlertView.title  = @"Export completed";
//        exportAlertView.message = [NSString stringWithFormat:@"saved image of size %.0fx%.0f px",image.size.width, image.size.height];
//        exportAlertView.cancelButtonIndex = [exportAlertView addButtonWithTitle:@"OK"];
//        NSLog(@"%d buttons for alert",[exportAlertView numberOfButtons]);
        [exportAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
//    NSString * message = [NSString stringWithFormat:@"saved image of size %.0fx%.0f px",
//                          image.size.width,
//                          image.size.height];
    NSString * message = @"The retargeted image was saved to your camera roll.";
    exportAlertView = [[UIAlertView alloc] initWithTitle:@"Export completed"
                                                 message:message
                                                    delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil, nil];
    [exportAlertView show];
    
}
- (IBAction)exportImage:(id)sender
{
//    NSLog(@"export image");

    // show activity indicator to the user
    exportActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 80, 30, 30)];
    exportActivityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    exportActivityIndicatorView.hidesWhenStopped = YES;
    exportAlertView = [[UIAlertView alloc] initWithTitle:@"Export Image"
                                                     message:@"rendering..."
                                                    delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [exportAlertView addSubview:exportActivityIndicatorView];
    [exportActivityIndicatorView startAnimating];
    [exportAlertView show];


    ExportRenderer * exportRenderer = [[ExportRenderer alloc] init];
    exportRenderer.dataSource = self;
    UIImage * renderImage = [exportRenderer renderToImage];
    printf("got rendered image of size %f %f\n",renderImage.size.width, renderImage.size.height);
//    UIImageView * testImageView = [[UIImageView alloc] initWithImage:testRendering];
//    [self.view addSubview:testImageView];
    
    UIImageWriteToSavedPhotosAlbum(renderImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

- (IBAction)automaticSaliency:(id)sender {

    
    [self.retargetingState automaticSaliency];
//    [self layoutRetargetingSubviews];
    [self.combinedView setShowSaliency:self.showSaliency];

    [self.saliencyImageView bindSaliencyTexture];
    [self.saliencyImageView setNeedsDisplay];
    [self.warpImageView setNeedsDisplay];
//    [self.combinedContainerView layoutSubviews];
    [self.combinedView bindSaliencyTexture];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
    
    
}

- (IBAction)resetSaliency:(id)sender
{
    //NSLog(@"reset Saliency");
    //NSLog(@"%lf %lf",self.retargetingView.frame.size.height, self.saliencyImageView.frame.size.height);
    [self.retargetingState resetSaliency];
    [self layoutRetargetingSubviews];
    [self.saliencyImageView bindSaliencyTexture];
    [self.saliencyImageView setNeedsDisplay];
    [self.warpImageView setNeedsDisplay];
//    [self.combinedContainerView layoutSubviews];
    [self.combinedView bindSaliencyTexture];
    [self.combinedView setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Data Source Protocols
// Data Source Protocol methods for Saliency Paint View and Warp View
// warp view protocol methods
- (RetargetingTask *)task {
    return self.retargetingState.task;
}
- (CGSize)targetImageSize {
    return self.retargetingState.targetSize;
}
- (NSString *)name{
    return @"Retargeting View Controller";
}
- (double)targetRatio {
    return self.retargetingState.targetRatio;
}
- (void)setTargetRatio:(double)factor {
    // assert that it is within 1/10 to 10/1 of the original ratio
    #define RESIZE_FACTOR 10
    double targetRatio = factor;
    targetRatio = MIN(targetRatio, RESIZE_FACTOR*self.retargetingState.sourceRatio);
    targetRatio = MAX(targetRatio, 1.0/RESIZE_FACTOR*self.retargetingState.sourceRatio);
    
    self.retargetingState.targetRatio = targetRatio;
    self.retargetingState.targetSize = CGSizeMake(self.retargetingState.targetRatio, 1.0);
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews]; // we need to layout this late such that we already know what part will be cropped
}
- (void)changeTargetRatio:(double)factor {
    [self setTargetRatio:self.targetRatio*factor];
}

// view protocol methods for both views
- (UIImage *)originalImage {
    return self.retargetingState.originalImage;
}
- (void *)imageTexture {
    return self.retargetingState.imageTexture;
}
- (bool) useMipMaps {
    return self.retargetingState.useMipMaps;
}
- (CGSize) originalSize {
    return self.retargetingState.originalSize;
}
- (CGSize) textureSize {
    return self.retargetingState.textureSize;
}
// saliency view protocol methods
#pragma mark SaliencyViewProtocol methods
- (GLubyte *)saliencyImage {
    return self.retargetingState.saliencyMap;
}

- (CGSize) saliencyMapSize {
    return self.retargetingState.saliencyMapSize;
}

- (CGSize) saliencyTextureSize {
    return self.retargetingState.saliencyTextureSize;
}
- (double)sourceRatio {
    return self.retargetingState.sourceRatio;
}

- (void)paintAtPosition:(CGPoint)point {
    [self.retargetingState paintAtPosition:point];
    [self.retargetingState calculateWarp]; // force it directly to be able to track painting point 
    self.saliencyImageView.needsSaliencyRebind = YES;
    [self.saliencyImageView setNeedsDisplay];
    [self.warpImageView setNeedsDisplay];
    self.combinedView.needsSaliencyRebind = YES;
    [self.combinedView setNeedsDisplay];
}

// settings
#pragma mark Settings
- (double)laplacianRegularizationWeight {
    return self.retargetingState.laplacianRegularizationWeight;
}
- (void)setLaplacianRegularizationWeight:(double)aLaplacianRegularizationWeight {
    self.retargetingState.laplacianRegularizationWeight = aLaplacianRegularizationWeight;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}
- (double)LFactor {
    return self.retargetingState.LFactor;
}
- (void)setLFactor:(double)aLFactor {
    self.retargetingState.LFactor = aLFactor;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}
- (bool)paintMode {
    return self.retargetingState.paintMode;
}
- (void)setPaintMode:(bool)aPaintMode {
    self.retargetingState.paintMode = aPaintMode;
    [self.toolbar showPaintButton];

}
- (double)brushSize {
    return self.retargetingState.brushSize;
}
- (void)setBrushSize:(double)aBrushSize {
    self.retargetingState.brushSize = aBrushSize;
}
- (int)upsamplingFactor {
    return self.retargetingState.upsamplingFactor;
}
- (void)setUpsamplingFactor:(int)aFactor {
    self.retargetingState.upsamplingFactor = aFactor;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}

- (LayoutType)layoutMode {
    return self.retargetingState.layoutMode;
}
- (void)setLayoutMode:(LayoutType)aMode {
    self.retargetingState.layoutMode = aMode;
    [self.toolbar showLayoutButton];
    [UIView animateWithDuration:1.0 animations:^{
        if(self.retargetingState.layoutMode == kLayoutModeCombined) [self showCombinedLayout];
        else [self showSplitLayout];
        [self layoutRetargetingSubviews];
    }];
}
- (bool)showSaliency {
    return self.retargetingState.showSaliency;
}
- (void)setShowSaliency:(bool)aShowSaliency {
    self.retargetingState.showSaliency = aShowSaliency;
    [UIView animateWithDuration:0.7
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [self.combinedView setShowSaliency:self.showSaliency];
                         [self.combinedContainerView layoutSubviews];
                         [self.toolbar showSaliencyButton];
                         [self.combinedView setNeedsDisplay];
                         [self.saliencyImageView setNeedsDisplay];
                     }
                     completion:nil];
}
- (bool)showGrid {
    return self.retargetingState.showGrid;
}
- (void)setShowGrid:(bool)aShowGrid {
    self.retargetingState.showGrid = aShowGrid;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
}
- (bool)motionCompensation {
    return self.retargetingState.motionCompensation;
}
- (void)setMotionCompensation:(bool)aMode {
    self.retargetingState.motionCompensation = aMode;
}

// cropping
- (bool)croppingFlag {
    return self.retargetingState.croppingFlag;
}
- (void)setCroppingFlag:(bool)aCroppingFlag {
    self.retargetingState.croppingFlag = aCroppingFlag;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self layoutRetargetingSubviews];
//    [self.combinedContainerView layoutSubviews];
    [self.combinedView setNeedsDisplay];
}
- (double)croppingAlpha {
    return self.retargetingState.croppingAlpha;
}
- (void)setCroppingAlpha:(double)aCroppingAlpha {
    self.retargetingState.croppingAlpha = aCroppingAlpha;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}
- (double)croppingBeta {
    return self.retargetingState.croppingBeta;
}
- (void)setCroppingBeta:(double)aCroppingBeta {
    self.retargetingState.croppingBeta = aCroppingBeta;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}
- (double)croppingGamma {
    return self.retargetingState.croppingGamma;
}
- (void)setCroppingGamma:(double)aCroppingGamma {
    self.retargetingState.croppingGamma = aCroppingGamma;
    self.retargetingState.needsRecalc = YES;
    [self.warpImageView setNeedsDisplay];
    [self.combinedView setNeedsDisplay];
    [self layoutRetargetingSubviews];
}
- (void)setDefaultParameterSettingsWithCropping:(bool)croppingFlag {
    [self.retargetingState setDefaultParameterSettingsWithCropping:croppingFlag];
}
- (void)resetDefaultParameterSettings {
    [self.retargetingState resetDefaultParameterSettings];
}


#pragma mark CombinedViewProtocol Methods

- (double)zoomFactor {
    return self.retargetingState.zoomFactor;
}

#define  MAX_ZOOM_FACTOR 2.5

- (void)setZoomFactor:(double)aFactor {
    aFactor = MIN(aFactor, MAX_ZOOM_FACTOR);
    self.retargetingState.zoomFactor = aFactor;
//    self.retargetingState.needsRecalc = YES;
    [self layoutRetargetingSubviews];
    [self.combinedView setNeedsDisplay];
}
- (void)setZoomFactor:(double)aFactor animated:(bool)animated {
    aFactor = MIN(aFactor, MAX_ZOOM_FACTOR);
    if(animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             [self setZoomFactor:aFactor];
                             if(aFactor == 1.0) {
                                 [self setTranslationVector:CGPointMake(0, 0)];
                             }
                         }
                         completion:^(BOOL finished) {
                             //                             NSLog(@"reset zoom");
                         }];
    } else {
        [self setZoomFactor:aFactor];
    }
}

- (CGPoint)translationVector {
    return self.retargetingState.translationVector;
}
- (void)setTranslationVector:(CGPoint)aVector {
    self.retargetingState.translationVector = aVector;
    [self.combinedContainerView layoutSubviews];
}

- (void)setTranslationVector:(CGPoint)aVector animated:(bool)animated {
    if(animated) {
        [UIView animateWithDuration:0.2
                              delay:0.1
                            options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             [self setTranslationVector:aVector];
                         }
                         completion:^(BOOL finished){
//                             [self performSelector:@selector(setShowSaliency:) withObject:NO afterDelay:1.0];
                         }];
    } else {
        [self setTranslationVector:aVector];
    }
}
- (double) cropPreviewRatio {
    return self.retargetingState.cropPreviewRatio;
}
- (CGSize)cropPreviewSize {
    return self.retargetingState.cropPreviewSize;
}
- (CGRect)cropPreviewInnerRect {
    return self.retargetingState.cropPreviewInnerRect;
}


#pragma mark Toolbar Button Methods
- (void)toggleLayoutButton {
    if([self layoutMode] == kLayoutModeCombined) {
        [self setLayoutMode:kLayoutModeConcatenateBoth];
    } else {
        [self setLayoutMode:kLayoutModeCombined];
    }
    [self.settingViewController.tableView reloadData];
}
- (void)togglePaintButton {
    [self setPaintMode:![self paintMode]];
    [self.settingViewController.tableView reloadData];
}
- (void)toggleSaliencyButton {
    [self setShowSaliency:![self showSaliency]];
    [self.settingViewController.tableView reloadData];
}
#pragma mark Project Handling
- (void)loadProject {
    [self loadImage:self.projectController.openProject.originalImage];
    if(self.projectController.openProject.saliencyImage == nil ) {
        [self.retargetingState createInitialSaliency];
    } else {
        [self.retargetingState loadSaliencyImage:self.projectController.openProject.saliencyImage];
    }
    if(self.projectController.openProject.targetRatio != nil) {
        [self setTargetRatio:[self.projectController.openProject.targetRatio doubleValue]];
    }
    [self.warpImageView reloadImage];
    [self.saliencyImageView reloadImage];
    [self.combinedView reloadImage];
    [self setPaintMode:YES];
    [self layoutRetargetingSubviews];
}
- (void)saveOpenProject {
    self.projectController.openProject.saliencyImage = [self.retargetingState saveSaliencyImage];
    
    ExportRenderer * exportRenderer = [[ExportRenderer alloc] init];
    exportRenderer.dataSource = self;
    UIImage * renderImage = [exportRenderer renderToSquarePreview];
    self.projectController.openProject.previewImage = renderImage;
    //save target ratio
//    NSLog(@"save target ratio %lf",self.retargetingState.targetRatio);
    self.projectController.openProject.targetRatio = [NSNumber numberWithDouble:self.retargetingState.targetRatio];
    //    [self.view addSubview:[[UIImageView alloc] initWithImage:self.projectController.openProject.previewImage]];
    [self.libraryViewController closeProject:self.projectController.openProject];
    [self.projectController closeOpenProject];
    [self.retargetingState unloadImage];
    [self.warpImageView unloadTextures];
    [self.saliencyImageView unloadTextures];
    [self.combinedView unloadTextures];
}
- (void)closeProject:(id)sender {
    [self saveOpenProject];
    [self dismissAllPopovers];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
