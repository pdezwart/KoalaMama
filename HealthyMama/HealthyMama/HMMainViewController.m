//
//  HMMainViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMMainViewController.h"
#import "FoodJournal.h"
#import "WeighIn.h"
#import "CalorieRequirement.h"
#import "Flurry.h"

@interface HMMainViewController ()

@end

@implementation HMMainViewController


- (void)viewDidAppear:(BOOL)animated
{
    [Flurry logEvent:@"Page_Main"];
    
    [super viewDidAppear:animated];
   
    // Setup the back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    // Draw your information:
    Mother *mother = [Mother getMother];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterMediumStyle];
    [f setTimeStyle:NSDateFormatterNoStyle];
    self.estimatedDueDateLabel.text = [f stringFromDate:mother.estimatedDueDate];
    
    self.yourPregnancyLabel.text = [mother timeLeftInPregnancy];
    
    int dailyCalorieRequirements = [CalorieRequirement getRequirementsForAge:[[mother age] intValue] forActivityLevel:2 forWeeksIntoPregnancy:[mother weeksIntoPregnancy]];
    self.recommendedDailyCaloriesLabel.text = [NSString stringWithFormat:@"%d/%d", [[FoodJournal getCalorieIntake] intValue], dailyCalorieRequirements];

    self.currentWeightGainLabel.text = [NSString stringWithFormat:@"%d lbs", [mother getWeightGain]];
}


@end
