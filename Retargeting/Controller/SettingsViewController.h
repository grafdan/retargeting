//
//  SettingsViewController.h
//  Retargeting
//
//  Created by Daniel Graf on 06.11.12.
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

#import <UIKit/UIKit.h>
#import "RetargetingState.h"

@protocol SettingsViewDataSourceAndDelegate
- (double)laplacianRegularizationWeight;
- (void)setLaplacianRegularizationWeight:(double)aLaplacianRegularizationWeight;
- (double)LFactor;
- (void)setLFactor:(double)aLFactor;
- (bool)paintMode;
- (void)setPaintMode:(bool)aPaintMode;
- (double)brushSize;
- (void)setBrushSize:(double)aBrushSize;
- (int)upsamplingFactor;
- (void)setUpsamplingFactor:(int)aFactor;
- (LayoutType)layoutMode;
- (void)setLayoutMode:(LayoutType)aMode;
- (bool)showSaliency;
- (void)setShowSaliency:(bool)aShowSaliency;
- (bool)showGrid;
- (void)setShowGrid:(bool)aShowGrid;
- (bool)motionCompensation;
- (void)setMotionCompensation:(bool)aMode;
- (bool)croppingFlag;
- (void)setCroppingFlag:(bool)aCroppingFlag;
- (double)croppingAlpha;
- (void)setCroppingAlpha:(double)aCroppingAlpha;
- (double)croppingBeta;
- (void)setCroppingBeta:(double)aCroppingBeta;
- (double)croppingGamma;
- (void)setCroppingGamma:(double)aCroppingGamma;
- (void)setDefaultParameterSettingsWithCropping:(bool)croppingFlag;
- (void)resetDefaultParameterSettings;
- (void)didFinishEditingSetting:(id)sender;
@end

@interface SettingsViewController : UITableViewController
@property (nonatomic, weak) IBOutlet id <SettingsViewDataSourceAndDelegate> dataSourceAndDelegate;
- (id)initWithStyle:(UITableViewStyle)style andDataSourceDelegate:(id)aDataSourceDelegate;
@end
