#import "CalorieRequirement.h"


@interface CalorieRequirement ()

// Private interface goes here.

@end


@implementation CalorieRequirement

+ (int) getRequirements:(int)forAge:(int)forActivityLevel
{
    NSLog(@"Hunting for age %d with activity level %d", forAge, forActivityLevel);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((startAge >= %d) AND (endAge <= %d)) AND (activityLevel = %d)", forAge, forActivityLevel];
    
    CalorieRequirement *row = [CalorieRequirement findFirstWithPredicate:predicate];

    return row.caloriesValue;
}

@end
