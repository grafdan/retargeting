//
//  MorphedImageView.m
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "WarpImageView.h"


@interface WarpImageView () {
    int N, M;
    double s[MAXNM*2];
    GLuint texture;
}
@end

@implementation WarpImageView
@synthesize dataSource = _dataSource;
@synthesize imageSize = _imageSize;

- (void)setup {
    // Force to use OpenGL ES 1 rather than ES 2
    // (see <OpenGLES/EAGL.h> for API enum information)
    self.context = [[EAGLContext alloc] initWithAPI:[RetargetingContext sharedContext].context.API sharegroup:[RetargetingContext sharedContext].context.sharegroup];
    //NSLog(@"Created ES context for morphed image view");
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
   
    [EAGLContext setCurrentContext:self.context];    
    glGenTextures(1, &texture);
//    printf("warp texture ids: warp %d\n",texture);
    
    //initialize the grid -> TODO extract from Model-information
    N = 25;
    M = 25;
    
    grid = [[Grid alloc] init];
    
    //setup gesture recognizers
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panRecognizer.minimumNumberOfTouches = 2;
    [self addGestureRecognizer:panRecognizer];

    [self setNeedsDisplay];
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self];
//    if(abs(translation.y)>1) {
        if(translation.y>0) {
            [self.dataSource changeTargetRatio:pow(1.005, translation.y)];
        } else {
            [self.dataSource changeTargetRatio:pow(0.985, -translation.y)];
        }
        [gesture setTranslation:CGPointMake(0, 0) inView:self];
//    }
}
- (void)reloadImage {
    [EAGLContext setCurrentContext:self.context];

    glGenTextures(1, &texture);
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

//    NSLog(@"Set Texture with size %f %f",self.dataSource.textureSize.width,self.dataSource.textureSize.height);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.dataSource.textureSize.width, self.dataSource.textureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.dataSource.imageTexture);

    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error uploading texture. 	: 0x%04X", err);
    
    [self setNeedsDisplay];
}

- (void)unloadTextures {
    [EAGLContext setCurrentContext:self.context];
    glDeleteTextures(1, &texture);
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"Error when deleting texture. 	: 0x%04X", err);
    glFlush();
}

- (void)awakeFromNib
{
    //NSLog(@"Warp View awake from nib");
    [self setup];
}



- (id)initWithFrame:(CGRect)frame
{
    //NSLog(@"Warp View init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


//- (void)update
//{
////    static int updateCount;
////    updateCount++;
////    if(updateCount%100==0) NSLog(@"Update count %d",updateCount);
//    [self loadGridFromDataSource];
//}

- (void)drawRect:(CGRect)rect
{
    
    //NSLog(@"Warp Image View Draw Rect");

//    [self update];
    [EAGLContext setCurrentContext:self.context];
    self.imageSize = self.dataSource.targetImageSize;
    
    grid.showGrid = self.dataSource.showGrid;

    CGRect frameRect = CGRectMake(0, 0, self.dataSource.targetImageSize.width, self.dataSource.targetImageSize.height);
    CGRect imageRect = CGRectMake(0, 0, self.dataSource.originalSize.width / self.dataSource.textureSize.width,
                                  self.dataSource.originalSize.height / self.dataSource.textureSize.height);
    
    [grid createGridWithRows:self.dataSource.task.sRows columns:self.dataSource.task.sCols inRect:frameRect andUniformRect:imageRect];
//    [grid printInfo];

    static GLint backingWidth;
    static GLint backingHeight;
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);

    glBindTexture(GL_TEXTURE_2D, texture);
    
    
    // PROJEKTION EINSTELLUNGEN
    
    //    glViewport(0, 0, backingwidth, backingheight);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(0, self.imageSize.width, 0, self.imageSize.height, 1, -20);
    
    // MODELL DARSTELLEN UND SCHIEBEN
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glClearColor(0, 0, 0.4, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
    
    glColor4f(1.0,1.0,1.0,1.0);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glVertexPointer(3, GL_FLOAT, 0, grid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, grid.uniformTriangles);
    
    //Daniel: number of vertices not # of coordinates
    glDrawArrays(GL_TRIANGLES, 0, 3*grid.T); //paint all
    
    glDisableClientState(GL_VERTEX_ARRAY);
//    glDisableClientState(GL_TEXTURE_2D);
	glDisable(GL_TEXTURE_2D);
}

@end
