//
//  RetargetingContext.m
//  Retargeting
//
//  Created by Daniel Graf on 07.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "RetargetingContext.h"

@implementation RetargetingContext

@synthesize context = _context;

static RetargetingContext *sharedRetargetingContext = nil;

+ (RetargetingContext*)sharedContext
{
    if (sharedRetargetingContext == nil) {
        sharedRetargetingContext = [[super allocWithZone:NULL] init];
    }
    return sharedRetargetingContext;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedContext];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (RetargetingContext *)init
{
    self = [super init];
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    return self;
}
@end
