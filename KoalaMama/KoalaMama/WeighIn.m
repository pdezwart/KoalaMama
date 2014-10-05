//
//  WeighIn.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "WeighIn.h"
#import "Mother.h"


@implementation WeighIn

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
        
        [dataPoints addObject:[NSString stringWithFormat:@"[Date.UTC(%d, %d, %d), %@]", (int)[components year], (int)[components month] - 1, (int)[components day], obj.imperialWeight]];
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

@end
