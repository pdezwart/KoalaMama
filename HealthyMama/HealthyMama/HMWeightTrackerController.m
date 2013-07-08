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

@synthesize data;
@synthesize graph;
@synthesize hostingView;
@synthesize tableView;

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"Reloading");
    
    self.tableData = [WeighIn getWeighIns];
    [self.tableView reloadData];
    [self generateBarPlot];
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
    if ([plot.identifier isEqual:@"WeightPlot"]) {
        return [self.tableData count];
    }
    
    return 0;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ([plot.identifier isEqual:@"WeightPlot"]) {
        WeighIn *event = [self.tableData objectAtIndex:index];

        if(fieldEnum == CPTScatterPlotFieldX) {
            return [NSNumber numberWithInteger:[event daysIntoPregnancy]];
        } else if (fieldEnum == CPTScatterPlotFieldY) {
            return event.imperialWeight;
        }
    }

    return 0;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ([plot.identifier isEqual:@"WeightPlot"]) {
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.fontName = @"Helvetica";
        textStyle.fontSize = 14;
        textStyle.color = [CPTColor whiteColor];
        
        WeighIn *event = [self.tableData objectAtIndex:index];
        
        CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%d lbs", event.imperialWeightValue]];
        label.textStyle = textStyle;
        
        return label;
    }
    
    CPTTextLayer *defaultLabel = [[CPTTextLayer alloc] initWithText:@"Label"];
    return defaultLabel;
}

-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
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
    self.graph.plotAreaFrame.paddingTop = 0.0f;
    self.graph.plotAreaFrame.paddingRight = 0.0f;
    self.graph.plotAreaFrame.paddingBottom = 0.0f;
    self.graph.plotAreaFrame.paddingLeft = 40.0f;
    self.graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];

    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    
    plotSpace.allowsUserInteraction = YES;
                                                                                                                 
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;

    //set axes' title, labels and their text styles
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor whiteColor];
    
    axisSet.xAxis.title = @"Weeks";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 10.0f;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 1.0f;

    axisSet.yAxis.title = @"Weight";
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleOffset = 0.0f;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 1.0f;

    //set axes' line styles and interval ticks
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.lineWidth = 3.0f;
    
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 5.0f;
    
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTickLength = 5.0f;

    
    // Create and add scatter plot
    CPTScatterPlot *weightPlot = [[CPTScatterPlot alloc] init];
    weightPlot.identifier = @"WeightPlot";
    
    weightPlot.dataSource = self;
    weightPlot.delegate = self;
    
    CPTMutableLineStyle *weightPlotLineStyle = [weightPlot.dataLineStyle mutableCopy];
    CPTColor *weightColor = [CPTColor redColor];
	weightPlotLineStyle.lineWidth = 2.5;
	weightPlotLineStyle.lineColor = weightColor;
	weightPlot.dataLineStyle = weightPlotLineStyle;
	CPTMutableLineStyle *weightLabelLineStyle = [CPTMutableLineStyle lineStyle];
	weightLabelLineStyle.lineColor = weightColor;
	CPTPlotSymbol *weightLabel = [CPTPlotSymbol ellipsePlotSymbol];
	weightLabel.fill = [CPTFill fillWithColor:weightColor];
	weightLabel.lineStyle = weightLabelLineStyle;
	weightLabel.size = CGSizeMake(6.0f, 6.0f);
	weightPlot.plotSymbol = weightLabel;

    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:weightPlot, nil]];
    
    // Figure out the plot range:
    double yMin = 100;
    double yMax = 200;
    
    if (self.tableData.count > 0) {
        WeighIn *firstEvent = [self.tableData objectAtIndex:0];
        double eventWeight = [firstEvent.imperialWeight doubleValue];

        yMin = eventWeight;
        yMax = eventWeight;
        for (WeighIn *event in self.tableData) {
            eventWeight = [event.imperialWeight doubleValue];
            yMin = eventWeight < yMin ? eventWeight : yMin;
            yMax = eventWeight > yMax ? eventWeight : yMax;
        }
    }
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation: CPTDecimalFromDouble(0) length:CPTDecimalFromDouble(40 * 7)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation: CPTDecimalFromDouble(yMin) length:CPTDecimalFromDouble(yMax - yMin)];
    
    [self.graph addPlot:weightPlot toPlotSpace:plotSpace];

}

@end
