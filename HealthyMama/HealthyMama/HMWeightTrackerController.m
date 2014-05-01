//
//  HMWeightTrackerController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMWeightTrackerController.h"

@interface HMWeightTrackerController ()

@property (strong, nonatomic) NSArray * tableData;

@end

@implementation HMWeightTrackerController


@synthesize data;
@synthesize tableView;

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tableData = [WeighIn getWeighIns];
    [self.tableView reloadData];

    // Get the base URL for referential local loading
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];

    // Pull the content out (encoded in UTF8)
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"chartView" ofType:@"html" inDirectory:@"js"];    
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.chartView loadHTMLString:htmlString baseURL:baseURL];
}

- (NSInteger)tableView:(UITableView *)tView numberOfRowsInSection:(NSInteger)section
{
    // Keep a copy
    self.tableView = tView;
    return [self.tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WeighInTrackerTableCellView";
    
    HMWeighInTrackerTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"WeighInTrackerTableCellView" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    WeighIn *event = self.tableData[indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

    
    // Configure the cell.
    cell.date.text = [dateFormatter stringFromDate:event.time];
    cell.weight.text = [[event.imperialWeight stringValue] stringByAppendingString:@" lbs"];

    return cell;
}

@end
