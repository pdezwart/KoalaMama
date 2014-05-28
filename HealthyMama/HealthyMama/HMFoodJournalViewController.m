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
}

- (NSDate *)stripTimeFromDate:(NSDate *)date
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    return [calendar dateFromComponents:components];
}

- (void)buildTableSectionHeaderData
{
    // Build the table headers
    self.tableSections = [NSMutableDictionary dictionary];
    for (FoodJournal *event in self.data) {
        NSDate *key = [self stripTimeFromDate:event.time];
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
    
    NSLog(@"%@", self.tableSectionDates);
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
