//
//  LayoutHelper.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "LayoutHelper.h"

@implementation LayoutHelper

+ (CGRect) zoomedFrameAroundCenterWithRect:(CGRect)aRect andZoomFactor:(double)aFactor {
    CGPoint center = CGPointMake(aRect.origin.x + aRect.size.width/2, aRect.origin.y + aRect.size.height/2);
    CGSize size = CGSizeMake(aFactor*aRect.size.width, aFactor*aRect.size.height);
    CGRect result = CGRectMake(center.x-size.width/2, center.y - size.height/2, size.width, size.height);
    return result;
}

+ (CGRect) centeredRectInBoundingBox:(CGRect)box withRatio:(double)ratio {
    CGFloat x=box.origin.x;
    CGFloat y=box.origin.y;
    CGFloat w=box.size.width;
    CGFloat h=box.size.height;
    
    double environmentRatio = w / h;
    if(environmentRatio > ratio) {
        // environment to wide
        w = h * ratio;
    } else {
        h = w / ratio;
    }
    //center picture vertically
    x = x+0.5*(box.size.width-w);
    y = y+0.5*(box.size.height-h);
    return CGRectMake(x, y, w, h);
}

@end
