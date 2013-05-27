//
//  HealtyMamaFirstViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/15/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HealtyMamaFirstViewController.h"

@interface HealtyMamaFirstViewController ()

@end

@implementation HealtyMamaFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:10];
    [comps setMonth:8];
    [comps setYear:2013];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *estimatedDueDate = [gregorian dateFromComponents:comps];
    
    // Build the estimated date:
    NSDateFormatter *fmtEstimatedDueDate = [[NSDateFormatter alloc] init];
    [fmtEstimatedDueDate setDateFormat:@"yyyy-MM-dd"];
    self.labelEstimatedDueDate.text = [fmtEstimatedDueDate stringFromDate:estimatedDueDate];

    // Figure out how deep we are:
    NSDate *now = [NSDate date];
    NSTimeInterval timeTillDue = [estimatedDueDate timeIntervalSinceDate:now];
    // Convert the number of seconds into weeks and days:
    NSInteger daysTillDue = (timeTillDue) / 86400;
    NSInteger days = daysTillDue % 7;
    NSInteger weeks = (daysTillDue - days) / 7;
    
    self.labelYourPregnancy.text = [NSString stringWithFormat:@"%d weeks and %d days", weeks, days];
    
    // Set recommended daily calories
    self.labelRecommendedDailyCalories.text = [[@"500" stringByAppendingString:@" / "] stringByAppendingString: @"2300"];
    
        // Load the current state of affairs:
    self.labelCurrentWeightGain.text = @"+20 lbs (good)";
}

@end
