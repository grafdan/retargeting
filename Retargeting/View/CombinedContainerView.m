//
//  CombinedContainerView.m
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

#import "CombinedContainerView.h"
#define GESTURE_DEBUG 0
typedef enum {
    kGestureLockNone,
    kGestureLockPaint, // paint on the image with 1 finger
    kGestureLockMove, // move the image around using 2 fingers
    kGestureLockResize, //change the target ratio using 3 fingers
    kGestureLockRotate, // not used
    kGestureLockPinch // zoom in and out
} GestureLockType;

@implementation CombinedContainerView {
    GestureLockType gestureLock;
    CGPoint pBeforeUniform, pBeforeGrid, pAfterGrid, pDelta;
    CGPoint startPaintTranslationVector;
}

@synthesize retargetingViewController = _retargetingViewController;
@synthesize combinedPictureFrameView = _combinedPictureFrameView;
@synthesize combinedSaliencyView = _combinedSaliencyView;
@synthesize dataSource = _dataSource;
@synthesize paintingDelegate = _paintingDelegate;
# pragma mark touch handling

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (void)setupGestureRecognizers {
    
    //setup gesture recognizers
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(singleTap:)];
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(doubleTap:)];
    doubleTapRecognizer.numberOfTouchesRequired = 2;
    
    UIGestureRecognizer *moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(move:)];
    UIGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(pinch:)];
    pinchRecognizer.delegate = self;
    UIGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self addGestureRecognizer:tapRecognizer];
    [self addGestureRecognizer:doubleTapRecognizer];
    [self addGestureRecognizer:moveRecognizer];
    [self addGestureRecognizer:pinchRecognizer];
    [self addGestureRecognizer:rotateRecognizer];
    gestureLock = kGestureLockNone;
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture {
    [self.dataSource setZoomFactor:1.0 animated:YES];
}
- (void)singleTap:(UITapGestureRecognizer *)gesture {
    if(GESTURE_DEBUG) NSLog(@"Tap");
    [self.retargetingViewController toggleSaliencyButton];
//    //NSLog(@"Tap recognized at %lf %lf",[gesture locationInView:self].x, [gesture locationInView:self].y);
//    CGPoint p = [gesture locationInView:self];
//    p.x /= self.frame.size.width;
//    p.y /= self.frame.size.height;
//    [self.paintingDelegate paintAtPosition:[saliencyView->grid uniformCoordinatesForGridPoint:p]];
//    if(!self.dataSource.showSaliency) [self.dataSource setShowSaliency:YES];
}

- (void)ensureValidZoomRange {
    if([self.dataSource zoomFactor] < 1.0)
        [self.dataSource setZoomFactor:1.0 animated:YES];
    if([self.dataSource zoomFactor] > 2.0) {
        [self.dataSource setZoomFactor:2.0 animated:YES];
    }
}
- (void)move:(UIPanGestureRecognizer *)gesture {
    if(GESTURE_DEBUG) NSLog(@"gesture lock %d",gestureLock);
    if(gesture.state == UIGestureRecognizerStateBegan) {
        if(gestureLock == kGestureLockNone) {
            if(gesture.numberOfTouches == 1) {
                gestureLock = kGestureLockPaint;
                startPaintTranslationVector = self.retargetingViewController.translationVector;
            }
            if(gesture.numberOfTouches == 2) gestureLock = kGestureLockMove;
            //if(gesture.numberOfTouches == 3) gestureLock = kGestureLockResize;
        }
    } else if(gesture.state == UIGestureRecognizerStateEnded) {
        if(gestureLock == kGestureLockPaint) {
            if(GESTURE_DEBUG) NSLog(@"paint ended");
            [self.dataSource setTranslationVector:startPaintTranslationVector animated:YES];

        }
        if(gestureLock == kGestureLockMove) {
            // nothing

        }
        if(gestureLock == kGestureLockResize) {
            // assert that it is within 1/10 to 10/1 of the original ratio
#define RESIZE_FACTOR 10
            if(self.retargetingViewController.targetRatio > RESIZE_FACTOR*self.retargetingViewController.sourceRatio) {
                [self.retargetingViewController setTargetRatio:RESIZE_FACTOR*self.retargetingViewController.sourceRatio];
            }
            if(self.retargetingViewController.targetRatio < 1.0/RESIZE_FACTOR*self.retargetingViewController.sourceRatio) {
                [self.retargetingViewController setTargetRatio:1.0/RESIZE_FACTOR*self.retargetingViewController.sourceRatio];
            }
        }
        //        [self.dataSource setTranslationVector:CGPointMake(0, 0)];
        gestureLock = kGestureLockNone;
        [self ensureValidZoomRange];
        return;
    } else {
        if(gesture.numberOfTouches == 1 && gestureLock == kGestureLockPaint) {
            [self paintImage:gesture];
            return;
        }
        if(gesture.numberOfTouches == 2 && gestureLock == kGestureLockMove) {
            if([self.dataSource zoomFactor] == 1.0) {
                [self resizeImage:gesture];
            } else {
                [self moveImage:gesture];
            }
            return;
        }
//        if(gesture.numberOfTouches == 3 && gestureLock == kGestureLockResize) {
//            [self resizeImage:gesture];
//            return;
//        }
    }
}

- (void)paintImage:(UIPanGestureRecognizer *) gesture {
    //NSLog(@"Pan recognized at %lf %lf",[gesture locationInView:self].x, [gesture locationInView:self].y);
    if(!self.dataSource.showSaliency) [self.dataSource setShowSaliency:YES];
    CGPoint p = [gesture locationInView:self.combinedSaliencyView];
    if(GESTURE_DEBUG) NSLog(@"p %f %f",p.x,p.y);
//    printf("combinedSaliencyView Size: %f %f and point %f %f\n",
//           self.combinedSaliencyView.frame.size.width,
//           self.combinedSaliencyView.frame.size.height,
//           p.x,p.y);
    p.x /= self.combinedSaliencyView.frame.size.width;
    p.y /= self.combinedSaliencyView.frame.size.height;
    pBeforeUniform = [self.combinedSaliencyView->imageGrid uniformCoordinatesForGridPoint:p];
    if(self.dataSource.motionCompensation) {
//        [self.combinedSaliencyView->imageGrid printInfo];
        pBeforeGrid = [self.combinedSaliencyView->imageGrid gridCoordinatesForUniformPoint:pBeforeUniform];
        [self.paintingDelegate paintAtPosition:pBeforeUniform];
        
        // choose the right rows and columns to update the saliency view grid
        Matrix *columns;
        Matrix *rows;
        
        if(self.dataSource.croppingFlag) {
            columns =  self.dataSource.task.cropPreviewCols;
            rows = self.dataSource.task.cropPreviewRows;
        } else {
            columns =  self.dataSource.task.sCols;
            rows = self.dataSource.task.sRows;
            
        }
        
        [self.combinedSaliencyView->imageGrid createGridWithRows:rows
                                                      andColumns:columns];
        
//        [self.combinedSaliencyView->imageGrid printInfo];
        pAfterGrid = [self.combinedSaliencyView->imageGrid gridCoordinatesForUniformPoint:pBeforeUniform];
//        printf("beforeGrid %f %f - afterGrid %f %f\n",pBeforeGrid.x,pBeforeGrid.y, pAfterGrid.x, pAfterGrid.y);
        // as the grid is on the uniform coordinate system with height 1.0, we
        // have to multiply with the preview frame-height to 
        pDelta = CGPointMake((pBeforeGrid.x-pAfterGrid.x)*self.combinedSaliencyView.frame.size.height,
                             (pBeforeGrid.y-pAfterGrid.y)*self.combinedSaliencyView.frame.size.height);
//        printf("the point under the finger changed by %f %f\n",pDelta.x,pDelta.y);
//        printf("saliency view frame height: %lf\n",self.combinedSaliencyView.frame.size.height);
        [self.dataSource setTranslationVector:CGPointMake(self.dataSource.translationVector.x + pDelta.x,
                                                          self.dataSource.translationVector.y + pDelta.y)];
    } else {
        [self.paintingDelegate paintAtPosition:[self.combinedSaliencyView->imageGrid uniformCoordinatesForGridPoint:p]];
    }
}

- (void)moveImage:(UIPanGestureRecognizer *)gesture {
    CGPoint p = [gesture translationInView:self];
    CGPoint oldShift = self.dataSource.translationVector;
    CGPoint newShift = CGPointMake(p.x+oldShift.x, p.y+oldShift.y);
    [self.dataSource setTranslationVector:newShift animated:YES];
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
}

- (void)rotate:(UIRotationGestureRecognizer *)gesture {
    CGFloat angle = gesture.rotation;
    if(angle>0) {
        [self.dataSource changeTargetRatio:pow(1.005, angle)];
    } else {
        [self.dataSource changeTargetRatio:pow(0.985, -angle)];
    }
    [gesture setRotation:0.0];
}
- (void)resizeImage:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self];
    if(translation.y>0) {
        [self.dataSource changeTargetRatio:pow(1.005, translation.y)];
    } else {
        [self.dataSource changeTargetRatio:pow(0.985, -translation.y)];
    }
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
}
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if(GESTURE_DEBUG) NSLog(@"pinch");
    if(GESTURE_DEBUG) NSLog(@"gesture lock %d",gestureLock);
    if(gesture.state == UIGestureRecognizerStateBegan) {
        if(gestureLock == kGestureLockNone) {
            if(gesture.numberOfTouches == 2) {
                if(gesture.scale < 1.2 && gesture.scale > 0.8) {
                    gestureLock = kGestureLockPinch;
                }
            }
        }
    } else if(gesture.state == UIGestureRecognizerStateEnded ||
              gesture.state == UIGestureRecognizerStateCancelled ||
              gesture.state == UIGestureRecognizerStateFailed) {
        if(gestureLock == kGestureLockPinch) {
            if(GESTURE_DEBUG) NSLog(@"pinch ended");
            [self ensureValidZoomRange];
        }
    } else {
        if(gesture.numberOfTouches == 2) {
            if(gestureLock == kGestureLockPinch) {
                double scale = gesture.scale;
                if(scale > 1.2 || scale < 0.8) {
                    if(GESTURE_DEBUG) printf("scale %lf\n",scale);
                }
                scale = MAX(scale, 0.8);
                scale = MIN(scale, 1.2);
                [self.dataSource setZoomFactor:self.dataSource.zoomFactor * scale];
                [gesture setScale:1.0];
            }
        }
    }
}


# pragma mark layout
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupGestureRecognizers];
    }
    return self;
}
- (void) layoutSubviews {
    double retarget_w = self.frame.size.width;
    double retarget_h = self.frame.size.height;
    if(retarget_w == 0 || retarget_h == 0) return;
//    NSLog(@"combined w %lf and combined h %lf",retarget_w,retarget_h);

    CGRect fullBox = CGRectMake(20, 20, retarget_w-40, retarget_h-40);
    
    double ratio;
    if(self.dataSource.showSaliency) {
        if(self.dataSource.croppingFlag) {
            ratio = self.dataSource.cropPreviewRatio;
        } else {
            ratio = self.retargetingViewController.retargetingState.targetRatio;            
        }
    } else {
        ratio = self.retargetingViewController.retargetingState.targetRatio;
    }
//    printf("ratio %f\n",ratio);
    CGRect combinedFrame = [LayoutHelper centeredRectInBoundingBox:fullBox withRatio:ratio];
    CGRect translatedFrame = CGRectMake(combinedFrame.origin.x + self.retargetingViewController.retargetingState.translationVector.x,
                                        combinedFrame.origin.y + self.retargetingViewController.retargetingState.translationVector.y,
                                        combinedFrame.size.width,
                                        combinedFrame.size.height);
    CGRect zoomedFrame = [LayoutHelper zoomedFrameAroundCenterWithRect:translatedFrame andZoomFactor:self.retargetingViewController.zoomFactor];
    self.combinedPictureFrameView.frame = CGRectMake(zoomedFrame.origin.x-10, zoomedFrame.origin.y-10,
                                                     zoomedFrame.size.width+20, zoomedFrame.size.height+20);
    [self.combinedPictureFrameView layoutSubviews];

    //keep model up to date
    self.retargetingViewController.retargetingState.sourceSize = self.retargetingViewController.combinedView.frame.size; // needed for brush size adoption
//    self.retargetingViewController.retargetingState.targetSize = self.retargetingViewController.combinedView.frame.size;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
