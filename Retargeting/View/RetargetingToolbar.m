//
//  RetargetingToolbar.m
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
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

#import "RetargetingToolbar.h"

@implementation RetargetingToolbar {
    UIBarButtonItem *toolBarTitle;
    double width;
}
@synthesize retargetingViewController = _retargetingViewController;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeToolbar];
    }
    return self;    
}

- (id)initWithFrame:(CGRect)frame andRetargetingViewController:(RetargetingViewController *)retargetingViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.retargetingViewController = retargetingViewController;
        [self initializeToolbar];
    }
    return self;
}

- (void)showLayoutButton {
    if(self.retargetingViewController.layoutMode == kLayoutModeCombined) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"combined" ofType:@"png"];
        layoutToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"split" ofType:@"png"];
        layoutToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];        
    }
}

- (void)showPaintButton {
    if(self.retargetingViewController.paintMode == YES) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pen" ofType:@"png"];
        paintToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"eraser" ofType:@"png"];
        paintToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];
    }    
}

- (void)showSaliencyButton {
    if(self.retargetingViewController.showSaliency == YES) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"show" ofType:@"png"];
        saliencyToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hide" ofType:@"png"];
        saliencyToggleButton.image = [[UIImage alloc] initWithContentsOfFile:path];
    }    
}


- (void)addSpace:(int)amount toArray:(NSMutableArray *)items {
    //little space
    UIBarButtonItem *space ;
    if(amount > 0) {
        space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                              target:nil
                                                              action:nil];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) space.width = 20;
        else {
            if(self.frame.size.width == 480) { // make it slightly smaller for iPhone 4 landscape
                space.width = 13;
            } else if(self.frame.size.width == 568) { // and slightly bigger for iPhone 5 landscape
                space.width = 20;
            } else {
                space.width = 15;
            }
        }
    } else {
        space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil
                                                              action:nil];
        
    }
    [items addObject:space];
    
}
- (void)initializeToolbar
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    //close -> return to library
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                   target:self.retargetingViewController
                                                                   action:@selector(closeProject:)]];
    
    //little space
    [self addSpace:1 toArray:items];
    
    //settings
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"png"];
    UIImage *settingsImage = [[UIImage alloc] initWithContentsOfFile:settingsPath];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:settingsImage
                                                      style:UIBarButtonItemStylePlain
                                                     target:self.retargetingViewController
                                                     action:@selector(settings:)]];
    
    [self addSpace:1 toArray:items];
    

    //export image
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                   target:self.retargetingViewController
                                                                   action:@selector(exportImage:)]];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad  || //on iPad or landscape iPhones
       (self.frame.size.width > 320)) {
        //space
        [self addSpace:1 toArray:items];
        
        //camera
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                       target:self.retargetingViewController
                                                                       action:@selector(takePictureWithCamera:)]];
        
        //little space
        [self addSpace:1 toArray:items];
        
        //library
        NSString *libraryPath = [[NSBundle mainBundle] pathForResource:@"library" ofType:@"png"];
        UIImage *libraryImage = [[UIImage alloc] initWithContentsOfFile:libraryPath];
        [items addObject:[[UIBarButtonItem alloc] initWithImage:libraryImage
                                                          style:UIBarButtonItemStylePlain
                                                                       target:self.retargetingViewController
                                                                       action:@selector(choosePictureFromLibrary:)]];
        
    }
    //fill space
    [self addSpace:0 toArray:items];
    
    //title only on the iPad and iPhone Landscape
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        toolBarTitle = [[UIBarButtonItem alloc] initWithTitle:@""
                                                        style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:nil];
        [items addObject:toolBarTitle];
        
        //flexible space
        [self addSpace:0 toArray:items];
//    }
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
       (self.frame.size.width > 320)) { // also show on landscape iPhones
        //saliency toggle
        saliencyToggleButton = [[UIBarButtonItem alloc] init];
        saliencyToggleButton.target = self.retargetingViewController;
        saliencyToggleButton.action = @selector(toggleSaliencyButton);
        [self showSaliencyButton];
        [items addObject:saliencyToggleButton];
        
        //space
        [self addSpace:1 toArray:items];
        

      //layout toggle
        layoutToggleButton = [[UIBarButtonItem alloc] init];
        layoutToggleButton.target = self.retargetingViewController;
        layoutToggleButton.action = @selector(toggleLayoutButton);
        [self showLayoutButton];
        [items addObject:layoutToggleButton];
        
        //space
        [self addSpace:1 toArray:items];
    }
    
    
    //ratio picker
    NSString *ratioPath = [[NSBundle mainBundle] pathForResource:@"ratio" ofType:@"png"];
    UIImage *ratioImage = [[UIImage alloc] initWithContentsOfFile:ratioPath];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:ratioImage
                                                      style:UIBarButtonItemStylePlain
                                                     target:self.retargetingViewController
                                                     action:@selector(ratioPicker:)]];
    //space
    [self addSpace:1 toArray:items];
    
    //paint toggle
    paintToggleButton = [[UIBarButtonItem alloc] init];
    paintToggleButton.target = self.retargetingViewController;
    paintToggleButton.action = @selector(togglePaintButton);
    [self showPaintButton];
    [items addObject:paintToggleButton];
    
    //space
    [self addSpace:1 toArray:items];
 
    //automatic saliency toggle
    NSString *wizardPath = [[NSBundle mainBundle] pathForResource:@"wizard" ofType:@"png"];
    UIImage *wizardImage = [[UIImage alloc] initWithContentsOfFile:wizardPath];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:wizardImage
                                                      style:UIBarButtonItemStylePlain
                                                                   target:self.retargetingViewController
                                                                   action:@selector(automaticSaliency:)]];
    
    //space
    [self addSpace:1 toArray:items];
    

    
    //clear saliency
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                   target:self.retargetingViewController
                                                                   action:@selector(resetSaliency:)]];
    
    
    [self setItems:items animated:NO];
}
- (void) updateTitleToOrientation {
//    NSLog(@"width %f",[UIApplication sizeInOrientation:orientation].width);
//    NSLog(@"frame width %f",self.frame.size.width);
    
    // iPad: 1024 x 768
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.frame.size.width > 768) {
            toolBarTitle.title = @"Axis-Aligned Image Retargeting";
            return;
        }
        toolBarTitle.title = @"Image Retargeting";
        return;
    } else {
        // iPhone 5 320 x 568
        // iPhone 4 320 x 480
//        if (self.frame.size.width > 480) { // no title -> but also all buttons
//            toolBarTitle.title = @"Retargeting";
//            return;
//        }
    }
    
    toolBarTitle.title = @"";
    return;
}


- (void) layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"toolbar size w%lf h%lf",self.frame.size.width,self.frame.size.height);
    if(self.frame.size.width != width) {
        width = self.frame.size.width;
        [self initializeToolbar];
    }
    [self updateTitleToOrientation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
