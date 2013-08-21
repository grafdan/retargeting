//
//  RoundedRectView.m
//  Retargeting
//
//  Created by Daniel Graf on 21.01.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import "RoundedRectView.h"

@implementation RoundedRectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setCornerRadius:(float)radius {
    self.layer.cornerRadius = radius;
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
