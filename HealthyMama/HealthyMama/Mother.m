#import "Mother.h"


@interface Mother ()

// Private interface goes here.

@end


@implementation Mother

+ (Mother *)getMother {
    Mother *mother = [Mother findFirst];
    
    // Check that there is at least one:
    if (mother == nil) {
        NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
        mother = [Mother createInContext:localContext];
        mother.prePregnancyWeight = [NSNumber numberWithInt:120];
        mother.height = [NSNumber numberWithInt:64];
        
        // Figure out when is 9 months from now
        int weekInSeconds = 60 * 60 * 24 * 7;
        // We want to go 40 weeks forward, but most people dont find out till 3 weeks since last period:
        NSTimeInterval nineMonths = weekInSeconds * 40 - weekInSeconds - 3;
        mother.estimatedDueDate = [NSDate dateWithTimeIntervalSinceNow:nineMonths];
    }
    return mother;
}

- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

- (NSString * )timeLeftInPregnancy {
    
    Mother *mother = [Mother getMother];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSWeekCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0] toDate:mother.estimatedDueDate options:0];
    
    NSInteger weeks = [components week];
    NSInteger days = [components day];
    
    NSString *ret = @"";
    if (weeks > 0) {
        ret = [ret stringByAppendingFormat:@"%d weeks and ", weeks];
    }
    ret = [[ret stringByAppendingFormat:@"%d", days] stringByAppendingString:@" days"];
    
    return ret;
}


@end
