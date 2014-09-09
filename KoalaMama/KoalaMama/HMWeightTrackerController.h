//
//  HMWeightTrackerController.h
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeighIn.h"
#import "HMWeighInTrackerTableCell.h"

@interface HMWeightTrackerController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSString *chartData;
@property (nonatomic, retain) UIView *noDataOverlayView;
@property (weak, nonatomic) IBOutlet UIView *graphContainerView;
@property (weak, nonatomic) IBOutlet UIWebView *chartView;

- (void)addWeighIn;

@end
