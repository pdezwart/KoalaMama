#import "FoodJournal.h"


@interface FoodJournal ()

// Private interface goes here.

@end


@implementation FoodJournal

+(FoodJournal *) factory {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    return [FoodJournal createInContext:localContext];
}

+ (NSArray *)getJournal {
    return [FoodJournal getJournal:NO];
    
}

+ (NSArray *)getJournal:(BOOL)ascending {
    return [FoodJournal findAllSortedBy:@"time" ascending:ascending];
}


+ (NSString *)getJournalAsJson {
    NSArray *allEvents = [self getJournal:YES];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    
    // We need to group everything by date and add it up. First, lets group by date:
    NSMutableDictionary *eventsByDate = [NSMutableDictionary dictionary];
    for (FoodJournal *event in allEvents) {
        NSDate *key = [event getDate];
        
        NSMutableArray *eventsOfDay = [eventsByDate objectForKey:key];
        if (eventsOfDay == nil) {
            eventsOfDay = [NSMutableArray array];
            
            [eventsByDate setObject:eventsOfDay forKey:key];
        }
        
        [eventsOfDay addObject:event];
    }
    
    NSArray *unsortedDays = [eventsByDate allKeys];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(compare:)];
    NSArray *sortedDays = [unsortedDays sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    for (NSDate *day in sortedDays) {
        
        int dailyCalories = 0;
        for (FoodJournal *event in [eventsByDate objectForKey:day]) {
            dailyCalories += [event.calories integerValue];
        }
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:day];
        
        [dataPoints addObject:[NSString stringWithFormat:@"[Date.UTC(%d, %d, %d), %@]", [components year], [components month], [components day], [NSNumber numberWithInt:dailyCalories]]];
    }
    
    NSLog(@"%@", [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]]);
    return [NSString stringWithFormat:@"[%@]", [dataPoints componentsJoinedByString:@","]];
}


+(NSNumber *) getMostRecentCaloriesOfFood:(NSString *) foodName {
    
    NSPredicate *labelMatch = [NSPredicate predicateWithFormat:@"label = %@", foodName];
    FoodJournal *mostRecentByLabel = [FoodJournal findFirstWithPredicate:labelMatch sortedBy:@"time" ascending:FALSE];
    
    return mostRecentByLabel.calories;
}

+(NSArray *) getDistinctFoodNames {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"FoodJournal"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FoodJournal" inManagedObjectContext:localContext];
    
    // Required! Unless you set the resultType to NSDictionaryResultType, distinct can't work.
    // All objects in the backing store are implicitly distinct, but two dictionaries can be duplicates.
    // Since you only want distinct names, only ask for the 'name' property.
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"label"]];
    fetchRequest.returnsDistinctResults = YES;
    
    // Now it should yield an NSArray of distinct values in dictionaries.
    NSArray *data = [localContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    for (NSObject *obj in data) {
        [response addObject:[obj valueForKey:@"label"]];
    }
    
    // Convert from mutable to immutable array
    return [[NSArray alloc] initWithArray:response];
}


- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

- (NSDate *)getDate {
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.time];
    
    return [[calendar dateFromComponents:components] dateByAddingTimeInterval:[[NSTimeZone localTimeZone]secondsFromGMT]];
}

@end
