//
//  MorphedImageView.m
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
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

#import "SaliencyImageView.h"


@interface SaliencyImageView () {
}
@end

@implementation SaliencyImageView
@synthesize dataSource = _dataSource;
@synthesize paintingDelegate = _paintingDelegate;
@synthesize needsSaliencyRebind = _needsSaliencyRebind;

-(void) createTextureIds{
    [EAGLContext setCurrentContext:self.context];
    // initialize texture
    //setup texture ids
    glGenTextures(1, &imageTexture);
    glGenTextures(1, &saliencyTexture);
//    printf("saliency texture ids: saliency %d and image %d\n",saliencyTexture, imageTexture);

}
-(void) bindImageTexture {
    [EAGLContext setCurrentContext:self.context];
    //prepare image texture
    glBindTexture(GL_TEXTURE_2D, imageTexture);
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
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.dataSource.textureSize.width, self.dataSource.textureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.dataSource.imageTexture);
//    NSLog(@"texture loaded with size %f by %f",self.dataSource.textureSize.width,self.dataSource.textureSize.height);
}
-(void) bindSaliencyTexture {
    [EAGLContext setCurrentContext:self.context];
    //prepare image texture
    glBindTexture(GL_TEXTURE_2D, saliencyTexture);
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
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.dataSource.saliencyTextureSize.width, self.dataSource.saliencyTextureSize.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, self.dataSource.saliencyImage);
//    NSLog(@"saliency texture loaded with size %f by %f",self.dataSource.saliencyTextureSize.width,self.dataSource.saliencyTextureSize.height);
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
    self.context = [[EAGLContext alloc] initWithAPI:[RetargetingContext sharedContext].context.API sharegroup:[RetargetingContext sharedContext].context.sharegroup];
//    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    //NSLog(@"Created ES context for test image view");
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    
    [self createTextureIds];
    [self bindImageTexture];
    [self bindSaliencyTexture];
    
    imageGrid = [[Grid alloc] init];
    saliencyGrid = [[Grid alloc] init];
    
    //setup gesture recognizers
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tap:)];
    UIGestureRecognizer *moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(pan:)];
    [self addGestureRecognizer:tapRecognizer];
    [self addGestureRecognizer:moveRecognizer];
    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    //NSLog(@"Saliency Image View awake from nib");
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    //NSLog(@"Saliency Image View init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void) reloadImage {
    //NSLog(@"reload Saliency Image Ground Picture");
    [self bindImageTexture];
    [self bindSaliencyTexture];
    [self setNeedsDisplay];
}


- (void)tap:(UITapGestureRecognizer *)gesture {
    if(!self.dataSource.showSaliency) [self.dataSource setShowSaliency:YES];
    //NSLog(@"Tap recognized at %lf %lf",[gesture locationInView:self].x, [gesture locationInView:self].y);
    CGPoint p = [gesture locationInView:self];
    p.x /= self.frame.size.width;
    p.y /= self.frame.size.height;
    [self.paintingDelegate paintAtPosition:[imageGrid uniformCoordinatesForGridPoint:p]];
}
- (void)pan:(UITapGestureRecognizer *)gesture {
    //NSLog(@"Pan recognized at %lf %lf",[gesture locationInView:self].x, [gesture locationInView:self].y);
    if(!self.dataSource.showSaliency) [self.dataSource setShowSaliency:YES];
    CGPoint p = [gesture locationInView:self];
    p.x /= self.frame.size.width;
    p.y /= self.frame.size.height;
    [self.paintingDelegate paintAtPosition:[imageGrid uniformCoordinatesForGridPoint:p]];
}

-(void)drawRect:(CGRect)rect{
    [EAGLContext setCurrentContext:self.context];
    if(self.needsSaliencyRebind) {
        self.needsSaliencyRebind = NO;
        [self bindSaliencyTexture];
    }
    
    Matrix *height = [[Matrix alloc] initWithSizeRows:2 andColumns:1];
    [height setEntryAtRow:0 andColumn:0 toValue:0.0];
    [height setEntryAtRow:1 andColumn:0 toValue:self.frame.size.height];
    Matrix *width = [[Matrix alloc] initWithSizeRows:2 andColumns:1];
    [width setEntryAtRow:0 andColumn:0 toValue:0.0];
    [width setEntryAtRow:1 andColumn:0 toValue:self.frame.size.width];
    
    CGRect frameRect = CGRectMake(0, 0, [width last], [height last]);
    CGRect imageRect = CGRectMake(0, 0, self.dataSource.originalSize.width / self.dataSource.textureSize.width,
                                  self.dataSource.originalSize.height / self.dataSource.textureSize.height);
    CGRect textureRect = CGRectMake(0, 0, self.dataSource.saliencyMapSize.width / self.dataSource.saliencyTextureSize.width,
                                    self.dataSource.saliencyMapSize.height / self.dataSource.saliencyTextureSize.height);
    
    [imageGrid createGridWithRows:height columns:width inRect:frameRect andUniformRect:imageRect];
    [saliencyGrid createGridWithRows:height columns:width inRect:frameRect andUniformRect:textureRect];

    //vertices for image and texture grids:
    
    // PROJEKTION EINSTELLUNGEN
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(0, self.frame.size.width, 0, self.frame.size.height, 1, -20);
    
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
    glVertexPointer(3, GL_FLOAT, 0, imageGrid.triangles);
    glTexCoordPointer(3, GL_FLOAT, 0, imageGrid.uniformTriangles);
    glDrawArrays(GL_TRIANGLES, 0, 3*imageGrid.T);

    if(self.dataSource.showSaliency) {
        //set saliencyTexture
        glColor4f(1.0,1.0,1.0,1.0);
        glBindTexture(GL_TEXTURE_2D, saliencyTexture);
        glVertexPointer(3, GL_FLOAT, 0, saliencyGrid.triangles);
        glTexCoordPointer(3, GL_FLOAT, 0, saliencyGrid.uniformTriangles);
        glDrawArrays(GL_TRIANGLES, 0, 3*saliencyGrid.T);
    }
    glDisableClientState(GL_VERTEX_ARRAY);
//    glDisableClientState(GL_TEXTURE_2D);
	glDisable(GL_TEXTURE_2D);
    
}

@end
