//
//  HMFoodJournalViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMFoodJournalViewController.h"

@interface HMFoodJournalViewController ()

@property (strong, nonatomic) NSMutableDictionary *tableSections;
@property (strong, nonatomic) NSArray *tableSectionDates;

@property (strong, nonatomic) NSDateFormatter *tableSectionDateFormatter;

@end


@implementation HMFoodJournalViewController

@synthesize chartData;
@synthesize tableSections;
@synthesize tableSectionDates;
@synthesize tableSectionDateFormatter;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize the date formatter:
    self.tableSectionDateFormatter = [[NSDateFormatter alloc] init];
    [self.tableSectionDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.tableSectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];

}

- (void)viewDidAppear:(BOOL)animated
{
    // Get all of the existing journal entries
    self.data = [FoodJournal getJournal];
    
    // Build the table section headers
    [self buildTableSectionHeaderData];
    
    [self.tableView reloadData];
    
    [self loadChart];
}

- (void)loadChart
{
    self.chartData = [FoodJournal getJournalAsJson];
    
    // Get the base URL for referential local loading
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    // We need to piece together the HTML
    // Load the Header first
    NSString *htmlHeaderFile = [[NSBundle mainBundle] pathForResource:@"chartViewHeader" ofType:@"html" inDirectory:@"js"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlHeaderFile encoding:NSUTF8StringEncoding error:nil];
    
    
    // The header ends with "var dataSeries =". Now shove in the JSON data for the chart
    NSString *jsonString = [NSString stringWithFormat:@"[{\"data\": %@, \"name\": \"Calories\"}]", self.chartData];
    
    htmlString = [htmlString stringByAppendingString:jsonString];
    
    // Append the footer:
    NSString *htmlFooterFile = [[NSBundle mainBundle] pathForResource:@"chartViewFooter" ofType:@"html" inDirectory:@"js"];
    NSString *htmlFooterString = [NSString stringWithContentsOfFile:htmlFooterFile encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByAppendingString:htmlFooterString];
    
    [self.chartView loadHTMLString:htmlString baseURL:baseURL];

}


- (void)buildTableSectionHeaderData
{
    // Build the table headers
    self.tableSections = [NSMutableDictionary dictionary];
    for (FoodJournal *event in self.data) {
        NSDate *key = [event getDate];
        NSMutableArray *eventsOfDay = [self.tableSections objectForKey:key];
        if (eventsOfDay == nil) {
            eventsOfDay = [NSMutableArray array];
            
            [self.tableSections setObject:eventsOfDay forKey:key];
        }
        
        [eventsOfDay addObject:event];
    }
    
    NSArray *unsortedDays = [self.tableSections allKeys];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(compare:)];
    self.tableSectionDates = [unsortedDays sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.tableSectionDates objectAtIndex:section];
    NSArray *eventsOnThisDay = [self.tableSections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.tableSectionDates objectAtIndex:section];
    return [self.tableSectionDateFormatter stringFromDate:dateRepresentingThisDay];
}

-(UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FoodJournalTableCellView";
    
    HMFoodJournalTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    FoodJournal *event = self.data[indexPath.row];
    
    // Configure the cell.
    cell.label.text = event.label;
    cell.calories.text = [event.calories stringValue];
    
    return cell;
}

@end
