//
//  WeighIn.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "WeighIn.h"
#import "Mother.h"

#define AVERAGE_DAILY_WEIGHT_VARIANCE 2;

@implementation WeighIn

+ (int)getMinWeightForDate:(NSDate *)date
{
    Mother *mother = [Mother getMother];
    
    double bmi = [mother getBMI];
    int totalMinWeightGain = 0;
    // Start from the smalled BMI (highest weight gain) and move up
    if (mother.expectingTwinsValue) {
        if (bmi >= 30) {
            totalMinWeightGain = 25;
        } else if (bmi >= 25) {
            totalMinWeightGain = 31;
        } else if (bmi >= 18.5) {
            totalMinWeightGain = 37;
        } else {
            totalMinWeightGain = 40;
        }
    } else {
        if (bmi >= 30) {
            totalMinWeightGain = 11;
        } else if (bmi >= 25) {
            totalMinWeightGain = 15;
        } else if (bmi >= 18.5) {
            totalMinWeightGain = 25;
        } else {
            totalMinWeightGain = 28;
        }
    }
    
    // Figure out the percentage of the pregnancy completed for the given date, bounded by 0 and 1
    double percentage = MIN(1, MAX(0, (double)[mother daysIntoPregnancyForDate:date] / (double)PREGNANCY_IN_DAYS));
    
    return mother.imperialPrePregnancyWeightValue + (int)(totalMinWeightGain * percentage) - AVERAGE_DAILY_WEIGHT_VARIANCE;
}

+ (int)getMaxWeightForDate:(NSDate *)date
{
    Mother *mother = [Mother getMother];
    
    double bmi = [mother getBMI];
    int totalMaxWeightGain = 0;
    // Start from the smalled BMI (highest weight gain) and move up
    if (mother.expectingTwinsValue) {
        if (bmi >= 30) {
            totalMaxWeightGain = 42;
        } else if (bmi >= 25) {
            totalMaxWeightGain = 50;
        } else if (bmi >= 18.5) {
            totalMaxWeightGain = 54;
        } else {
            totalMaxWeightGain = 58;
        }
    } else {
        if (bmi >= 30) {
            totalMaxWeightGain = 20;
        } else if (bmi >= 25) {
            totalMaxWeightGain = 25;
        } else if (bmi >= 18.5) {
            totalMaxWeightGain = 35;
        } else {
            totalMaxWeightGain = 40;
        }
    }
    
    // Figure out the percentage of the pregnancy completed for the given date, bounded by 0 and 1
    float percentage = MIN(1, MAX(0, (double)[mother daysIntoPregnancyForDate:date] / (double)PREGNANCY_IN_DAYS));
    
    return mother.imperialPrePregnancyWeightValue + (int)(totalMaxWeightGain * percentage) + AVERAGE_DAILY_WEIGHT_VARIANCE;
}

+ (NSString *)getMinWeight
{
    NSArray *weighIns = [self getWeighIns:YES];
    
    if ([weighIns count] <= 0) {
        return @"[]";
    }
    
    // Fill in all of the days between the first and last day with the expected minimum calories
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay: 1];
    
    WeighIn *startEvent = [weighIns objectAtIndex:0];
    WeighIn *endEvent = [weighIns objectAtIndex:[weighIns count] - 1];
    
    NSDate *startDate = [startEvent getDate];
    NSDate *endDate = [endEvent getDate];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    int weight = 0;
    for (
        NSDate *date = [startDate copy];
        [date compare: endDate] <= 0;
        date = [calendar dateByAddingComponents:oneDay toDate:date options:0]
    ) {
        
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        weight = [self getMinWeightForDate:date];
        [dataPoints addObject:[NSString stringWithFormat:@"{x: Date.UTC(%ld, %d, %d), y: %d, marker:{enabled:false}}", (long)[components year], [components month] - 1, [components day], weight]];
    }
    
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}

+ (NSString *)getMaxWeight
{
    NSArray *weighIns = [self getWeighIns:YES];
    
    if ([weighIns count] <= 0) {
        return @"[]";
    }
    
    // Fill in all of the days between the first and last day with the expected minimum calories
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay: 1];
    
    WeighIn *startEvent = [weighIns objectAtIndex:0];
    WeighIn *endEvent = [weighIns objectAtIndex:[weighIns count] - 1];
    
    NSDate *startDate = [startEvent getDate];
    NSDate *endDate = [endEvent getDate];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    int weight = 0;
    for (NSDate *date = [startDate copy]; [date compare: endDate] <= 0; date = [calendar dateByAddingComponents:oneDay toDate:date options:0]) {

        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        weight = [self getMaxWeightForDate:date];
        [dataPoints addObject:[NSString stringWithFormat:@"{x: Date.UTC(%ld, %d, %d), y: %d, marker:{enabled:false}}", (long)[components year], [components month] - 1, [components day], weight]];
    }
    
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}

+ (NSArray *)getWeighIns {
    return [WeighIn getWeighIns:NO];
    
}

+ (NSArray *)getWeighIns:(BOOL)ascending {
    return [WeighIn findAllSortedBy:@"time" ascending:ascending];
}

+ (WeighIn *) factory {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    return [WeighIn createInContext:localContext];
}

+ (NSString *)getWeighInsAsJson {
    NSArray *weighIns = [self getWeighIns:YES];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];

    for (WeighIn *obj in weighIns) {
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:obj.time];
        
        [dataPoints addObject:[NSString stringWithFormat:@"[Date.UTC(%d, %d, %d), %@]", [components year], [components month] - 1, [components day], obj.imperialWeight]];
    }
    
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}

- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

- (int) daysIntoPregnancy {
    NSDate *conception = [NSDate dateWithTimeInterval:-(60 * 60 * 24 * 7 * 40) sinceDate:self.mother.estimatedDueDate];
    
    float daysSinceConception = -1 * [conception timeIntervalSinceDate:self.time] / (60 * 60 * 24);
    
    return (int)daysSinceConception;
}

- (NSString *) timeAsString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringDate = [formatter stringFromDate:self.time];
    
    return stringDate;
}

- (NSDate *)getDate {
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.time];
    
    return [calendar dateFromComponents:components];
}

@end
