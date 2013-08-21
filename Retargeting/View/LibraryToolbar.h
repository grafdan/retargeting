//
//  LibraryToolbar.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

@class  LibraryViewController;

#import <UIKit/UIKit.h>
#import "LibraryViewController.h"
@interface LibraryToolbar : UIToolbar
@property (nonatomic,weak) LibraryViewController * libraryViewController;
- (id)initWithFrame:(CGRect)frame andLibraryViewController:(LibraryViewController *)libraryViewController;

@end
