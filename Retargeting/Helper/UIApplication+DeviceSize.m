//
//  UIApplication+UIApplication_currentSize.m
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "UIApplication+DeviceSize.h"

@implementation UIApplication (DeviceSize)

+(CGSize) currentSize
{
    return [UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}

@end
