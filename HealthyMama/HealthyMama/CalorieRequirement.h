#import "_CalorieRequirement.h"

@interface CalorieRequirement : _CalorieRequirement {}

// + (void) saveWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion;

+ (int) getRequirementsForAge:(int)age forActivityLevel:(int)activityLevel forWeeksIntoPregnancy:(int)weeksIntoPregnancy;

@end
