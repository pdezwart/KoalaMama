// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodJournal.m instead.

#import "_FoodJournal.h"

const struct FoodJournalAttributes FoodJournalAttributes = {
	.calories = @"calories",
	.label = @"label",
	.time = @"time",
};

const struct FoodJournalRelationships FoodJournalRelationships = {
};

const struct FoodJournalFetchedProperties FoodJournalFetchedProperties = {
};

@implementation FoodJournalID
@end

@implementation _FoodJournal

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FoodJournal" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FoodJournal";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FoodJournal" inManagedObjectContext:moc_];
}

- (FoodJournalID*)objectID {
	return (FoodJournalID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"caloriesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calories"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic calories;



- (int16_t)caloriesValue {
	NSNumber *result = [self calories];
	return [result shortValue];
}

- (void)setCaloriesValue:(int16_t)value_ {
	[self setCalories:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCaloriesValue {
	NSNumber *result = [self primitiveCalories];
	return [result shortValue];
}

- (void)setPrimitiveCaloriesValue:(int16_t)value_ {
	[self setPrimitiveCalories:[NSNumber numberWithShort:value_]];
}





@dynamic label;






@dynamic time;











@end
