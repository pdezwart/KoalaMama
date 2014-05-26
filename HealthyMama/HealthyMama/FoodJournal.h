#import "_FoodJournal.h"

@interface FoodJournal : _FoodJournal {}

+(FoodJournal *) factory;
+(NSArray *) getJournal;
+(NSArray *) getJournal:(BOOL)ascending;
+(NSNumber *) getMostRecentCaloriesOfFood:(NSString *) foodName;
+(NSArray *) getDistinctFoodNames;

-(void) save;

@end
