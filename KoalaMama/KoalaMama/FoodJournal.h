#import "_FoodJournal.h"

@interface FoodJournal : _FoodJournal {}

+ (FoodJournal *) factory;
+ (NSArray *) getJournal;
+ (NSArray *) getJournal:(BOOL)ascending;
+ (NSString *)getJournalAsJson;
+ (NSNumber *) getMostRecentCaloriesOfFood:(NSString *) foodName;
+ (NSArray *) getDistinctFoodNames;
+ (NSNumber *) getCalorieIntake;

- (void) save;
- (NSDate *)getDate;

@end
