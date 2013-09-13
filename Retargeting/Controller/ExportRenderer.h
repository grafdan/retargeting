//
//  ExportRenderer.h
//  Retargeting
//
//  Created by Daniel Graf on 19.12.12.
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

#import <Foundation/Foundation.h>
#import "RetargetingTask.h"
#import "Grid.h"

@protocol ExportRendererDataSource <NSObject>

- (RetargetingTask *)task;
- (CGSize) originalSize;
- (CGSize) textureSize;
- (double) sourceRatio;
- (double) targetRatio;
- (bool) showGrid;
- (bool) useMipMaps;
- (void *)imageTexture;
- (void)setTargetRatio:(double)factor;

@end

@interface ExportRenderer : NSObject {
    GLuint framebuffer;
    GLuint colorRenderbuffer;
    GLuint depthRenderbuffer;
    GLuint texture;
    Grid * grid;
    
    GLubyte *exportImageData;
    GLubyte *tileImageData;
    NSInteger exportImageDataLength;
    NSInteger exportImageLineLength;
    NSInteger tileImageDataLength;
    NSInteger tileImageLineLength;

    int xChunk, yChunk;
    
}
@property (nonatomic) CGSize imageSize;
@property (nonatomic, weak) IBOutlet id <ExportRendererDataSource> dataSource;

- (UIImage *)renderToImage;
- (UIImage *)renderToSquarePreview;
@end
