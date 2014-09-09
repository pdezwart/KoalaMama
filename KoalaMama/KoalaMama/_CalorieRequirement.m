// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CalorieRequirement.m instead.

#import "_CalorieRequirement.h"

const struct CalorieRequirementAttributes CalorieRequirementAttributes = {
	.activityLevel = @"activityLevel",
	.calories = @"calories",
	.endAge = @"endAge",
	.startAge = @"startAge",
};

const struct CalorieRequirementRelationships CalorieRequirementRelationships = {
};

const struct CalorieRequirementFetchedProperties CalorieRequirementFetchedProperties = {
};

@implementation CalorieRequirementID
@end

@implementation _CalorieRequirement

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CalorieRequirement" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CalorieRequirement";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CalorieRequirement" inManagedObjectContext:moc_];
}

- (CalorieRequirementID*)objectID {
	return (CalorieRequirementID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activityLevelValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activityLevel"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"caloriesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calories"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"endAgeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"endAge"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"startAgeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"startAge"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic activityLevel;



- (int16_t)activityLevelValue {
	NSNumber *result = [self activityLevel];
	return [result shortValue];
}

- (void)setActivityLevelValue:(int16_t)value_ {
	[self setActivityLevel:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveActivityLevelValue {
	NSNumber *result = [self primitiveActivityLevel];
	return [result shortValue];
}

- (void)setPrimitiveActivityLevelValue:(int16_t)value_ {
	[self setPrimitiveActivityLevel:[NSNumber numberWithShort:value_]];
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





@dynamic endAge;



- (int16_t)endAgeValue {
	NSNumber *result = [self endAge];
	return [result shortValue];
}

- (void)setEndAgeValue:(int16_t)value_ {
	[self setEndAge:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveEndAgeValue {
	NSNumber *result = [self primitiveEndAge];
	return [result shortValue];
}

- (void)setPrimitiveEndAgeValue:(int16_t)value_ {
	[self setPrimitiveEndAge:[NSNumber numberWithShort:value_]];
}





@dynamic startAge;



- (int16_t)startAgeValue {
	NSNumber *result = [self startAge];
	return [result shortValue];
}

- (void)setStartAgeValue:(int16_t)value_ {
	[self setStartAge:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveStartAgeValue {
	NSNumber *result = [self primitiveStartAge];
	return [result shortValue];
}

- (void)setPrimitiveStartAgeValue:(int16_t)value_ {
	[self setPrimitiveStartAge:[NSNumber numberWithShort:value_]];
}










@end
