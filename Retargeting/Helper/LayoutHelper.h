//
//  LayoutHelper.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayoutHelper : NSObject
+ (CGRect) zoomedFrameAroundCenterWithRect:(CGRect)aRect andZoomFactor:(double)aFactor;
+ (CGRect) centeredRectInBoundingBox:(CGRect)box withRatio:(double)ratio;

@end
