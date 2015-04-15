//
//  ASPTableViewController.h
//
//  Created by Graham Perks on 4/21/14.
//  Copyright (c) 2014 A Single Pixel, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASPTableViewController : UITableViewController

@property (nonatomic, strong) NSURL *jsonDefinitionURL;
@property (nonatomic, strong) NSMutableArray *sections;

-(NSIndexPath*) indexPathForRowWithKey:(NSString*)key andValue:(NSString*)value;
-(NSMutableDictionary*)cellInfoFromIndexPath:(NSIndexPath*)indexPath;

-(void)registerClass:(Class)cellClass forCellType:(NSString *)identifier;
-(void)registerNib:(UINib*)nib forCellType:(NSString *)identifier ofClass:(Class)cellClass;

@end
