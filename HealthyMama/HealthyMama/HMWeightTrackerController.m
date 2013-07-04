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



#define BAR_POSITION    @"POSITION"
#define BAR_HEIGHT      @"HEIGHT"
#define COLOR           @"COLOR"
#define CATEGORY        @"CATEGORY"

#define AXIS_START 0
#define AXIS_END 50

@synthesize data;
@synthesize graph;
@synthesize hostingView;
@synthesize tableView;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = [WeighIn getWeighIns];
    
    // Build the weigh in graph data
    self.data = [NSMutableArray array];
    
    int bar_heights[] = {20,30,10,40};
    UIColor *colors[] = {
        [UIColor redColor],
        [UIColor blueColor],
        [UIColor orangeColor],
        [UIColor purpleColor]};
    NSString *categories[] = {@"Plain Milk", @"Milk + Caramel", @"White", @"Dark"};
    
    for (int i = 0; i < 4 ; i++){
        double position = i*10; //Bars will be 10 pts away from each other
        double height = bar_heights[i];
        
        NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithDouble:position],BAR_POSITION,
                             [NSNumber numberWithDouble:height],BAR_HEIGHT,
                             colors[i], COLOR,
                             categories[i], CATEGORY,
                             nil];
        [self.data addObject:bar];
        
    }
    [self generateBarPlot];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"Reloading");
    
    self.tableData = [WeighIn getWeighIns];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Keep a copy
    self.tableView = tableView;
    return [self.tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WeighInTrackerTableCellView";
    
    HMWeighInTrackerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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


-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ([plot.identifier isEqual:@"weightTracker"]) {
        return [self.data count];
    }
    
    return 0;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ([plot.identifier isEqual:@"weightTracker"]) {
        NSDictionary *bar = [self.data objectAtIndex:index];
        
        if(fieldEnum == CPTBarPlotFieldBarLocation) {
            return [bar valueForKey:BAR_POSITION];
        } else if(fieldEnum ==CPTBarPlotFieldBarTip) {
            return [bar valueForKey:BAR_HEIGHT];
        }
    }
    return [NSNumber numberWithFloat:0];
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ([plot.identifier isEqual: @"weightTracker"]) {
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.fontName = @"Helvetica";
        textStyle.fontSize = 14;
        textStyle.color = [CPTColor whiteColor];
        
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", [bar valueForKey:@"CATEGORY"]]];
        label.textStyle =textStyle;
        
        return label;
    }
    
    CPTTextLayer *defaultLabel = [[CPTTextLayer alloc] initWithText:@"Label"];
    return defaultLabel;
    
}

-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    if ([barPlot.identifier isEqual:@"weightTracker"]) {
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTGradient *gradient = [CPTGradient gradientWithBeginningColor:[CPTColor whiteColor]
                                                            endingColor:[bar valueForKey:@"COLOR"]
                                                      beginningPosition:0.0 endingPosition:0.3 ];
        [gradient setGradientType:CPTGradientTypeAxial];
        [gradient setAngle:320.0];
        
        CPTFill *fill = [CPTFill fillWithGradient:gradient];
        
        return fill;
        
    }
    return [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    
}

- (void)generateBarPlot
{
    //Create host view
    self.hostingView = [[CPTGraphHostingView alloc] initWithFrame:[self.graphContainerView bounds]];
    [self.graphContainerView addSubview:self.hostingView];
    
    //Create graph and set it as host view's graph
    self.graph = [[CPTXYGraph alloc] initWithFrame:self.hostingView.bounds];
    [self.hostingView setHostedGraph:self.graph];
    
    //set graph padding and theme
    self.graph.plotAreaFrame.paddingTop = 20.0f;
    self.graph.plotAreaFrame.paddingRight = 20.0f;
    self.graph.plotAreaFrame.paddingBottom = 70.0f;
    self.graph.plotAreaFrame.paddingLeft = 70.0f;
    //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
    //set axes ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    //set axes' title, labels and their text styles
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor whiteColor];
    axisSet.xAxis.title = @"CHOCOLATE";
    axisSet.yAxis.title = @"AWESOMENESS";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.yAxis.titleOffset = 40.0f;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    //set axes' line styles and interval ticks
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.lineWidth = 3.0f;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.yAxis.minorTickLength = 5.0f;
    
    // Create bar plot and add it to the graph
    CPTBarPlot *plot = [[CPTBarPlot alloc] init] ;
    plot.dataSource = self;
    plot.delegate = self;
    plot.barWidth = [[NSDecimalNumber decimalNumberWithString:@"5.0"]
                     decimalValue];
    plot.barOffset = [[NSDecimalNumber decimalNumberWithString:@"10.0"]
                      decimalValue];
    plot.barCornerRadius = 5.0;
    // Remove bar outlines
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor clearColor];
    plot.lineStyle = borderLineStyle;
    // Identifiers are handy if you want multiple plots in one graph
    plot.identifier = @"weightTracker";
    [self.graph addPlot:plot];
}

@end
