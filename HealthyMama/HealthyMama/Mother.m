#import "Mother.h"
#import "WeighIn.h"


@interface Mother ()

// Private interface goes here.

@end


@implementation Mother

#define CM_TO_IN                2.5
#define KG_TO_LBS               0.45

#define DEFAULT_HEIGHT_IN       64
#define DEFAULT_WEIGHT_LBS      120
#define DEFAULT_AGE             25
#define DEFAULT_ACTIVITY_LEVEL  1.5

#define METRIC                  @"metric"
#define IMPERIAL                @"imperial"

#define YEAR_IN_SECONDS         31536000

// Based on popular 40 week pregnancy from last period, not actual conception.
#define PREGNANCY_IN_DAYS       280

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
        NSTimeInterval defaultAge = -1 * YEAR_IN_SECONDS * DEFAULT_AGE;
        mother.dateOfBirth = [NSDate dateWithTimeIntervalSinceNow:defaultAge];
    }
    return mother;
}

- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

- (int)weeksIntoPregnancy {
    // Figure out conception date based on popular 40 week (280 days) pregnancy:
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ) fromDate:self.estimatedDueDate];
    
    // Create midnight of the date
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    [components setYear:0];
    [components setMonth:0];
    [components setDay:-PREGNANCY_IN_DAYS];
    
    NSDate *startOfPregnancy = [calendar dateByAddingComponents:components toDate:self.estimatedDueDate options:0];
    
    // Now figure out how many weeks have passed since then:
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSWeekCalendarUnit;
    
    components = [gregorian components:unitFlags fromDate:startOfPregnancy toDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0] options:0];
    
    NSInteger weeks = [components week];
    
    return (int)weeks;
}

- (NSString * )timeLeftInPregnancy {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSWeekCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0] toDate:self.estimatedDueDate options:0];
    
    NSInteger weeks = [components week];
    NSInteger days = [components day];
    
    NSString *ret = @"";
    if (weeks > 0) {
        ret = [ret stringByAppendingFormat:@"%ld weeks and ", (long)weeks];
    }
    ret = [[ret stringByAppendingFormat:@"%ld", (long)days] stringByAppendingString:@" days"];
    
    return ret;
}

- (BOOL) isMetric {
    return [self.measurementSystem isEqualToString:METRIC] ? YES : NO;
}

- (void) makeMetric {
    self.measurementSystem = METRIC;
}
- (void) makeImperial {
    self.measurementSystem = IMPERIAL;
}

- (NSNumber *) age {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSYearCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:self.dateOfBirth toDate:self.estimatedDueDate options:0];
    
    return [NSNumber numberWithInteger:[components year]];
}

- (void) generateHighWeightGraphPoints {
    /*
    double hbValue = 655.1
    + (9.563 * [self.metricPrePregnancyWeight doubleValue])
    + (1.850 * [self.metricHeight doubleValue])
    - (4.676 * [[self age] doubleValue]);
    
    hbValue *= DEFAULT_ACTIVITY_LEVEL;
    
    NSArray *caloriesPerWeek;
    */
}

- (int) getWeightGain
{
    WeighIn* last = [WeighIn findFirstOrderedByAttribute:@"time" ascending:NO];
    
    if (last.imperialWeightValue == 0) {
        return 0;
    }
    
    return last.imperialWeightValue - self.imperialPrePregnancyWeightValue;
}



@end
