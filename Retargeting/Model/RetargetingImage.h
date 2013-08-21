//
//  RetargetingImage.h
//  Retargeting
//
//  Created by Daniel Graf on 16.12.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetargetingImage : NSObject
@property (nonatomic, retain) UIImage * image;
-(void)rotateImageToOrientation;
-(void)scaleImageToSize:(int)size;
@end
