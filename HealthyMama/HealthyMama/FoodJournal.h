#import "_FoodJournal.h"

@interface FoodJournal : _FoodJournal {}

+ (FoodJournal *) factory;
+ (NSArray *) getJournal;
+ (NSString *) getMinCalorieIntake;
+ (NSString *) getMaxCalorieIntake;
+ (NSArray *) getJournal:(BOOL)ascending;
+ (NSString *)getJournalAsJson;
+ (NSNumber *) getMostRecentCaloriesOfFood:(NSString *) foodName;
+ (NSArray *) getDistinctFoodNames;
+ (NSNumber *) getCalorieIntake;

- (void) save;
- (NSDate *)getDate;

@end
