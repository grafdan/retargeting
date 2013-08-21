//
//  ExportRenderer.h
//  Retargeting
//
//  Created by Daniel Graf on 19.12.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

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
