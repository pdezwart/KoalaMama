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


+ (void) getMotherWithContext:(NSManagedObjectContext *)context completion:(void (^)(Mother *mother))callback {
    static Mother *mother;
    
    // If we already have a copy of mother, return that.
    if (mother != nil) {
        callback(mother);
        return;
    }
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    NSURL *url = [NSURL fileURLWithPath:[documentPath stringByAppendingPathComponent:@"database.sql"]];
    
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [Mother documentIsReadyWithContext:context completion:callback];
            } else {
                NSLog(@"Could not open document at %@", url);
            }
        }];
    } else {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [Mother documentIsReadyWithContext:context completion:callback];
            } else {
                NSLog(@"Could not create document at %@", url);
            }
        }];
    }
    
    
    callback(mother);
    
    return;
}

+ (void) documentIsReadyWithContext:(NSManagedObjectContext *)context completion:(void(^)(Mother *mother))calback {
    NSEntityDescription *motherDesc = [NSEntityDescription entityForName:@"Mother" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:motherDesc];
    [request setFetchLimit:1];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
        NSLog(@"%s", "Something bad happened in core data");
    }
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
    
    [callback ];
}

@end
