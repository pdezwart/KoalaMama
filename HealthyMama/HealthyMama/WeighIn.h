//
//  WeighIn.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mother;

@interface WeighIn : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) Mother *mother;

@end
