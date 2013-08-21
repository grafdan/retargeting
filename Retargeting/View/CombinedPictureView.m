//
//  CombinedPictureView.m
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "CombinedPictureView.h"

@implementation CombinedPictureView {
    int N, M;
}
@synthesize combinedView = _combinedView;

-(void) createTextureIds{
    [EAGLContext setCurrentContext:self.context];
    // initialize texture
    //setup texture ids
    glGenTextures(1, &imageTexture);
}
-(void) bindImageTexture {
    [EAGLContext setCurrentContext:self.context];
    //prepare image texture
    //enable texturing
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
    
//    NSLog(@"Set Texture with size %f %f",self.combinedView.dataSource.textureSize.width,self.combinedView.dataSource.textureSize.height);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.combinedView.dataSource.textureSize.width, self.combinedView.dataSource.textureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.combinedView.dataSource.imageTexture);
    
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error uploading texture. glError: 0x%04X", err);
    
}

- (void)unloadTextures {
    [EAGLContext setCurrentContext:self.context];
    glDeleteTextures(1, &imageTexture);
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
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    [self createTextureIds];
    [self bindImageTexture];
    
    //initialize the grid -> TODO extract from Model-information
    N = 25;
    M = 25;
    
    grid = [[Grid alloc] init];
    
    [self setNeedsDisplay];
}


-(void) reloadImage {
    //NSLog(@"reload Saliency Image Ground Picture");
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

    self.combinedView.imageSize = self.combinedView.dataSource.targetImageSize;
    
    Matrix *width = [[Matrix alloc] initWithSizeRows:1 andColumns:1];
    [width setEntryAtRow:0 andColumn:0 toValue:self.combinedView.imageSize.width];
    Matrix *height = [[Matrix alloc] initWithSizeRows:1 andColumns:1];
    [height setEntryAtRow:0 andColumn:0 toValue:self.combinedView.imageSize.height];
    
    grid.showGrid = self.combinedView.dataSource.showGrid;
    CGRect frameRect;
    frameRect = CGRectMake(0, 0, self.combinedView.dataSource.targetImageSize.width, self.combinedView.dataSource.targetImageSize.height);
    CGRect imageRect = CGRectMake(0, 0, self.combinedView.dataSource.originalSize.width / self.combinedView.dataSource.textureSize.width,
                                  self.combinedView.dataSource.originalSize.height / self.combinedView.dataSource.textureSize.height);
    [grid createGridWithRows:self.combinedView.dataSource.task.sRows columns:self.combinedView.dataSource.task.sCols inRect:frameRect andUniformRect:imageRect];
    
    
//    [grid createGridWithRows:self.combinedView.dataSource.task.sRows andColumns:self.combinedView.dataSource.task.sCols];
    
    static GLint backingWidth;
    static GLint backingHeight;
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    
    // PROJEKTION EINSTELLUNGEN
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(0, self.combinedView.imageSize.width,
             0, self.combinedView.imageSize.height, 1, -20);
    
    // MODELL DARSTELLEN UND SCHIEBEN
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glClearColor(0, 0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
    
    //blending
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //set imageTexture
    glColor4f(1.0,1.0,1.0,1.0);
    glBindTexture(GL_TEXTURE_2D, imageTexture);
    glVertexPointer(3, GL_FLOAT, 0, grid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, grid.uniformTriangles);
    glDrawArrays(GL_TRIANGLES, 0, 3*grid.T);
    
    glDisableClientState(GL_VERTEX_ARRAY);
//    glDisableClientState(GL_TEXTURE_2D);
	glDisable(GL_TEXTURE_2D);
    
}

@end
