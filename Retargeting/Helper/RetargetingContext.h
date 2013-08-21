//
//  RetargetingContext.h
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetargetingContext : NSObject
@property (nonatomic, retain) EAGLContext *context;
+ (RetargetingContext*)sharedContext;
@end
