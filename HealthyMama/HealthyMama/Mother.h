//
//  Mother.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/20/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mother : NSManagedObject

@property (nonatomic, retain) NSNumber * prePregnancyWeight;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSDate * expectedDueDate;

@end
