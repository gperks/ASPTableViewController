//
//  ASPTableViewCell.m
//
//  Created by Graham Perks on 4/21/14.
//  Copyright (c) 2014 A Single Pixel, LLC. All rights reserved.
//

#import "ASPTableViewCell.h"

@implementation ASPTableViewCell


- (void)configureAccessoryTypeFrom:(NSMutableDictionary *)rowDefinition
{
    NSString *accessory = rowDefinition[@"accessory"];
    
    if (accessory) {
        NSDictionary *accessorySwitch = @{
                                          @"disclosure": ^{ self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; },
                                          @"detailDisclosure": ^{ self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; },
                                          @"detail": ^{ self.accessoryType = UITableViewCellAccessoryDetailButton; }
                                          };
        
        typedef void (^CaseBlock)();
        ((CaseBlock)accessorySwitch[accessory])();
    }
}

- (void)configureAccessoryImageFrom:(NSMutableDictionary *)rowDefinition
{
    NSString *accessoryImage = rowDefinition[@"accessoryImage"];
    
    if (accessoryImage) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:accessoryImage]];
        self.accessoryView = iv;
    }
}

- (void)configureSelectionStyleFrom:(NSMutableDictionary *)rowDefinition
{
    NSString *accessory = rowDefinition[@"selectionStyle"];

    if (accessory) {
        NSDictionary *accessorySwitch = @{
                                          @"default": ^{ self.selectionStyle = UITableViewCellSelectionStyleDefault; },
                                          @"none": ^{ self.selectionStyle = UITableViewCellSelectionStyleNone; },
                                          };

        typedef void (^CaseBlock)();
        ((CaseBlock)accessorySwitch[accessory])();
    }
}

-(void) configureInViewController:(UITableViewController*)viewController fromRowDefinition:(NSMutableDictionary*)rowDefinition
{
    [self configureAccessoryTypeFrom:rowDefinition];
    [self configureAccessoryImageFrom:rowDefinition];
    [self configureSelectionStyleFrom:rowDefinition];
}

+(void)registerCellForTableViewController:(ASPTableViewController*)tableViewController
{
    // Override me
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)awakeFromNib
//{
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
