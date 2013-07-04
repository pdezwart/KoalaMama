//
//  HMWeightTrackerController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "WeighIn.h"
#import "HMWeighInTrackerTableCell.h"

@interface HMWeightTrackerController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (weak, nonatomic) IBOutlet UIView *graphContainerView;

@end
