//
//  ExportRenderer.m
//  Retargeting
//
//  Created by Daniel Graf on 19.12.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "ExportRenderer.h"

// size of a render buffer tile
#define CHUNK_SIZE 300
// small enough such that it would fit onto any iOS device

@implementation ExportRenderer

-(void) setup {
    glGenTextures(1, &texture);
    grid = [[Grid alloc] init];
}
-(void)createRenderbuffer {
    // according to page 29 of the OpenGL ES Programming Guide
    
    // create framebuffer
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    
    // create renderbuffer
    glGenRenderbuffers(1, &colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_RGB8_OES, CHUNK_SIZE, CHUNK_SIZE);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,GL_RENDERBUFFER, colorRenderbuffer);
    
    // create depth renderbuffer
    glGenRenderbuffers(1, &depthRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, CHUNK_SIZE,CHUNK_SIZE);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT,
                              GL_RENDERBUFFER, depthRenderbuffer);
    
    // check framebuffer for completeness
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER) ;
    if(status != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"failed to make complete framebuffer object %x", status);
    } else {
//        NSLog(@"export framebuffer successfully created");
    }
}

-(ExportRenderer *)init {
    [self setup];
    [self createRenderbuffer];
    return self;
}

- (void) extractImageTile {
    GLint backingWidth, backingHeight;
    
    // Bind the color renderbuffer used to render the OpenGL ES view
    // If your application only creates a single color renderbuffer which is already bound at this point,
    // this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
    // Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    
    // Get the size of the backing CAEAGLLayer
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    NSInteger width = backingWidth, height = backingHeight;
    tileImageDataLength = width * height * 4;
    tileImageLineLength = width * 4;
    tileImageData = (GLubyte*)malloc(tileImageDataLength * sizeof(GLubyte));
    
    // Read pixel data from the framebuffer
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, tileImageData);
    
    
    // copy the tile into the final image
    int tx = 0, ty = 0; // tile coordinates
    int x = 0, y = 0; // picture coordinates
    int w = self.imageSize.width;
    int h = self.imageSize.height;
    int ti, pi; // tile and picture indeces
    for(tx = 0; tx<backingWidth; tx++) {
        for(ty = 0; ty<backingHeight; ty++) {
            x = xChunk * CHUNK_SIZE + tx;
            y = yChunk * CHUNK_SIZE + ty;
            if(x<w && y < h) {
                ti = ty*tileImageLineLength + 4*tx;
                pi = y*exportImageLineLength + 4*x;
                for(int i=0;i<4;i++)
                    exportImageData[pi+i] = tileImageData[ti+i];
            }
        }
    }
    
    free(tileImageData);
    
}

- (UIImage *) extractImage {
    // Create a CGImage with the pixel data
    // If your OpenGL ES content is opaque, use kCGImageAlphaNoneSkipLast to ignore the alpha channel
    // otherwise, use kCGImageAlphaPremultipliedLast
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, exportImageData, exportImageDataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(self.imageSize.width,
                                    self.imageSize.height,
                                    8, 32, self.imageSize.width * 4, colorspace,
                                    kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);
    
    // OpenGL ES measures data in PIXELS
    // Create a graphics context with the target size measured in POINTS
    NSInteger widthInPoints, heightInPoints;
    //    if (NULL != UIGraphicsBeginImageContextWithOptions) {
    //        // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    //        // Set the scale parameter to your OpenGL ES view's contentScaleFactor
    //        // so that you get a high-resolution snapshot when its value is greater than 1.0
    //        CGFloat scale = eaglview.contentScaleFactor;
    //        widthInPoints = width / scale;
    //        heightInPoints = height / scale;
    //        UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
    //    }
    //    else {
    //        // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    widthInPoints = self.imageSize.width;
    heightInPoints = self.imageSize.height;
    UIGraphicsBeginImageContext(CGSizeMake(widthInPoints, heightInPoints));
    //    }
    
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    
    // UIKit coordinate system is upside down to GL/Quartz coordinate system
    // Flip the CGImage by rendering it to the flipped bitmap context
    // The size of the destination area is measured in POINTS
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);
    
    // Retrieve the UIImage from the current context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // Clean up
    free(exportImageData);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
    
    return image;
   
}

- (void) bindTexture {
//    [EAGLContext setCurrentContext:self.context];
//    printf("export texture ids: warp %d\n",texture);
    //enable texturing
    glBindTexture(GL_TEXTURE_2D, texture);
    if(self.dataSource.useMipMaps) {
        glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, GL_TRUE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    } else {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    }
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 1.0f);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    NSLog(@"Set Texture with size %f %f",self.dataSource.textureSize.width,self.dataSource.textureSize.height);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.dataSource.textureSize.width, self.dataSource.textureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.dataSource.imageTexture);
    
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error uploading texture. 	: 0x%04X", err);
}

- (void)unloadTextures {
    glDeleteTextures(1, &texture);
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error when deleting texture. 	: 0x%04X", err);
    glFlush();
}


- (void)setFullResolutionSize {
    // calculate size of the final image
    if(self.dataSource.targetRatio > self.dataSource.sourceRatio) { // wider than original
        // height is limiting
        self.imageSize = CGSizeMake(ceil(self.dataSource.originalSize.height * self.dataSource.targetRatio),
                                    ceil(self.dataSource.originalSize.height));
    } else {
        self.imageSize = CGSizeMake(ceil(self.dataSource.originalSize.width),
                                    ceil(self.dataSource.originalSize.width / self.dataSource.targetRatio));
    }
    // limit export resolution to 10 MP due to memory consumption on some devices
#define MAX_EXPORT_RESOLUTION 10000000
    double imageArea = self.imageSize.width*self.imageSize.height;
    if(imageArea > MAX_EXPORT_RESOLUTION) {
        double scalingFactor = sqrt(MAX_EXPORT_RESOLUTION/imageArea);
        self.imageSize = CGSizeMake(ceil(self.imageSize.width*scalingFactor),
                                    ceil(self.imageSize.height*scalingFactor));
    }
    printf("export image to size %f %f\n",self.imageSize.width, self.imageSize.height);
}
- (void)setPreviewSize {
    self.imageSize = CGSizeMake(600, 600);
}

- (void) prepareRendering {
    // bind to framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    
    [self.dataSource setTargetRatio:(double)self.imageSize.width/self.imageSize.height];
//    printf("export image to size %f %f\n",self.imageSize.width, self.imageSize.height);
    // allocate the export image data space
    NSInteger width = self.imageSize.width, height = self.imageSize.height;
    exportImageDataLength = width * height * 4;
    exportImageLineLength = width * 4;
    exportImageData = (GLubyte*)malloc(exportImageDataLength * sizeof(GLubyte));

    
    // bind texture
    [self bindTexture];
    
    grid.showGrid = self.dataSource.showGrid;
}

- (void) renderTile {
    GLenum err;
    
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);

    CGRect frameRect = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    CGRect imageRect = CGRectMake(0, 0, self.dataSource.originalSize.width / self.dataSource.textureSize.width,
                                  self.dataSource.originalSize.height / self.dataSource.textureSize.height);
    
    [grid createGridWithRows:self.dataSource.task.sRows columns:self.dataSource.task.sCols inRect:frameRect andUniformRect:imageRect];
    //[grid printInfo];
    
    static GLint backingWidth;
    static GLint backingHeight;
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
  
    // PROJEKTION EINSTELLUNGEN
    
    glViewport(0, 0, backingWidth, backingHeight);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    // cut out a tile using the projection
    double l = xChunk * CHUNK_SIZE;
    double b = yChunk * CHUNK_SIZE;
    double r = l + CHUNK_SIZE;
    double t = b + CHUNK_SIZE;

    glOrthof(l, r, b, t, 1, -20);
    
    // MODELL DARSTELLEN UND SCHIEBEN
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glClearColor(0, 0, 0.4, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
    
    err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error setup export rendering. glError: 0x%04X", err);
    
  
    glColor4f(1.0,1.0,1.0,1.0);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error binding texture image. glError: 0x%04X", err);
    
    glVertexPointer(3, GL_FLOAT, 0, grid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, grid.uniformTriangles);
    
    //Daniel: number of vertices not # of coordinates
    glDrawArrays(GL_TRIANGLES, 0, 3*grid.T); //paint all
    
    glDisableClientState(GL_VERTEX_ARRAY);
//    glDisableClientState(GL_TEXTURE_2D);
	glDisable(GL_TEXTURE_2D);

//    err = glGetError();
//    if (err != GL_NO_ERROR)
//        NSLog(@"Error rendering image. glError: 0x%04X", err);
}

- (void) renderAndExtractAllTiles {

    double w = self.imageSize.width;
    double h = self.imageSize.height;
    
    int xChunks = ceil(w/(float)CHUNK_SIZE);
    int yChunks = ceil(h/(float)CHUNK_SIZE);

    for(xChunk = 0; xChunk < xChunks ; xChunk++) {
        for(yChunk = 0; yChunk < yChunks; yChunk++) {
            [self renderTile];
            [self extractImageTile];
        }
    }
}
-(UIImage *)renderToImage {
    [self setFullResolutionSize];
    [self prepareRendering];
    [self renderAndExtractAllTiles];
    return [self extractImage];
}
-(UIImage *)renderToSquarePreview {
    double targetRatio = [self.dataSource targetRatio]; // save this ratio to restore it after rendering the square preview
    [self setPreviewSize];
    [self prepareRendering];
    [self renderAndExtractAllTiles];
    [self.dataSource setTargetRatio:targetRatio];
    return [self extractImage];
    
}

- (void)dealloc {
    [self unloadTextures];
}
@end
