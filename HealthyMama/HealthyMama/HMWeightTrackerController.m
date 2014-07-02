//
//  HMWeightTrackerController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMWeightTrackerController.h"
#import "Flurry.h"


@interface HMWeightTrackerController ()

@property (strong, nonatomic) NSArray * tableData;

@end

@implementation HMWeightTrackerController


@synthesize data;
@synthesize tableView;
@synthesize chartData;


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Page_WeighTracker"];

    self.tableData = [WeighIn getWeighIns];
    [self.tableView reloadData];
    self.chartData = [WeighIn getWeighInsAsJson];

    // Get the base URL for referential local loading
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];

    // We need to piece together the HTML
    // Load the Header first
    NSString *htmlHeaderFile = [[NSBundle mainBundle] pathForResource:@"chartViewHeader" ofType:@"html" inDirectory:@"js"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlHeaderFile encoding:NSUTF8StringEncoding error:nil];
    
    
    // The header ends with "var dataSeries =". Now shove in the JSON data for the chart
    NSString *jsonString = [NSString stringWithFormat:@"[{\"data\": %@, \"name\": \"Weight\"}]", self.chartData];
    
    htmlString = [htmlString stringByAppendingString:jsonString];
    
    // Append the footer:
    NSString *htmlFooterFile = [[NSBundle mainBundle] pathForResource:@"chartViewFooter" ofType:@"html" inDirectory:@"js"];
    NSString *htmlFooterString = [NSString stringWithContentsOfFile:htmlFooterFile encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByAppendingString:htmlFooterString];
    
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
