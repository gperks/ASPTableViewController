//
//  ASPTableViewCell.h
//
//  Created by Graham Perks on 4/21/14.
//  Copyright (c) 2014 A Single Pixel, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPTableViewController.h"


@interface ASPTableViewCell : UITableViewCell

// Subclasses should implement this method.
+(void)registerCellForTableViewController:(ASPTableViewController*)tableViewController;

-(void) configureInViewController:(UITableViewController*)viewController fromRowDefinition:(NSMutableDictionary*)rowDefinition;

@end
