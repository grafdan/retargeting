//
//  RatioPicker.h
//  Retargeting
//
//  Created by Daniel Graf on 17.02.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RatioPickerDataSourceAndDelegate
- (void)didFinishChoosingRatio:(id)sender;
- (double)sourceRatio;
- (void)setTargetRatio:(double)factor;
@end


@interface RatioPicker : UITableViewController
@property (nonatomic, weak) IBOutlet id <RatioPickerDataSourceAndDelegate> dataSourceAndDelegate;
- (id)initWithStyle:(UITableViewStyle)style andDataSourceDelegate:(id)aDataSourceDelegate;
@end
