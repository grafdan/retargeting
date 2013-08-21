//
//  RetargetingView.m
//  Retargeting
//
//  Created by Daniel Graf on 14.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "RetargetingView.h"

@implementation RetargetingView
@synthesize retargetingViewController = _retargetingViewController;

- (void)setup {
    //NSLog(@"Setup of Retargeting View");
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LinenBackground" ofType:@"png"];
    UIImage * linenBackgroundImage = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithImage:linenBackgroundImage];
    [self addSubview:backgroundImageView];
//    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.9 alpha:1.0];
}
- (void)awakeFromNib
{
    //NSLog(@"Awake Retargeting View");
    [self setup]; // get initialized when we come out of a storyboard
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"retargeting view initWithFrame");
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
//    NSLog(@"Retargeting View layout subviews");
    if(self.retargetingViewController) {
        [self.retargetingViewController layoutRetargetingSubviews];
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
