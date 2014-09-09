#import "CalorieRequirement.h"


@interface CalorieRequirement ()

// Private interface goes here.

@end


@implementation CalorieRequirement

+ (int) getRequirementsForAge:(int)age forActivityLevel:(int)activityLevel forWeeksIntoPregnancy:(int)weeksIntoPregnancy;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startAge <= %d AND endAge >= %d AND activityLevel = %d", age, age, activityLevel];
    
    CalorieRequirement *row = [CalorieRequirement findFirstWithPredicate:predicate];

    // Figure out additional calories required
    // Read the plist into a NSDict
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CaloriesPerWeek" ofType:@"plist"];
    NSMutableDictionary *caloriesPerWeek = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    // Figure out the calories for this week
    NSNumber *num = [caloriesPerWeek objectForKey:[NSString stringWithFormat:@"%d", weeksIntoPregnancy]];
    int extraCalories = [num intValue];

    return row.caloriesValue + extraCalories;
}

@end
