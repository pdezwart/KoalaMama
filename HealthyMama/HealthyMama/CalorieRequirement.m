#import "CalorieRequirement.h"


@interface CalorieRequirement ()

// Private interface goes here.

@end


@implementation CalorieRequirement

+ (int) getRequirementsForAge:(int)age forActivityLevel:(int)activityLevel;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((startAge >= %d) AND (endAge <= %d)) AND (activityLevel = %d)", age, activityLevel];
    
    CalorieRequirement *row = [CalorieRequirement findFirstWithPredicate:predicate];

    return row.caloriesValue;
}

@end
