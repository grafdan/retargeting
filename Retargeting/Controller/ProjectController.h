//
//  ProjectController.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
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
