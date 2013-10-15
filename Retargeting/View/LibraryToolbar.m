//
//  LibraryToolbar.m
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

#import "LibraryToolbar.h"

@implementation LibraryToolbar {
    UIBarButtonItem *toolBarTitle;
    double width;
}

@synthesize libraryViewController = _libraryViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeToolbar];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame andLibraryViewController:(LibraryViewController *)libraryViewController {
    self = [super initWithFrame:frame];
    self.libraryViewController = libraryViewController;
    if (self) {
        // Initialization code
        [self initializeToolbar];
    }
    frame.origin = CGPointMake(0, [UIApplication sharedApplication].statusBarFrame.size.height);
    return self;    
}

- (void)addSpace:(int)amount toArray:(NSMutableArray *)items {
    //little space
    UIBarButtonItem *space ;
    if(amount > 0) {
        space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                              target:nil
                                                              action:nil];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) space.width = 20;
        else space.width = 15;
    } else {
        space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                              target:nil
                                                              action:nil];
        
    }
    [items addObject:space];
    
}

- (void) initializeToolbar {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    //camera
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                   target:self.libraryViewController
                                                                   action:@selector(takePictureWithCamera:)]];
    
    //little space
    [self addSpace:1 toArray:items];
    
    //library
    NSString *libraryPath = [[NSBundle mainBundle] pathForResource:@"library" ofType:@"png"];
    UIImage *libraryImage = [[UIImage alloc] initWithContentsOfFile:libraryPath];

    [items addObject:[[UIBarButtonItem alloc] initWithImage:libraryImage
                                                      style:UIBarButtonItemStylePlain
                                                                   target:self.libraryViewController
                                                                   action:@selector(choosePictureFromLibrary:)]];
    //fill space
    [self addSpace:0 toArray:items];

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
       self.frame.size.width > 320) {
        toolBarTitle = [[UIBarButtonItem alloc] initWithTitle:@"Axis-Aligned Image Retargeting"
                                                        style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:nil];
    } else {
        toolBarTitle = [[UIBarButtonItem alloc] initWithTitle:@"Retargeting"
                                                        style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:nil];
        
    }
    [items addObject:toolBarTitle];
    
    //flexible space
    [self addSpace:0 toArray:items];
    
    //show Info
    NSString *infoPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"png"];
    UIImage *infoImage = [[UIImage alloc] initWithContentsOfFile:infoPath];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:infoImage
                                                      style:UIBarButtonItemStylePlain
                                                     target:self.libraryViewController
                                                     action:@selector(showInfo:)]];
    
    //fixed space
    [self addSpace:1 toArray:items];
    
    //show Info
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"png"];
    UIImage *helpImage = [[UIImage alloc] initWithContentsOfFile:helpPath];
    [items addObject:[[UIBarButtonItem alloc] initWithImage:helpImage
                                                      style:UIBarButtonItemStylePlain
                                                                   target:self.libraryViewController
                                                     action:@selector(showHelp:)]];
    
    [self setItems:items animated:NO];

}

- (void) layoutSubviews {
    [super layoutSubviews];
    if(self.frame.size.width != width) {
        width = self.frame.size.width;
        [self initializeToolbar];
    }
    //    NSLog(@"toolbar size w%lf h%lf",self.frame.size.width,self.frame.size.height);
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
