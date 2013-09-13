//
//  RatioPicker.m
//  Retargeting
//
//  Created by Daniel Graf on 17.02.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
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

#import "RatioPicker.h"

@interface RatioPicker ()

@end

@implementation RatioPicker
@synthesize dataSourceAndDelegate = _dataSourceAndDelegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andDataSourceDelegate:(id)aDataSourceDelegate
{
    self = [self initWithStyle:style];
    self.dataSourceAndDelegate = aDataSourceDelegate;
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Choose Aspect Ratio";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.dataSourceAndDelegate action:@selector(didFinishChoosingRatio:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 8;
        case 1:
            return 1;
        case 2:
            return 4;
        default:
            return 0;
            break;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section==0) return @"Classical Aspect Ratios";
    if(section==1) return @"Original Aspect Ratio";
    if(section==2) return @"RetargetMe Ratios";
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    // Configure the cell...
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) cell.textLabel.text = @"1:1         squared";
        if(indexPath.row == 1) cell.textLabel.text = @"4:3         landscape";
        if(indexPath.row == 2) cell.textLabel.text = @"3:4         portrait";
        if(indexPath.row == 3) cell.textLabel.text = @"16:9       widescreen";
        if(indexPath.row == 4) cell.textLabel.text = @"2.39:1    cinema";
        if(indexPath.row == 5) cell.textLabel.text = @"3:2         classic 35mm film";
        if(indexPath.row == 6) cell.textLabel.text = @"2:3         iPhone";
        if(indexPath.row == 7) cell.textLabel.text = @"1.618:1  golden ratio";
    }
    if(indexPath.section==1) {
        cell.textLabel.text = @"back to original aspect ratio";
    }
    if(indexPath.section==2) {
        if(indexPath.row == 0) cell.textLabel.text = @"0.5         width";
        if(indexPath.row == 1) cell.textLabel.text = @"0.75       width";
        if(indexPath.row == 2) cell.textLabel.text = @"1.25       width";
        if(indexPath.row == 3) cell.textLabel.text = @"0.75       height";
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
    double targetRatio = 1.0;
    if (indexPath.section == 0) {
        if(indexPath.row == 0) targetRatio = 1.0;
        if(indexPath.row == 1) targetRatio = 4.0/3.0;
        if(indexPath.row == 2) targetRatio = 3.0/4.0;
        if(indexPath.row == 3) targetRatio = 16.0/9.0;
        if(indexPath.row == 4) targetRatio = 2.39;
        if(indexPath.row == 5) targetRatio = 3.0/2.0;
        if(indexPath.row == 6) targetRatio = 2.0/3.0;
        if(indexPath.row == 7) targetRatio = 1.618;
    }
    if (indexPath.section == 1) {
        targetRatio = [self.dataSourceAndDelegate sourceRatio];
    }
    if (indexPath.section == 2) {
        if(indexPath.row == 0) targetRatio = 0.5*[self.dataSourceAndDelegate sourceRatio];
        if(indexPath.row == 1) targetRatio = 0.75*[self.dataSourceAndDelegate sourceRatio];
        if(indexPath.row == 2) targetRatio = 1.25*[self.dataSourceAndDelegate sourceRatio];
        if(indexPath.row == 3) targetRatio = [self.dataSourceAndDelegate sourceRatio]/0.75;
    }
    [self.dataSourceAndDelegate setTargetRatio:targetRatio];
    [self.dataSourceAndDelegate didFinishChoosingRatio:self];
}

@end
