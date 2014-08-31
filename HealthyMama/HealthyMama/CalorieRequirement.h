#import "_CalorieRequirement.h"

@interface CalorieRequirement : _CalorieRequirement {}


+ (int) getRequirementsForAge:(int)age forActivityLevel:(int)activityLevel forWeeksIntoPregnancy:(int)weeksIntoPregnancy;

+ (NSString *) getRecommendedCalorieIntake;

@end
