//
//  ASPTableViewController.m
//
//  Created by Graham Perks on 4/21/14.
//  Copyright (c) 2014 A Single Pixel, LLC. All rights reserved.
//

// Your viewDidLoad, in a ASPTableViewController subclass, could look ike this:
// - (void)viewDidLoad
// {
//     NSURL *url = [[NSBundle mainBundle] URLForResource:@"shoes.json" withExtension:nil];
//     self.jsonDefinitionURL = url;
//
//     [super viewDidLoad];
//     ...

#import "ASPTableViewController.h"
#import "ASPTableViewCell.h"


@interface ASPTableViewController ()
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableDictionary *rowClasses;
@end


@implementation ASPTableViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rowClasses = [NSMutableDictionary dictionary];
}


-(void)setJsonDefinitionURL:(NSURL *)url
{
    _jsonDefinitionURL = url;

    if (url) {

        NSError *error = nil;
        NSInputStream *stream = [[NSInputStream alloc] initWithURL:url];
        [stream open];
        self.sections = [NSJSONSerialization JSONObjectWithStream:stream
                                                          options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                            error:&error];

        if (error) {
            NSLog(@"Failed to read table definition %@", url);
        }
    }
    else {
        self.sections = [NSMutableArray array];
    }
}


-(NSMutableDictionary*)cellInfoFromIndexPath:(NSIndexPath*)indexPath
{
    NSMutableDictionary *section = self.sections[indexPath.section];
    NSMutableArray *cells = section[@"rows"];
    NSMutableDictionary *cellInfo = cells[indexPath.row];

    return cellInfo;
}


#pragma mark - Table view delegate

-(void)performActionForCell:(NSMutableDictionary*)cellInfo
{
    // Built in actions; we invoke one of these:
    // 1. Perform a selector
    // 2. Push a storyboard's view controller
    // 3. Perform a segue
    NSString *selector = cellInfo[@"action"];
    NSString *segue = cellInfo[@"segue"];
    NSString *storyboardName = cellInfo[@"storyboard"];
    NSString *viewControllerId = cellInfo[@"viewControllerId"];

    if (selector) {
        SEL sel = NSSelectorFromString(selector);
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, NSMutableDictionary*) = (void *)imp;
        func(self, sel, cellInfo);
    }
    else if (storyboardName) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UIViewController *vc;
        if (viewControllerId) {
            vc = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
        }
        else {
            vc = [storyboard instantiateInitialViewController];
        }

        [self prepareForStoryboard:storyboardName viewControllerId:viewControllerId fromCell:cellInfo destination:vc];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (segue) {
        [self performSegueWithIdentifier:segue sender:self];
    }
}

-(void)prepareForStoryboard:(NSString *)storyboardName
           viewControllerId:(NSString*)viewControllerId
                   fromCell:(NSDictionary*)cellInfo
                destination:(UIViewController*)viewController
{
    // Can be overridden to prepare a destination viewController, cf prepareForSegue.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *cellInfo = [self cellInfoFromIndexPath:indexPath];

    [self performActionForCell:cellInfo];
}

#pragma mark - Table View data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDefinition = self.sections[section];
    NSArray *rows = sectionDefinition[@"rows"];
    return rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowDefinition = [self cellInfoFromIndexPath:indexPath];
    NSString *cellId = rowDefinition[@"type"];

    ASPTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if ( ! [cell isKindOfClass:[ASPTableViewCell class]]) {
        NSLog(@"Cell must be a subclass of ASPTableViewCell!");
    }

    [cell configureInViewController:self fromRowDefinition:rowDefinition ];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowDefinition = [self cellInfoFromIndexPath:indexPath];

    CGFloat height = 44;
    Class class = self.rowClasses[rowDefinition[@"type"]];

    SEL heightSelector = NSSelectorFromString(@"heightForRowDefinition:inViewController:");


    if (class && [class respondsToSelector:heightSelector]) {

        NSNumber *heightNumber;

        // 2 ways to invoke..
        // 1:
        IMP imp = [class methodForSelector:heightSelector];
        NSNumber* (*func)(id, SEL, NSMutableDictionary*, UIViewController*) = (void *)imp;
        heightNumber = func(class, heightSelector, rowDefinition, self);

//        // 2:
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature methodSignatureForSelector:heightSelector]];
//        [invocation invokeWithTarget:class];
//        [invocation getReturnValue:&heightNumber];

        height = [heightNumber doubleValue];
    }

    return height;
}

#pragma mark - Cell class registration

// Rows must register their classes with us independently from the table view's
// registration, as we need to call class methods on them before the table view
// instatiates them.
-(void)registerClass:(Class)cellClass forCellType:(NSString *)identifier
{
    self.rowClasses[identifier] = cellClass;
}


@end
