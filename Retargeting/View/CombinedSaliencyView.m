//
//  CombinedSaliencyView.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "CombinedSaliencyView.h"

@implementation CombinedSaliencyView {
    int N, M;
}
@synthesize combinedView = _combinedView;

-(void) createTextureIds{
    [EAGLContext setCurrentContext:self.context];
    // initialize texture
    //setup texture ids
    glGenTextures(1, &imageTexture);
    glGenTextures(1, &saliencyTexture);
}
-(void) bindSaliencyTexture {
    [EAGLContext setCurrentContext:self.context];
    //prepare image texture
    glBindTexture(GL_TEXTURE_2D, saliencyTexture);
    if(self.combinedView.dataSource.useMipMaps) {
        glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, GL_TRUE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    } else {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    }
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 1.0f);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.combinedView.dataSource.saliencyTextureSize.width, self.combinedView.dataSource.saliencyTextureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.combinedView.dataSource.saliencyImage);
//    NSLog(@"saliency texture loaded with size %f by %f",self.combinedView.dataSource.saliencyTextureSize.width,self.combinedView.dataSource.saliencyTextureSize.height);
}


-(void) bindImageTexture {
    [EAGLContext setCurrentContext:self.context];
    //prepare image texture
    glBindTexture(GL_TEXTURE_2D, imageTexture);
    if(self.combinedView.dataSource.useMipMaps) {
        glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, GL_TRUE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    } else {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    }
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 1.0f);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.combinedView.dataSource.textureSize.width, self.combinedView.dataSource.textureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.combinedView.dataSource.imageTexture);
//    NSLog(@"texture loaded with size %f by %f",self.combinedView.dataSource.textureSize.width,self.combinedView.dataSource.textureSize.height);
}

- (void)unloadTextures {
    [EAGLContext setCurrentContext:self.context];
    glDeleteTextures(1, &imageTexture);
    glDeleteTextures(1, &saliencyTexture);
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error when deleting texture. 	: 0x%04X", err);
    glFlush();
}


- (void)setup {
    // Force to use OpenGL ES 1 rather than ES 2
    // (see <OpenGLES/EAGL.h> for API enum information)
    self.context = [[EAGLContext alloc] initWithAPI:[RetargetingContext sharedContext].context.API
                                         sharegroup:[RetargetingContext sharedContext].context.sharegroup];
    //NSLog(@"Created ES context for morphed image view");

    // flag for blend through (alpha masking of open gl layer)
    // probably a bottleneck on certain device generations

//    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
//    eaglLayer.opaque = NO;
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    [self createTextureIds];
    [self bindSaliencyTexture];
    [self bindImageTexture];
    
    //initialize the grid -> TODO extract from Model-information
    N = 25;
    M = 25;
    
    imageGrid = [[Grid alloc] init];
    croppedImageGrid = [[Grid alloc] init];
    saliencyGrid = [[Grid alloc] init];
    
}



-(void) reloadImage {
    //NSLog(@"reload Saliency Image Ground Picture");
    [self bindSaliencyTexture];
    [self bindImageTexture];
    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    //NSLog(@"Saliency Image View awake from nib");
    [self setup];
}

- (id)initWithFrame:(CGRect)frame andCombinedView:(CombinedView *)aCombinedView
{
    //NSLog(@"Saliency Image View init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.combinedView = aCombinedView;
        [self setup];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    [EAGLContext setCurrentContext:self.context];
    if(self.combinedView.needsSaliencyRebind) {
        self.combinedView.needsSaliencyRebind = NO;
        [self bindSaliencyTexture];
    }
    
    self.combinedView.imageSize = self.combinedView.dataSource.targetImageSize;
    
    
    imageGrid.showGrid = self.combinedView.dataSource.showGrid;
    saliencyGrid.showGrid = self.combinedView.dataSource.showGrid;
    croppedImageGrid.showGrid = self.combinedView.dataSource.showGrid;

    CGRect frameRect;
    CGRect innerFrameRect;
    Matrix *columns;
    Matrix *rows;
//    if(self.combinedView.dataSource.showSaliency && self.combinedView.dataSource.croppingFlag) {
    if(self.combinedView.dataSource.croppingFlag) {
        frameRect = CGRectMake(0, 0, self.combinedView.dataSource.cropPreviewSize.width,
                               self.combinedView.dataSource.cropPreviewSize.height);
        innerFrameRect = self.combinedView.dataSource.cropPreviewInnerRect;
        columns =  self.combinedView.dataSource.task.cropPreviewCols;
        rows = self.combinedView.dataSource.task.cropPreviewRows;
    } else {
        frameRect = CGRectMake(0, 0, self.combinedView.dataSource.targetImageSize.width, self.combinedView.dataSource.targetImageSize.height);
        innerFrameRect = frameRect;
        columns =  self.combinedView.dataSource.task.sCols;
        rows = self.combinedView.dataSource.task.sRows;
    }

    CGRect imageTextureRect = CGRectMake(0, 0, self.combinedView.dataSource.originalSize.width / self.combinedView.dataSource.textureSize.width,
                                         self.combinedView.dataSource.originalSize.height / self.combinedView.dataSource.textureSize.height);
    CGRect saliencyTextureRect = CGRectMake(0, 0, self.combinedView.dataSource.saliencyMapSize.width / self.combinedView.dataSource.saliencyTextureSize.width,
                                            self.combinedView.dataSource.saliencyMapSize.height / self.combinedView.dataSource.saliencyTextureSize.height);
    
    [imageGrid createGridWithRows:rows columns:columns inRect:frameRect andUniformRect:imageTextureRect];
    [croppedImageGrid createGridWithRows:self.combinedView.dataSource.task.sRows
                                 columns:self.combinedView.dataSource.task.sCols
                                  inRect:innerFrameRect
                          andUniformRect:imageTextureRect];
//    [croppedImageGrid printInfo];
//    printf("innerFrame x %f - y %f\n",innerFrameRect.origin.x, innerFrameRect.origin.y);
    [saliencyGrid createGridWithRows:rows columns:columns inRect:frameRect andUniformRect:saliencyTextureRect];
    
//    [imageGrid printInfo];
//    [saliencyGrid printInfo];
    
    static GLint backingWidth;
    static GLint backingHeight;
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    
    //NSLog(@"SaliencyImageView drawRect");
    //vertices for image and texture grids:
    
    // PROJEKTION EINSTELLUNGEN
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

//    if(self.combinedView.dataSource.showSaliency && self.combinedView.dataSource.croppingFlag) {
    if(self.combinedView.dataSource.croppingFlag) {
        glOrthof(0, self.combinedView.dataSource.cropPreviewSize.width,
                 0, self.combinedView.dataSource.cropPreviewSize.height, 1, -20);
    } else {
        glOrthof(0, self.combinedView.imageSize.width,
                 0, self.combinedView.imageSize.height, 1, -20);
    }
    
    // MODELL DARSTELLEN UND SCHIEBEN
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
    
    //blending
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    //set whole imageTexture (including cropped part -> semi-transparent)
    glColor4f(1.0,1.0,1.0,0.7);
    glBindTexture(GL_TEXTURE_2D, imageTexture);
    glVertexPointer(3, GL_FLOAT, 0, imageGrid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, imageGrid.uniformTriangles);
    glDrawArrays(GL_TRIANGLES, 0, 3*imageGrid.T);
 
    //only cropped part of the imageTexture (only remainng part -> non-transparent)
    glColor4f(1.0,1.0,1.0,1.0);
    glBindTexture(GL_TEXTURE_2D, imageTexture);
    glVertexPointer(3, GL_FLOAT, 0, croppedImageGrid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, croppedImageGrid.uniformTriangles);
    glDrawArrays(GL_TRIANGLES, 0, 3*croppedImageGrid.T);
    
    
    //set saliencyTexture
    glColor4f(1.0,1.0,1.0,1.0);
    glBindTexture(GL_TEXTURE_2D, saliencyTexture);
    glVertexPointer(3, GL_FLOAT, 0, saliencyGrid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, saliencyGrid.uniformTriangles);
    glDrawArrays(GL_TRIANGLES, 0, 3*saliencyGrid.T);
    
    glDisableClientState(GL_VERTEX_ARRAY);
//    glDisableClientState(GL_TEXTURE_2D);
	glDisable(GL_TEXTURE_2D);
    
}

@end
