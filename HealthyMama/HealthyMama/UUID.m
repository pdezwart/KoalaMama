//
//  UUID.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 7/1/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "UUID.h"

#define PACKAGE @"net.de-zwart.healthymama"
#define USER @"user"


@implementation UUID

+ (NSString *) getUUID
{
    // Check if there is one already:
    NSString *uuid = [UUID retrieveUUID];
    
    if (uuid == nil) {
        // We dont have one. Create it:
        uuid = [UUID createUUID];
        // Store it for later:
        [UUID storeUUID:uuid];
    }
    
    return uuid;
}


+ (void) storeUUID:(NSString *)uuid
{
    [SSKeychain setPassword:uuid forService:PACKAGE account:USER];
}

+ (NSString *) retrieveUUID
{
    return [SSKeychain passwordForService:PACKAGE account:USER];
}

+ (NSString *) createUUID
{
    return [[NSUUID UUID] UUIDString];
}

@end
