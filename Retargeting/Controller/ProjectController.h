//
//  ProjectController.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
@class Project;

@interface ProjectController : NSObject
@property (nonatomic, strong) NSArray * projects;
@property (nonatomic, strong) NSString * nextFreeID;
@property (nonatomic, strong) NSString * openID;
@property (nonatomic, strong) Project * openProject;

+ (ProjectController*)sharedProjectController;

- (Project *) createProject;
- (void) openProject:(Project *)project;
- (void) deleteProject:(Project *)project;
- (void) closeOpenProject;
@end
