//
//  HMFoodJournalViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMFoodJournalViewController.h"
#import "HMFoodEventViewController.h"
#import "Flurry.h"

@interface HMFoodJournalViewController ()

@property (strong, nonatomic) NSMutableDictionary *tableSections;
@property (strong, nonatomic) NSArray *tableSectionDates;

@property (strong, nonatomic) NSDateFormatter *tableSectionDateFormatter;

@end


@implementation HMFoodJournalViewController

@synthesize noDataOverlayView;
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
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Page_FoodJournal"];

    // Get all of the existing journal entries
    self.tableData = [FoodJournal getJournal];
    
    // If there are no Weigh Ins yet, show the modal window indicating that they should add some
    if ([self.tableData count] == 0 && !noDataOverlayView) {
        // Get the window and status bar size:
        CGRect viewPaneFrame = [[UIScreen mainScreen] bounds];
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        
        // Put an overlay over everything, minus the status bar because thats not cool...
        noDataOverlayView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                     0,
                                                                     statusBarFrame.size.height,
                                                                     viewPaneFrame.size.width,
                                                                     viewPaneFrame.size.height - statusBarFrame.size.height)];
        
        // Add the alpha view:
        UIView *alphaView = [[UIView alloc] initWithFrame:noDataOverlayView.frame];
        [alphaView setBackgroundColor:[UIColor blackColor]];
        [alphaView setAlpha:0.5];
        
        
        // Put this in the middle with padding on the right and left
        CGRect titleViewFrame = CGRectMake(40, 130, viewPaneFrame.size.width - 80, 30);
        UITextView *titleView = [[UITextView alloc] initWithFrame:titleViewFrame];
        
        [titleView setText:@"Track Your Calorie Intake!"];
        [titleView setBackgroundColor:UIColorFromString(@"rgba(255,234,189,1)")];
        titleView.textAlignment = NSTextAlignmentCenter;
        
        CGRect bodyViewFrame = CGRectMake(40, 160, viewPaneFrame.size.width - 80, 100);
        UITextView *bodyView = [[UITextView alloc] initWithFrame:bodyViewFrame];
        
        [bodyView setText:@"To use this feature, add each serving and its associated calories."];
        [bodyView setBackgroundColor:[UIColor whiteColor]];
        bodyView.textAlignment = NSTextAlignmentCenter;
        
        UIButton *addWeighInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[addWeighInButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
        addWeighInButton.frame = CGRectMake(60, 220, viewPaneFrame.size.width - 120, 30);
        [addWeighInButton setTitle:@"Add A Meal" forState:UIControlStateNormal];
        [addWeighInButton addTarget:self action:@selector(addFoodEvent) forControlEvents:UIControlEventTouchUpInside];
        
        [noDataOverlayView addSubview:alphaView];
        [noDataOverlayView addSubview:titleView];
        [noDataOverlayView addSubview:bodyView];
        [noDataOverlayView addSubview:addWeighInButton];
        
        [self.view addSubview:noDataOverlayView];
        
        return;
    } else if ([self.tableData count] > 0 && noDataOverlayView) {
        // We need to remove the old No Data view so people can see their stuff
        [noDataOverlayView removeFromSuperview];
    }
    
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
    NSString *jsonString = [NSString stringWithFormat:@"var yAxisFormat = \"{value}cal\"; var series = [{\"data\": %@, \"name\": \"Calories\"}];", self.chartData];
    
    htmlString = [htmlString stringByAppendingString:jsonString];
    
    // Append the footer:
    NSString *htmlFooterFile = [[NSBundle mainBundle] pathForResource:@"chartViewFooter" ofType:@"html" inDirectory:@"js"];
    NSString *htmlFooterString = [NSString stringWithContentsOfFile:htmlFooterFile encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByAppendingString:htmlFooterString];
    NSLog(@"%@", htmlString);
    [self.chartView loadHTMLString:htmlString baseURL:baseURL];

}

- (void)addFoodEvent
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];
    HMFoodEventViewController *addFoodEvent = [storyboard instantiateViewControllerWithIdentifier:@"HMFoodEventViewController"];
    [addFoodEvent setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:addFoodEvent animated:YES completion:nil];
}


- (void)buildTableSectionHeaderData
{
    // Build the table headers
    self.tableSections = [NSMutableDictionary dictionary];
    for (FoodJournal *event in self.tableData) {
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
    
    FoodJournal *event = self.tableData[indexPath.row];
    
    // Configure the cell.
    cell.label.text = event.label;
    cell.calories.text = [event.calories stringValue];
    
    return cell;
}

@end
