//
//  ThumbnailView.m
//  Retargeting
//
//  Created by Daniel Graf on 25.01.13.
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

#import "ThumbnailView.h"

@implementation ThumbnailView {
    UIImageView * imageView;
    RoundedRectView * roundedRectView;
    int padding;
    UIAlertView * deleteAlert;
}
@synthesize libraryViewController=_libraryViewController;
@synthesize project = _project;
- (void) loadPreviewImage {
    
    // first remove the previous image
    for (UIView * subview in self.subviews) {
        [subview removeFromSuperview];
    }
    // search for new image
    UIImage * previewImage = self.project.previewImage;
    if(previewImage == nil) previewImage = self.project.originalImage;
    if(previewImage == nil) return;
    
    CGFloat previewRatio = previewImage.size.width / previewImage.size.height;
    CGFloat previewWidth = 0;
    CGFloat previewHeight = 0;
    
    CGFloat frameOffsetX = 0;
    CGFloat frameOffsetY = 0;
    
    if(previewRatio > 1.0) {
        previewWidth = self.frame.size.width-2*padding;
        previewHeight = previewWidth / previewRatio;
        frameOffsetX = 0;
        frameOffsetY = (self.frame.size.height-previewHeight-2*padding)/2;
    } else {
        previewHeight = self.frame.size.height-2*padding;
        previewWidth = previewHeight * previewRatio;
        frameOffsetY = 0;
        frameOffsetX = (self.frame.size.width-previewWidth-2*padding)/2;
    }
    
    
    // white background view
    roundedRectView = [[RoundedRectView alloc] init];
    roundedRectView.frame = CGRectMake(frameOffsetX,
                                       frameOffsetY,
                                       previewWidth+2*padding,
                                       previewHeight+2*padding);
    roundedRectView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleHeight);
    [roundedRectView setCornerRadius:padding];
    [self addSubview:roundedRectView];
    
    
    // UIImage view for the thumbnail
    imageView = [[UIImageView alloc] initWithImage:previewImage];
    imageView.contentMode = UIViewContentModeScaleToFill;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(frameOffsetX+padding,
                                 frameOffsetY+padding,
                                 previewWidth,
                                 previewHeight);
    imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleHeight);

    [self addSubview:imageView];
}
- (void)reloadImage {
    [self loadPreviewImage];
}
- (void)layoutSubviews {
    CGFloat previewRatio = self.project.previewImage.size.width / self.project.previewImage.size.height;
    CGFloat previewWidth = 0;
    CGFloat previewHeight = 0;
    
    CGFloat frameOffsetX = 0;
    CGFloat frameOffsetY = 0;
    
    if(previewRatio > 1.0) {
        previewWidth = self.frame.size.width-2*padding;
        previewHeight = previewWidth / previewRatio;
        frameOffsetX = 0;
        frameOffsetY = (self.frame.size.height-previewHeight-2*padding)/2;
    } else {
        previewHeight = self.frame.size.height-2*padding;
        previewWidth = previewHeight * previewRatio;
        frameOffsetY = 0;
        frameOffsetX = (self.frame.size.width-previewWidth-2*padding)/2;
    }
    roundedRectView.frame = CGRectMake(frameOffsetX,
                                       frameOffsetY,
                                       previewWidth+2*padding,
                                       previewHeight+2*padding);

    imageView.frame = CGRectMake(frameOffsetX+padding,
                                 frameOffsetY+padding,
                                 previewWidth,
                                 previewHeight);
}

- (ThumbnailView *) setProjectID:(NSString *) projectID {

    self.project = [[Project alloc] initProjectWithID:projectID];
    [self loadPreviewImage];
    return self;
}
- (void) setPaddingFactor:(int)factor {
    padding = 5.0/sqrt(sqrt(factor)); // make smaller borders if more columns shown
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) padding *= 2;
    [roundedRectView setCornerRadius:padding];
//    self.layer.cornerRadius = padding;
    [self layoutSubviews];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setPaddingFactor:1.0];
//        self.backgroundColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeCenter;
        self.layer.masksToBounds = YES;

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(singleTap:)];
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(longPress:)];
        [self addGestureRecognizer:tapRecognizer];
        [self addGestureRecognizer:longPressRecognizer];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == deleteAlert) {
        if(buttonIndex == 0) {
            NSLog(@"not deleted project");
        } else {
            NSLog(@"delete project with id %@",self.project.projectID);
            [self.libraryViewController.projectController deleteProject:self.project];
            [self.libraryViewController.galleryView loadProjects];
            [self.libraryViewController.galleryView layoutSubviews];
        }
        deleteAlert = nil;
    }
}
- (void)longPress:(UITapGestureRecognizer *)gesture {
    if(deleteAlert == nil) {
        deleteAlert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                         message:@"Do you want to delete this image from the retargeting library?"
                                                        delegate:self
                                               cancelButtonTitle:@"No"
                                               otherButtonTitles:@"Yes", nil];
        [deleteAlert show];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)gesture {
    [self.libraryViewController editProject:self.project];
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
