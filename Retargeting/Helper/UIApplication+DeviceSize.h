//
//  UIApplication+UIApplication_currentSize.h
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (DeviceSize)
+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;

@end
