//
//  HMMainViewController.h
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mother.h"

@interface HMMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *estimatedDueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourPregnancyLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendedDailyCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeightGainLabel;

@end
