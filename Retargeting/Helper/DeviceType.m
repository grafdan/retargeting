//
//  DeviceType.m
//  Refooormat
//
//  Created by Daniel Graf on 09.05.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import "DeviceType.h"
#include <sys/sysctl.h>

@implementation DeviceType
+ (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *) platform
{
    return [self getSysInfoByName:"hw.machine"];
}

@end
