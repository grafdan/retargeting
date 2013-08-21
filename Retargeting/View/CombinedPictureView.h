//
//  CombinedPictureView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "CombinedView.h"

@class CombinedView;

@interface CombinedPictureView : GLKView {
    GLuint imageTexture;
    Grid *grid;
    
}
@property (nonatomic, weak) CombinedView *combinedView;
- (id)initWithFrame:(CGRect)frame andCombinedView:(CombinedView *)aCombinedView;
-(void)reloadImage;
- (void)unloadTextures;

@end
