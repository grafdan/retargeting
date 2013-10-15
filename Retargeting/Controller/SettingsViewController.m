//
//  SettingsViewController.m
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

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

# pragma mark general UIView

@implementation SettingsViewController {
    int controlXOffset, controlYOffset;
    double controlWidth;
    UISlider * lFactorSlider;
    UISwitch * cropSwitch;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        controlXOffset = 155;
        controlYOffset = 11;
        controlWidth = 180;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andDataSourceDelegate:(id)aDataSourceDelegate
{
    self = [self initWithStyle:style];
    self.dataSourceAndDelegate = aDataSourceDelegate;
    return self;
}
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [self.tableView reloadData];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = @"Settings";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.dataSourceAndDelegate action:@selector(didFinishEditingSetting:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (BOOL) getAdvancedSettings {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"AdvancedRetargetingSettings"];
}
- (void) setAdvancedSettings:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:@"AdvancedRetargetingSettings"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if([self getAdvancedSettings]) {
        return 5;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self getAdvancedSettings]) {
        // Return the number of rows in the section.
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 3;
                break;
            case 2:
                return 4;
                break;
            case 3:
                return 3;
                break;
            case 4:
                return 3;
                break;
            default:
                return 0;
                break;
        }
    } else {
        return 3;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([self getAdvancedSettings]) {
        if(section==0) return @"Settings";
        if(section==1) return @"Retargeting Method";
        if(section==2) return @"Cropping";
        if(section==3) return @"Saliency Painting";
        if(section==4) return @"Layout";
    } else {
        if(section==0) return @"Settings";
    }
    return @"";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if([self getAdvancedSettings]) {
        if(section==0) return @"";
        if(section==1) return @"parameters of the retargeting algorithm";
        if(section==2) return @"options for automatic cropping";
        if(section==3) return @"options for manual saliency drawing";
        if(section==4) return @"control the usage of the screen space";
    } else {
        if(section==0) return @"";
    }
    return @"";
}

#pragma mark change handlers

-(IBAction)regularizationSliderChanged:(UISlider *)sender {
    // manipulate regularization
    double value = sqrt(sender.value);
    [self.dataSourceAndDelegate setLaplacianRegularizationWeight:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) cell = (UITableViewCell *)sender.superview.superview;
    else cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lapl. weight = %.2lf",self.dataSourceAndDelegate.laplacianRegularizationWeight];
}
-(IBAction)LFactorSliderChanged:(UISlider *)sender {
    // manipulate LFactor
    double value = sender.value;
    [self.dataSourceAndDelegate setLFactor:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) cell = (UITableViewCell *)sender.superview.superview;
    else cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"LW = %.2lf W'/N",self.dataSourceAndDelegate.LFactor];
}
-(IBAction)paintModeSwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self.dataSourceAndDelegate setPaintMode:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.paintMode) {
        cell.detailTextLabel.text = @"paint saliency";
    } else {
        cell.detailTextLabel.text = @"erase saliency";
    }
}
-(IBAction)brushSizeSliderChanged:(UISlider *)sender {
    // manipulate brushSize
    double value = round(exp2f(sender.value));
    [self.dataSourceAndDelegate setBrushSize:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0lf px",self.dataSourceAndDelegate.brushSize];
}
-(IBAction)upsamplingFactorChanged:(UISlider *)sender {
    // manipulate upsamplingFactor
    int value = round(sender.value);
    [self.dataSourceAndDelegate setUpsamplingFactor:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Spline sampling: %dx",self.dataSourceAndDelegate.upsamplingFactor];
}
-(IBAction)showSaliencySwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self.dataSourceAndDelegate setShowSaliency:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.showSaliency) {
        cell.detailTextLabel.text = @"show importance map";
    } else {
        cell.detailTextLabel.text = @"hide importance map";
    }
}
-(IBAction)showGridSwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self.dataSourceAndDelegate setShowGrid:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.showGrid) {
        cell.detailTextLabel.text = @"show full image";
    } else {
        cell.detailTextLabel.text = @"show single color per cell";
    }
}
-(IBAction)layoutSwitchChanged:(UISwitch *)sender {
    LayoutType value = sender.on?kLayoutModeCombined:kLayoutModeConcatenateBoth;
    [self.dataSourceAndDelegate setLayoutMode:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.layoutMode == kLayoutModeCombined) {
        cell.detailTextLabel.text = @"combined";
    }
    if(self.dataSourceAndDelegate.layoutMode == kLayoutModeConcatenateBoth) {
        cell.detailTextLabel.text = @"left / right for saliency / warp";
    }

}
-(IBAction)motionCompensationSwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self.dataSourceAndDelegate setMotionCompensation:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.motionCompensation) {
        cell.detailTextLabel.text = @"compensate movement";
    } else {
        cell.detailTextLabel.text = @"keep picture in place";
    }
}
-(IBAction)cropSwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self.dataSourceAndDelegate setCroppingFlag:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(self.dataSourceAndDelegate.croppingFlag) {
        cell.detailTextLabel.text = @"cropping enabled";
    }
    else {
        cell.detailTextLabel.text = @"cropping disabled";
    }
    [self.dataSourceAndDelegate setDefaultParameterSettingsWithCropping:value];
    lFactorSlider.value = self.dataSourceAndDelegate.LFactor;
    [self LFactorSliderChanged:lFactorSlider];
}
-(IBAction)croppingAlphaChanged:(UISlider *)sender {
    // manipulate treshold factor
    double value = sender.value;
    [self.dataSourceAndDelegate setCroppingAlpha:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"LW' / LW: %.2lf",self.dataSourceAndDelegate.croppingAlpha];
}
-(IBAction)croppingBetaChanged:(UISlider *)sender {
    // manipulate ramp factor
    double value = sender.value;
    [self.dataSourceAndDelegate setCroppingBeta:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"lower ramp: %.2lf",self.dataSourceAndDelegate.croppingBeta];
}
-(IBAction)croppingGammaChanged:(UISlider *)sender {
    // manipulate ramp factor
    double value = sender.value;
    [self.dataSourceAndDelegate setCroppingGamma:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"upper ramp: %.2lf",self.dataSourceAndDelegate.croppingGamma];
}

-(IBAction)advancedSettingsSwitchLoad:(UISwitch *)sender {
    bool value = sender.on;
    [self setAdvancedSettings:value];
    UITableViewCell *cell;
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
        cell = (UITableViewCell *)sender.superview.superview;
    else
        cell = (UITableViewCell *)sender.superview;
    if(value) {
        cell.detailTextLabel.text = @"disable for default parameters";
    }
    else {
        cell.detailTextLabel.text = @"for experimental use only";
    }
}

#pragma mark advanced settings handler
-(IBAction)advancedSettingsSwitchChanged:(UISwitch *)sender {
    bool value = sender.on;
    [self setAdvancedSettings:value];
    bool croppingFlag = self.dataSourceAndDelegate.croppingFlag;
    [self.dataSourceAndDelegate resetDefaultParameterSettings];
    [self.dataSourceAndDelegate setDefaultParameterSettingsWithCropping:croppingFlag];
    [self.tableView reloadData];
    [self cropSwitchChanged:cropSwitch];
}

#pragma mark create UI elements

- (UISwitch *) switchForSettingCellWithInitialValue:(bool)value forCell:(UITableViewCell *)cell {
    UISwitch * settingSwitch = [[UISwitch alloc] init];
    [settingSwitch setOn:value];
    settingSwitch.frame = CGRectMake(cell.frame.size.width-settingSwitch.frame.size.width-20,
                                   controlYOffset,
                                   settingSwitch.frame.size.width,
                                   settingSwitch.frame.size.height);
    settingSwitch.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    return settingSwitch;
}
- (UISlider *) sliderForSettingCellWithMin:(float)aMin max:(float)aMax initialValue:(float)aValue forCell:(UITableViewCell *)cell {
    UISlider * slider = [[UISlider alloc] init];
    slider.minimumValue = aMin;
    slider.maximumValue = aMax;
    slider.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    slider.value = aValue;
    controlWidth = cell.frame.size.width - controlXOffset - 20;
    slider.frame = CGRectMake(controlXOffset, controlYOffset,
                              controlWidth,
                              slider.frame.size.height);
    return slider;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if([self getAdvancedSettings]) {
        if(indexPath.section == 0) {
            if(indexPath.row == 0) {
                cell.textLabel.text = @"Advanced Settings";
                UISwitch * advancedSettingsSwitch = [self switchForSettingCellWithInitialValue:[self getAdvancedSettings]
                                                                                       forCell:cell];
                [advancedSettingsSwitch addTarget:self action:@selector(advancedSettingsSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [self advancedSettingsSwitchLoad:advancedSettingsSwitch];
                [cell addSubview:advancedSettingsSwitch];
                [self advancedSettingsSwitchLoad:advancedSettingsSwitch];
            }
        }
        
        if(indexPath.section == 1) {
            if(indexPath.row == 0) {
                cell.textLabel.text = @"Regularization";
                UISlider * slider = [self sliderForSettingCellWithMin:0
                                                                  max:1.0
                                                         initialValue:sqrt(self.dataSourceAndDelegate.laplacianRegularizationWeight)
                                                              forCell:cell];
                [slider addTarget:self action:@selector(regularizationSliderChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self regularizationSliderChanged:slider];
                
            }
            if(indexPath.row == 1) {
                cell.textLabel.text = @"Min. Cell Size";
                UISlider * slider = [self sliderForSettingCellWithMin:0.0
                                                                  max:1.0
                                                         initialValue:self.dataSourceAndDelegate.LFactor
                                                              forCell:cell];
                [slider addTarget:self action:@selector(LFactorSliderChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self LFactorSliderChanged:slider];
                lFactorSlider = slider;
            }
            if(indexPath.row == 2) {
                cell.textLabel.text = @"Interpolation";
                UISlider * slider = [self sliderForSettingCellWithMin:1.0
                                                                  max:5.0
                                                         initialValue:self.dataSourceAndDelegate.upsamplingFactor
                                                              forCell:cell];
                [slider addTarget:self action:@selector(upsamplingFactorChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self upsamplingFactorChanged:slider];
            }
        }
        if(indexPath.section == 2) {
            if(indexPath.row == 0) {
                cell.textLabel.text = @"Cropping mode";
                cropSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.croppingFlag
                                                                           forCell:cell];
                [cropSwitch addTarget:self action:@selector(cropSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [self cropSwitchChanged:cropSwitch];
                [cell addSubview:cropSwitch];
                [self cropSwitchChanged:cropSwitch];
            }
            if(indexPath.row == 1) {
                cell.textLabel.text = @"Alpha";
                UISlider * slider = [self sliderForSettingCellWithMin:0.0
                                                                  max:1.0
                                                         initialValue:self.dataSourceAndDelegate.croppingAlpha
                                                              forCell:cell];
                [slider addTarget:self action:@selector(croppingAlphaChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self croppingAlphaChanged:slider];
            }
            if(indexPath.row == 2) {
                cell.textLabel.text = @"Beta";
                UISlider * slider = [self sliderForSettingCellWithMin:0.0
                                                                  max:1.0
                                                         initialValue:self.dataSourceAndDelegate.croppingBeta
                                                              forCell:cell];
                [slider addTarget:self action:@selector(croppingBetaChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self croppingBetaChanged:slider];
            }
            if(indexPath.row == 3) {
                cell.textLabel.text = @"Gamma";
                UISlider * slider = [self sliderForSettingCellWithMin:0.0
                                                                  max:1.0
                                                         initialValue:self.dataSourceAndDelegate.croppingGamma
                                                              forCell:cell];
                [slider addTarget:self action:@selector(croppingGammaChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self croppingGammaChanged:slider];
            }
        }
        if(indexPath.section == 3) {
            if(indexPath.row == 0) {
                cell.textLabel.text = @"Drawing mode";
                UISwitch * paintSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.paintMode
                                                                            forCell:cell];
                [paintSwitch addTarget:self action:@selector(paintModeSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [self paintModeSwitchChanged:paintSwitch];
                [cell addSubview:paintSwitch];
                [self paintModeSwitchChanged:paintSwitch];
            }
            if(indexPath.row == 1) {
                cell.textLabel.text = @"Brush size";
                //cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0lf px",self.dataSourceAndDelegate.brushSize];
                UISlider * slider = [self sliderForSettingCellWithMin:log2f(20)
                                                                  max:log2f(200)
                                                         initialValue:log2f(self.dataSourceAndDelegate.brushSize)
                                                              forCell:cell];
                [slider addTarget:self action:@selector(brushSizeSliderChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:slider];
                [self brushSizeSliderChanged:slider];
            }
            if(indexPath.row == 2) {
                cell.textLabel.text = @"Saliency display";
                UISwitch * saliencySwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.showSaliency
                                                                               forCell:cell];
                [saliencySwitch addTarget:self action:@selector(showSaliencySwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:saliencySwitch];
                [self showSaliencySwitchChanged:saliencySwitch];
            }
        }
        if(indexPath.section == 4) {
            if(indexPath.row == 0) {
                cell.textLabel.text = @"Show Grid";
                UISwitch * gridSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.showGrid
                                                                           forCell:cell];
                [gridSwitch addTarget:self action:@selector(showGridSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:gridSwitch];
                [self showGridSwitchChanged:gridSwitch];
            }
            if(indexPath.row == 1) {
                cell.textLabel.text = @"Layout";
                UISwitch * layoutSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.layoutMode==kLayoutModeCombined
                                                                             forCell:cell];
                [layoutSwitch addTarget:self action:@selector(layoutSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:layoutSwitch];
                [self layoutSwitchChanged:layoutSwitch];
            }
            if(indexPath.row == 2) {
                cell.textLabel.text = @"Stabilization";
                UISwitch * stabilisationSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.motionCompensation forCell:cell];
                [stabilisationSwitch addTarget:self action:@selector(motionCompensationSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:stabilisationSwitch];
                [self motionCompensationSwitchChanged:stabilisationSwitch];
            }
        }
    } else { // simple settings
        if(indexPath.row == 0) {
            cell.textLabel.text = @"Advanced Settings";
            UISwitch * advancedSettingsSwitch = [self switchForSettingCellWithInitialValue:[self getAdvancedSettings]
                                                                                   forCell:cell];
            [advancedSettingsSwitch addTarget:self action:@selector(advancedSettingsSwitchChanged:) forControlEvents:UIControlEventValueChanged];
            [self advancedSettingsSwitchLoad:advancedSettingsSwitch];
            [cell addSubview:advancedSettingsSwitch];
            [self advancedSettingsSwitchLoad:advancedSettingsSwitch];
        }
        if(indexPath.row == 1) {
            cell.textLabel.text = @"Cropping mode";
            cropSwitch = [self switchForSettingCellWithInitialValue:self.dataSourceAndDelegate.croppingFlag
                                                                       forCell:cell];
            [cropSwitch addTarget:self action:@selector(cropSwitchChanged:) forControlEvents:UIControlEventValueChanged];
            [self cropSwitchChanged:cropSwitch];
            [cell addSubview:cropSwitch];
            [self cropSwitchChanged:cropSwitch];
        }
        if(indexPath.row == 2) {
            cell.textLabel.text = @"Brush size";
            //cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0lf px",self.dataSourceAndDelegate.brushSize];
            UISlider * slider = [self sliderForSettingCellWithMin:log2f(20)
                                                              max:log2f(200)
                                                     initialValue:log2f(self.dataSourceAndDelegate.brushSize)
                                                          forCell:cell];
            [slider addTarget:self action:@selector(brushSizeSliderChanged:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:slider];
            [self brushSizeSliderChanged:slider];
        }
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    return;
}

@end
