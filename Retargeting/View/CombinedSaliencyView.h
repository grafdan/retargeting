//
//  CombinedSaliencyView.h
//  Retargeting
//
//  Created by Daniel Graf on 21.11.12.
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
