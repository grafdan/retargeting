//
//  CombinedSaliencyView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "CombinedView.h"
#import <QuartzCore/QuartzCore.h>
@class CombinedView;

@interface CombinedSaliencyView : GLKView {
    GLuint saliencyTexture;
    GLuint imageTexture;

    @public
    Grid *imageGrid, *croppedImageGrid, *saliencyGrid;
}
@property (nonatomic, weak) CombinedView *combinedView;

- (id)initWithFrame:(CGRect)frame andCombinedView:(CombinedView *)aCombinedView;
-(void)reloadImage;
-(void)bindSaliencyTexture;
- (void)unloadTextures;
@end
