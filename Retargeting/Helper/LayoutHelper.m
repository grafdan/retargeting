//
//  LayoutHelper.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
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
