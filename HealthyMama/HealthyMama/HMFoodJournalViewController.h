//
//  HMFoodJournalViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodJournal.h"
#import "HMFoodJournalTableCell.h"

@interface HMFoodJournalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *data;

@property (nonatomic, retain) NSString *chartData;
@property (weak, nonatomic) IBOutlet UIWebView *chartView;

@end
