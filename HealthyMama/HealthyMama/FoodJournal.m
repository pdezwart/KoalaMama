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
    return [localContext executeFetchRequest:fetchRequest error:nil];
}


- (void) save {
    NSManagedObjectContext *localContext = [NSManagedObjectContext contextForCurrentThread];
    [localContext saveNestedContexts];
}

@end
