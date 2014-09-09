// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Mother.m instead.

#import "_Mother.h"

const struct MotherAttributes MotherAttributes = {
	.dateOfBirth = @"dateOfBirth",
	.estimatedDueDate = @"estimatedDueDate",
	.expectingTwins = @"expectingTwins",
	.imperialHeight = @"imperialHeight",
	.imperialPrePregnancyWeight = @"imperialPrePregnancyWeight",
	.measurementSystem = @"measurementSystem",
	.metricHeight = @"metricHeight",
	.metricPrePregnancyWeight = @"metricPrePregnancyWeight",
};

const struct MotherRelationships MotherRelationships = {
	.weighIns = @"weighIns",
};

const struct MotherFetchedProperties MotherFetchedProperties = {
};

@implementation MotherID
@end

@implementation _Mother

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Mother" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Mother";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Mother" inManagedObjectContext:moc_];
}

- (MotherID*)objectID {
	return (MotherID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"expectingTwinsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"expectingTwins"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"imperialHeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imperialHeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"imperialPrePregnancyWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imperialPrePregnancyWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"metricHeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"metricHeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"metricPrePregnancyWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"metricPrePregnancyWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic dateOfBirth;






@dynamic estimatedDueDate;






@dynamic expectingTwins;



- (BOOL)expectingTwinsValue {
	NSNumber *result = [self expectingTwins];
	return [result boolValue];
}

- (void)setExpectingTwinsValue:(BOOL)value_ {
	[self setExpectingTwins:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveExpectingTwinsValue {
	NSNumber *result = [self primitiveExpectingTwins];
	return [result boolValue];
}

- (void)setPrimitiveExpectingTwinsValue:(BOOL)value_ {
	[self setPrimitiveExpectingTwins:[NSNumber numberWithBool:value_]];
}





@dynamic imperialHeight;



- (int16_t)imperialHeightValue {
	NSNumber *result = [self imperialHeight];
	return [result shortValue];
}

- (void)setImperialHeightValue:(int16_t)value_ {
	[self setImperialHeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveImperialHeightValue {
	NSNumber *result = [self primitiveImperialHeight];
	return [result shortValue];
}

- (void)setPrimitiveImperialHeightValue:(int16_t)value_ {
	[self setPrimitiveImperialHeight:[NSNumber numberWithShort:value_]];
}





@dynamic imperialPrePregnancyWeight;



- (int16_t)imperialPrePregnancyWeightValue {
	NSNumber *result = [self imperialPrePregnancyWeight];
	return [result shortValue];
}

- (void)setImperialPrePregnancyWeightValue:(int16_t)value_ {
	[self setImperialPrePregnancyWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveImperialPrePregnancyWeightValue {
	NSNumber *result = [self primitiveImperialPrePregnancyWeight];
	return [result shortValue];
}

- (void)setPrimitiveImperialPrePregnancyWeightValue:(int16_t)value_ {
	[self setPrimitiveImperialPrePregnancyWeight:[NSNumber numberWithShort:value_]];
}





@dynamic measurementSystem;






@dynamic metricHeight;



- (int16_t)metricHeightValue {
	NSNumber *result = [self metricHeight];
	return [result shortValue];
}

- (void)setMetricHeightValue:(int16_t)value_ {
	[self setMetricHeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMetricHeightValue {
	NSNumber *result = [self primitiveMetricHeight];
	return [result shortValue];
}

- (void)setPrimitiveMetricHeightValue:(int16_t)value_ {
	[self setPrimitiveMetricHeight:[NSNumber numberWithShort:value_]];
}





@dynamic metricPrePregnancyWeight;



- (int16_t)metricPrePregnancyWeightValue {
	NSNumber *result = [self metricPrePregnancyWeight];
	return [result shortValue];
}

- (void)setMetricPrePregnancyWeightValue:(int16_t)value_ {
	[self setMetricPrePregnancyWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMetricPrePregnancyWeightValue {
	NSNumber *result = [self primitiveMetricPrePregnancyWeight];
	return [result shortValue];
}

- (void)setPrimitiveMetricPrePregnancyWeightValue:(int16_t)value_ {
	[self setPrimitiveMetricPrePregnancyWeight:[NSNumber numberWithShort:value_]];
}





@dynamic weighIns;

	
- (NSMutableSet*)weighInsSet {
	[self willAccessValueForKey:@"weighIns"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"weighIns"];
  
	[self didAccessValueForKey:@"weighIns"];
	return result;
}
	






@end
