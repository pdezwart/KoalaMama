//
//  WeighIn.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "WeighIn.h"
#import "Mother.h"


@implementation WeighIn



+ (NSString *)getMinWeight
{
    NSArray *weighIns = [self getWeighIns:YES];
    
    // Fill in all of the days between the first and last day with the expected minimum calories
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay: 1];
    
    WeighIn *startEvent = [weighIns objectAtIndex:0];
    WeighIn *endEvent = [weighIns objectAtIndex:[weighIns count] - 1];
    
    NSDate *startDate = [startEvent getDate];
    NSDate *endDate = [endEvent getDate];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    for (NSDate *date = [startDate copy]; [date compare: endDate] <= 0; date = [calendar dateByAddingComponents:oneDay toDate:date options:0]) {
        NSLog( @"%@ in [%@,%@]", date, startDate, endDate );
        
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        
        [dataPoints addObject:[NSString stringWithFormat:@"{x: Date.UTC(%ld, %d, %d), y: %@, marker:{enabled:false}}", (long)[components year], [components month] - 1, [components day], [NSNumber numberWithInt:100]]];
    }
    
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}

+ (NSString *)getMaxWeight
{
    NSArray *weighIns = [self getWeighIns:YES];
    
    // Fill in all of the days between the first and last day with the expected minimum calories
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay: 1];
    
    WeighIn *startEvent = [weighIns objectAtIndex:0];
    WeighIn *endEvent = [weighIns objectAtIndex:[weighIns count] - 1];
    
    NSDate *startDate = [startEvent getDate];
    NSDate *endDate = [endEvent getDate];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    for (NSDate *date = [startDate copy]; [date compare: endDate] <= 0; date = [calendar dateByAddingComponents:oneDay toDate:date options:0]) {
        NSLog( @"%@ in [%@,%@]", date, startDate, endDate );
        
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        
        [dataPoints addObject:[NSString stringWithFormat:@"{x: Date.UTC(%ld, %d, %d), y: %@, marker:{enabled:false}}", (long)[components year], [components month] - 1, [components day], [NSNumber numberWithInt:150]]];
    }
    
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];}

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
