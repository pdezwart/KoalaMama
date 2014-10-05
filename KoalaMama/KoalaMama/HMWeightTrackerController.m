//
//  HMWeightTrackerController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMWeightTrackerController.h"
#import "HMWeighInViewController.h"
#import "Flurry.h"


@interface HMWeightTrackerController ()

@property (strong, nonatomic) NSArray * tableData;

@end

@implementation HMWeightTrackerController


@synthesize data;
@synthesize tableView;
@synthesize noDataOverlayView;
@synthesize chartData;


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Page_WeighTracker"];

    self.tableData = [WeighIn getWeighIns];
    [self.tableView reloadData];
    self.chartData = [WeighIn getWeighInsAsJson];

    // If there are no Weigh Ins yet, show the modal window indicating that they should add some
    if ([self.tableData count] == 0 && !noDataOverlayView) {
        // Get the window and status bar size:
        CGRect viewPaneFrame = [[UIScreen mainScreen] bounds];
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        
        // Put an overlay over everything, minus the status bar because thats not cool...
        noDataOverlayView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                   0,
                                                                   0,
                                                                   viewPaneFrame.size.width,
                                                                   viewPaneFrame.size.height)];
        
        // Add the alpha view:
        UIView *alphaView = [[UIView alloc] initWithFrame:noDataOverlayView.frame];
        [alphaView setBackgroundColor:[UIColor blackColor]];
        [alphaView setAlpha:0.5];
        
        
        // Put this in the middle with padding on the right and left
        CGRect titleViewFrame = CGRectMake(40, 130, viewPaneFrame.size.width - 80, 30);
        UITextView *titleView = [[UITextView alloc] initWithFrame:titleViewFrame];
        
        [titleView setText:@"Track Your Weight Gain!"];
        [titleView setBackgroundColor:UIColorFromString(@"rgba(255,234,189,1)")];
        titleView.textAlignment = NSTextAlignmentCenter;
        
        CGRect bodyViewFrame = CGRectMake(40, 160, viewPaneFrame.size.width - 80, 100);
        UITextView *bodyView = [[UITextView alloc] initWithFrame:bodyViewFrame];
        
        [bodyView setText:@"To use this feature, enter your current weight and track it over time."];
        [bodyView setBackgroundColor:[UIColor whiteColor]];
        bodyView.textAlignment = NSTextAlignmentCenter;
        
        UIButton *addWeighInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[addWeighInButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
        addWeighInButton.frame = CGRectMake(60, 220, viewPaneFrame.size.width - 120, 30);
        [addWeighInButton setTitle:@"Add A Weigh-In" forState:UIControlStateNormal];
        [addWeighInButton addTarget:self action:@selector(addWeighIn) forControlEvents:UIControlEventTouchUpInside];
        
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

- (void)addWeighIn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];
    HMWeighInViewController *addWeighIn = [storyboard instantiateViewControllerWithIdentifier:@"HMWeighInViewController"];
    [addWeighIn setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:addWeighIn animated:YES completion:nil];
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
