//
//  Mother+Extension.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/20/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "Mother.h"

@interface Mother (Extension)
- (NSString *) timeTillDue;
+ (void) getMotherWithContext:(NSManagedObjectContext *) completion:(void (^)(Mother *mother))callback;
@end
