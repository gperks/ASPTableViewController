//
//  TextTableCell.m
//  ASPTableExample
//
//  Created by Graham Perks on 2/8/15.
//  Copyright (c) 2015 A Single Pixel, LLC. All rights reserved.
//

#import "TextTableCell.h"
#import "CompactConstraint.h"

@interface TextTableCell()
@property (nonatomic, weak) UILabel *titleLabel;
@end

const CGFloat SideMargin = 30;
@implementation TextTableCell

+(void)registerCellForTableViewController:(ASPTableViewController*)tableViewController {
    [tableViewController registerClass:self forCellType:@"TextCell"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];

    }
    return self;
}

-(void)createUI {

    // Just a label for this cell type.
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel);
    [self.contentView addCompactConstraints:@[ @"titleLabel.top = self.top",
                                               @"titleLabel.bottom = self.bottom",
                                               @"titleLabel.left = self.left + SideMargin",
                                               @"titleLabel.right = self.right - SideMargin"
                                              ]
                                    metrics:@{ @"SideMargin" : @(SideMargin) }
                                      views:views];
}


-(void) configureInViewController:(UITableViewController*)viewController
                fromRowDefinition:(NSMutableDictionary*)rowDefinition {

    [super configureInViewController:viewController fromRowDefinition:rowDefinition];
    
    // Read fields in rowDefinition to configure this cell.
    self.titleLabel.text = rowDefinition[@"text"];
}


-(void)prepareForReuse {
    self.titleLabel.text = @"";
}

// Implement this if your table row height varies depending on what data it's displaying.
// For this simple text-based cell, we compute the height required for the text.
+(CGFloat)heightForRowDefinition:(NSMutableDictionary*)rowDefinition
                inViewController:(UITableViewController*)viewController {
    NSString *text = rowDefinition[@"text"];
    CGFloat height = [text boundingRectWithSize:CGSizeMake(viewController.view.bounds.size.width - SideMargin*2, 2000)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20] }
                                        context:nil].size.height + 4;
    return MAX(44, ceil(height));
}

@end
