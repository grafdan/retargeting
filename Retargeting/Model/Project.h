//
//  Project.h
//  Retargeting
//
//  Created by Daniel Graf on 24.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectController.h"

@interface Project : NSObject
@property (nonatomic,strong) NSMutableDictionary *attributes;
@property (nonatomic,strong) NSString * projectID;
@property (nonatomic,strong) NSNumber * targetRatio;
@property (nonatomic,strong) UIImage * originalImage;
@property (nonatomic,strong) UIImage * saliencyImage;
@property (nonatomic,strong) UIImage * exportImage;
@property (nonatomic,strong) UIImage * previewImage;
@property (nonatomic,strong) NSString * imageHash;
- (Project *) initProjectWithID:(NSString *)projectID;
- (void) deleteFromFileSystem;
@end
