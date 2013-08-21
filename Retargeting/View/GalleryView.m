//
//  GalleryView.m
//  Retargeting
//
//  Created by Daniel Graf on 25.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import "GalleryView.h"

@implementation GalleryView {
    UIScrollView * scrollView;
    int columns;
    int padding;
    double pinchCumulator;
    NSMutableDictionary * thumbnails;
}

@synthesize projectController = _projectController;
@synthesize libraryViewController = _libraryViewController;

- (void)loadProjects {
    
    // remove those thumbnails whose projects have been deleted meanwhile:
    for(UIView *subview in scrollView.subviews) {
        if([subview class] == [ThumbnailView class]) {
            ThumbnailView * thumbnail = (ThumbnailView *)subview;
            if(![self.projectController.projects containsObject:thumbnail.project.projectID]) {
                NSLog(@"remove project %@ from gallery",thumbnail.project.projectID);
                [thumbnail removeFromSuperview];
                [thumbnails removeObjectForKey:thumbnail.project.projectID];
            }
        }
    }
    for(NSString * projectID in self.projectController.projects) {
        if([thumbnails objectForKey:projectID] == nil) {
            CGRect thumbRect = CGRectMake(10,10,100,100);
            ThumbnailView * thumb = [[ThumbnailView alloc] initWithFrame:thumbRect];
            thumb.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                    UIViewAutoresizingFlexibleHeight);
            thumb.libraryViewController = self.libraryViewController;
            [thumb setProjectID:projectID];
            [thumbnails setObject:thumb forKey:projectID];
            [scrollView addSubview:thumb];
        }
    }
    
}

- (void)reloadProject:(NSString *)projectID {
    ThumbnailView * thumb = [thumbnails objectForKey:projectID];
    if(thumb == nil) return;
    [thumb reloadImage];
}


- (void) layoutSubviews {
    if(self.frame.size.width > self.frame.size.height && columns == 1) columns = 2; // no single view in landscape mode as it would get cropped anyway
    
    // use the CoreAnimation Code below to animate these
//    [UIView animateWithDuration:0.2
//                          delay:0.1
//                        options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionLayoutSubviews
//                     animations:^{
                         int row = -1;
                         int column = columns-1;
                         scrollView.frame = self.bounds;
                         int thumbSize = (self.frame.size.width-(columns+1)*padding)/columns;
                         NSArray * sortedKeys = [[thumbnails allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
                             if([obj1 intValue] < [obj2 intValue]) {
                                 return NSOrderedAscending;
                             }
                             if([obj1 intValue] == [obj2 intValue]) {
                                 return NSOrderedSame;
                             }
                             return NSOrderedDescending;
                         }];
                         for (NSString * projectID in sortedKeys) {
                             column++;
                             if(column>=columns) {
                                 row++;
                                 column %= columns;
                             }
                             
                             ThumbnailView * thumb = [thumbnails objectForKey:projectID];
                             [thumb setPaddingFactor:columns];
                             thumb.frame=CGRectMake(padding+(thumbSize+padding)*column,
                                                    padding+(thumbSize+padding)*row,
                                                    thumbSize, thumbSize);
                         }
                         scrollView.contentSize = CGSizeMake(self.frame.size.width,
                                                             padding + (thumbSize+padding)*(row+1));
//                     }
//                     completion:^(BOOL finished){
//                         //                             [self performSelector:@selector(setShowSaliency:) withObject:NO afterDelay:1.0];
//                     }];
}
- (id)initWithFrame:(CGRect)frame andLibraryViewController:(LibraryViewController *)libraryViewController {
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.libraryViewController = libraryViewController;
        self.projectController = [ProjectController sharedProjectController];
        thumbnails = [NSMutableDictionary dictionary];
        
        scrollView =  [[UIScrollView alloc] init];
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 1.0;
        scrollView.contentSize = CGSizeMake(self.bounds.size.width,
                                            1000.0);
        scrollView.frame = self.bounds;
        [self addSubview:scrollView];
        columns = 2;
        padding = 5;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) padding = 10.0;
        [self loadProjects];
        
        UIPinchGestureRecognizer * pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchGestureRecognizer];
        pinchCumulator = 1.0;
        columns = 3;

    }
    return self;
}

- (void) pinch:(id)sender {
    UIPinchGestureRecognizer * gesture = (UIPinchGestureRecognizer *)sender;
    double factor = 1.3;
    if (gesture.scale/pinchCumulator > factor) {
        columns = MAX(1,columns-1);
        [self layoutSubviews];
        pinchCumulator *= factor;
    }
    if( gesture.scale/pinchCumulator < 1.0/factor) {
        columns = MIN(6,columns+1);
        [self layoutSubviews];
        pinchCumulator /= factor;
    }
    if( gesture.state == UIGestureRecognizerStateEnded) {
        pinchCumulator = 1;
    }
}

- (void)scrollToEnd {
    if(scrollView.contentSize.height > scrollView.bounds.size.height) {
        CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height -
                                           scrollView.bounds.size.height);
        [scrollView setContentOffset:bottomOffset animated:YES];
    }
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
