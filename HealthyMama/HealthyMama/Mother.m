#import "Mother.h"


@interface Mother ()

// Private interface goes here.

@end


@implementation Mother

#define CM_TO_IN            2.5
#define KG_TO_LBS           0.45

#define DEFAULT_HEIGHT_IN   64
#define DEFAULT_WEIGHT_LBS  120

#define DEFAULT_AGE         25

#define METRIC              @"metric"
#define IMPERIAL            @"imperial"

+ (NSNumber *)convertWeightToKilos:(NSNumber *)weight {
    return [NSNumber numberWithDouble:[weight doubleValue] * KG_TO_LBS];
}
+ (NSNumber *)convertHeightToCentimeters:(NSNumber *)height {
    return [NSNumber numberWithDouble:[height doubleValue] * CM_TO_IN];
}
+ (NSNumber *)convertWeightToPounds:(NSNumber *)weight {
    return [NSNumber numberWithDouble:[weight doubleValue] / KG_TO_LBS];
}
+ (NSNumber *)convertHeightToInches:(NSNumber *)height {
    return [NSNumber numberWithDouble:[height doubleValue] / CM_TO_IN];
}


+ (Mother *)getMother {
    Mother *mother = [Mother findFirst];
    
    // Check that there is at least one:
    if (mother == nil) {
        NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
        mother = [Mother createInContext:localContext];

        mother.imperialPrePregnancyWeight = [NSNumber numberWithInt:DEFAULT_WEIGHT_LBS];
        mother.imperialHeight = [NSNumber numberWithInt:DEFAULT_HEIGHT_IN];
        
        mother.metricHeight = [Mother convertHeightToCentimeters:mother.imperialHeight];
        mother.metricPrePregnancyWeight = [Mother convertWeightToKilos:mother.imperialPrePregnancyWeight];
        
        // Figure out when is 9 months from now
        int weekInSeconds = 60 * 60 * 24 * 7;
        // We want to go 40 weeks forward, but most people dont find out till 3 weeks since last period:
        NSTimeInterval nineMonths = weekInSeconds * 40 - weekInSeconds * 3;
        mother.estimatedDueDate = [NSDate dateWithTimeIntervalSinceNow:nineMonths];
        
        // Figure out when 25 years ago was:
        int yearsInSeconds = 60 * 60 * 24 * 365;
        NSTimeInterval defaultAge = -1 * yearsInSeconds * DEFAULT_AGE;
        mother.dateOfBirth = [NSDate dateWithTimeIntervalSinceNow:defaultAge];
    }
    return mother;
}

- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

- (NSString * )timeLeftInPregnancy {
        
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSWeekCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0] toDate:self.estimatedDueDate options:0];
    
    NSInteger weeks = [components week];
    NSInteger days = [components day];
    
    NSString *ret = @"";
    if (weeks > 0) {
        ret = [ret stringByAppendingFormat:@"%d weeks and ", weeks];
    }
    ret = [[ret stringByAppendingFormat:@"%d", days] stringByAppendingString:@" days"];
    
    return ret;
}

- (BOOL) isMetric {
    return self.measurementSystem == METRIC ? YES : NO;
}

- (void) makeMetric {
    self.measurementSystem = METRIC;
}
- (void) makeImperial {
    self.measurementSystem = IMPERIAL;
}

@end
