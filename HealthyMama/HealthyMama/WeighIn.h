//
//  WeighIn.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "_WeighIn.h"
#import "Mother.h"

@interface WeighIn : _WeighIn {}

+ (WeighIn *) factory;
+ (NSArray *) getWeighIns;
- (void) save;
- (int) daysIntoPregnancy;
@end
