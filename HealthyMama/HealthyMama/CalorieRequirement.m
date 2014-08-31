#import "CalorieRequirement.h"
#import "FoodJournal.h"
#import "Mother.h"


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


+ (NSString *)getRecommendedCalorieIntake {
    NSArray *journal = [FoodJournal getJournal:YES];
    
    if ([journal count] <= 0) {
        return @"[]";
    }
    
    // Fill in all of the days between the first and last day with the expected minimum calories
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay: 1];
    
    FoodJournal *startEvent = [journal objectAtIndex:0];
    FoodJournal *endEvent = [journal objectAtIndex:[journal count] - 1];
    
    NSDate *startDate = [startEvent getDate];
    NSDate *endDate = [endEvent getDate];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    int caloriesForDate = 0;
    Mother *mother = [Mother getMother];
    int age = [[mother getAge] intValue];
    int activityLevel = 2;
    
    
    for (NSDate *date = [startDate copy]; [date compare: endDate] <= 0; date = [calendar dateByAddingComponents:oneDay toDate:date options:0]) {

        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        
        caloriesForDate = [self getRequirementsForAge:age forActivityLevel:activityLevel forWeeksIntoPregnancy:[mother weeksIntoPregnancyForDate:date]];
        
        [dataPoints addObject:[NSString stringWithFormat:@"{x: Date.UTC(%ld, %d, %d), y: %d, marker:{enabled:false}}", (long)[components year], [components month] - 1, [components day], caloriesForDate]];
    }
        
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}

@end
