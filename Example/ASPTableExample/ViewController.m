//
//  ViewController.m
//  ASPTableExample
//
//  Created by Graham Perks on 2/8/15.
//  Copyright (c) 2015 A Single Pixel, LLC. All rights reserved.
//

#import "ViewController.h"
#import "TextTableCell.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [TextTableCell registerCellForTableViewController:self];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Table" withExtension:@"json"];
    [self setJsonDefinitionURL:url];
}



@end
