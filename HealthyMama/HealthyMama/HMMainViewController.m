//
//  HMMainViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMMainViewController.h"
#import "FoodJournal.h"
#import "CalorieRequirement.h"

@interface HMMainViewController ()

@end

@implementation HMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	// Do any additional setup after loading the view.
    
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
    
    self.recommendedDailyCaloriesLabel.text = [NSString stringWithFormat:@"%d/%d", [[FoodJournal getCalorieIntake] intValue], 2000];
    self.currentWeightGainLabel.text = @"15 lbs";
    
    int age = [[mother age] intValue];
    
    NSLog(@"%d", [CalorieRequirement getRequirements:age :2]);
}


@end
