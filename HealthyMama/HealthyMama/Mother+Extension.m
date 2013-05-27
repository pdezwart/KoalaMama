//
//  Mother+Extension.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/20/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "Mother+Extension.h"

@implementation Mother (Extension)


- (NSString *) timeTillDue {
    return @"3 months";
}
/*
 // Save our fetched data to an array
 Mother *mother = (Mother *)[mutableFetchResults lastObject];
 if (!mother) {
 NSLog(@"There was no mother");
 mother = [NSEntityDescription insertNewObjectForEntityForName:@"Mother" inManagedObjectContext:context];
 
 
 // Set default values
 // Everying is 5'2", right?
 mother.height = [NSNumber numberWithInt:62];
 
 // Figure out when is 9 months from now
 NSTimeInterval nineMonths = 60 * 60 * 24 * 7 * 40;
 mother.expectedDueDate = [NSDate dateWithTimeIntervalSinceNow:nineMonths];
 
 // Everyone weight about 120lbs too:
 mother.prePregnancyWeight = [NSNumber numberWithInt:120];
 } else {
 NSLog(@"There was a mother... %@", mother);
 NSLog(@"There was a mother... %@", mother.height);
 }
 
*/

@end
