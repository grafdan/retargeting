//
//  Project.m
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

#import "Project.h"

@implementation Project

@synthesize projectID = _projectID;
@synthesize attributes = _attributes;
@synthesize originalImage = _originalImage;
@synthesize saliencyImage = _saliencyImage;
@synthesize previewImage = _previewImage;
@synthesize imageHash = _imageHash;

- (void) setProjectID:(NSString *)projectID {
    _projectID = projectID;
    [self.attributes setObject:projectID forKey:@"projectID"];
    [self saveAttributes];
}

- (void) setTargetRatio:(NSNumber *)targetRatio {
    _targetRatio = targetRatio;
    [self.attributes setObject:targetRatio forKey:@"targetRatio"];
    [self saveAttributes];
}
- (void) saveAttributes {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@.plist",self.projectID,@"attributes"]];

//    for (NSString *key in self.attributes) {
//        NSObject * value = [self.attributes objectForKey:key];
//        NSLog(@"Key %@ - Value %@", key,value);
//    }
    
    if([self.attributes writeToFile:path atomically:YES]) {
//        NSLog(@"saving attributes successful");
    } else {
        NSLog(@"saving attributes failes");
    }
}
- (void) loadAttributes {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@.plist",self.projectID,@"attributes"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"no attributes saved so far");
        self.attributes = [[NSMutableDictionary alloc] init];
    } else {
        self.attributes = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        _projectID = [self.attributes objectForKey:@"projectID"];
        _targetRatio = [self.attributes objectForKey:@"targetRatio"];
    }
}

- (UIImage *) loadImage:(NSString *)fileName {
    NSString * path;
    // try png first
    path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@.png",self.projectID,fileName]];
    
    // jpg if not there
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@.jpg",self.projectID,fileName]];
    }
    // if still no file -> return nil
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"There is no image at path %@",path);
        return nil;
    }
    // load image
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if(image == nil) {
        NSLog(@"Loading the image at path %@ failed.",path);
    } else {
//        NSLog(@"Loading the image at path %@ was successful.",path);
    }
    return image;
}

- (void) saveImage:(UIImage *)image toFile:(NSString *)fileName {
    if(image == nil) {
        NSLog(@"image %@ is nil -> no need to save it",fileName);
        return;
    }
    // Convert UIImage to PNG
//    NSData *imgData = UIImagePNGRepresentation(image);
    NSData *imgData;
    NSString *suffix;
    if([fileName isEqualToString:@"image"]) {
        imgData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
        suffix = @"jpg";
    } else {
        imgData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        suffix = @"png";
    }
    // Identify the home directory and file name

    NSString  *folderpath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",self.projectID]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderpath]) {
        NSError* error;
        //Create folder
        if(![[NSFileManager defaultManager] createDirectoryAtPath:folderpath withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Error when creating folder %@: %@",folderpath, error.description);
            return;
        }
    }
    NSString * path = [folderpath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,suffix]];
//    NSLog(@"filepath %@",path);
    
    // Write the file.  Choose YES atomically to enforce an all or none write. Use the NO flag if partially written files are okay which can occur in cases of corruption
    if([imgData writeToFile:path atomically:YES]) {
//        NSLog(@"Successfully written %@",path);
    } else {
        NSLog(@"Error when saving %@",path);
    }

}

- (void)setOriginalImage:(UIImage *)originalImage {
    _originalImage = originalImage;
    [self saveImage:_originalImage toFile:@"image"];
}
- (UIImage *)originalImage {
    if(_originalImage == nil) {
        _originalImage = [self loadImage:@"image"];
        if(_originalImage == nil) {
            // something bad happened, e.g. the app crashed when creating the project before the
            // image was stored to disk
            [[ProjectController sharedProjectController] deleteProject:self];
        }
    }
    return _originalImage;
}


- (void)setSaliencyImage:(UIImage *)saliencyImage {
    _saliencyImage = saliencyImage;
    [self saveImage:_saliencyImage toFile:@"saliency"];
}
- (UIImage *)saliencyImage {
    if(_saliencyImage == nil) {
        _saliencyImage = [self loadImage:@"saliency"];
    }
    return _saliencyImage;
}
- (void)setPreviewImage:(UIImage *)previewImage {
    _previewImage = previewImage;
    [self saveImage:_previewImage toFile:@"preview"];
}
- (UIImage *)previewImage {
    if(_previewImage == nil) {
        _previewImage = [self loadImage:@"preview"];
    }
    return _previewImage;
}

//- (void) saveProjectToDisk {
//    NSLog(@"save project %@",self.projectID);
//    [self saveImage:self.saliencyImage toFile:@"saliency"];
//    [self saveImage:self.originalImage toFile:@"image"];
//    [self saveImage:self.previewImage toFile:@"preview"];
//}

- (void) deleteFromFileSystem {
    NSString  *folderpath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",self.projectID]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:folderpath]) {
            [fileManager removeItemAtPath:folderpath error:nil];
    }
}
- (Project *) initProjectWithID:(NSString *)projectID {
    _projectID = projectID;
    [self loadAttributes];
    self.projectID = projectID;
//    NSLog(@"load project %@",self.projectID);
//    self.originalImage = [self loadImage:@"image"];
//    self.saliencyImage = [self loadImage:@"saliency"];
//    self.previewImage = [self loadImage:@"preview"];
    return self;
}

@end
