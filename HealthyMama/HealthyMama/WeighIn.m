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

+ (NSArray *)getWeighIns {
    
    return [WeighIn findAllSortedBy:@"time" ascending:NO];
}

+ (WeighIn *) factory {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    return [WeighIn createInContext:localContext];
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



@end
