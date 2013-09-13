//
//  ProjectController.m
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

#import "ProjectController.h"

@implementation ProjectController
@synthesize projects = _projects;
@synthesize nextFreeID = _nextFreeID;
@synthesize openID = _openID;
@synthesize openProject = _openProject;



//singleton methods
static ProjectController *sharedProjectController = nil;

+ (ProjectController *)sharedProjectController
{
    if (sharedProjectController == nil) {
        sharedProjectController = [[super allocWithZone:NULL] init];
    }
    return sharedProjectController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedProjectController];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


- (void)setNextFreeID:(NSString *)nextFreeID {
    _nextFreeID = nextFreeID;
    [[NSUserDefaults standardUserDefaults] setValue:_nextFreeID forKey:@"nextFreeID"];
}

-(NSString *) nextFreeID {
    if(_nextFreeID == nil) {
        _nextFreeID = [[NSUserDefaults standardUserDefaults] valueForKey:@"nextFreeID"];
        if(_nextFreeID == nil) {
            self.nextFreeID = @"1"; // very first initialisation
        }
    }
    return _nextFreeID;
}

-(void)setOpenID:(NSString *)openID {
    _openID = openID;
    [[NSUserDefaults standardUserDefaults] setValue:_openID forKey:@"openID"];
}

- (NSArray *)projects {
    if(_projects == nil) {
        _projects = [[NSUserDefaults standardUserDefaults] valueForKey:@"projects"];
        if(_projects == nil) {
            self.projects = [NSArray array]; // very first initialisation
        }
    }
    return _projects;

}
- (void) setProjects:(NSArray *)projects {
    _projects = projects;
    [[NSUserDefaults standardUserDefaults] setValue:_projects forKey:@"projects"];
}

- (Project *) createProject {
    Project * newProject = [[Project alloc] initProjectWithID:self.nextFreeID];

    // increase next free ID
    self.nextFreeID = [NSString stringWithFormat:@"%d",[self.nextFreeID integerValue] +1];

    // add to project library
    self.projects = [self.projects arrayByAddingObject:newProject.projectID];

    return newProject;
}

- (void) deleteProject:(Project *)project {
    [project deleteFromFileSystem];
        
    NSMutableArray * newProjects = [[NSMutableArray alloc] initWithArray:self.projects];
    NSLog(@"delete project\ncount before %d",[self.projects count]);
    [newProjects removeObjectIdenticalTo:project.projectID];
    self.projects = newProjects;
    NSLog(@"count after %d",[self.projects count]);
}
- (void) openProject:(Project *)project {
    self.openID = project.projectID;
    self.openProject = project;
}

- (void) closeOpenProject {
    if(self.openProject == nil || self.openID == nil) return;
    self.openProject = nil;
    self.openID = nil;
}

- (ProjectController *)init {
    self = [super init];
    
    return self;
}
@end
