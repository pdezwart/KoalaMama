// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Mother.m instead.

#import "_Mother.h"

const struct MotherAttributes MotherAttributes = {
	.estimatedDueDate = @"estimatedDueDate",
	.height = @"height",
	.prePregnancyWeight = @"prePregnancyWeight",
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
	
	if ([key isEqualToString:@"heightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"height"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"prePregnancyWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"prePregnancyWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic estimatedDueDate;






@dynamic height;



- (int16_t)heightValue {
	NSNumber *result = [self height];
	return [result shortValue];
}

- (void)setHeightValue:(int16_t)value_ {
	[self setHeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveHeightValue {
	NSNumber *result = [self primitiveHeight];
	return [result shortValue];
}

- (void)setPrimitiveHeightValue:(int16_t)value_ {
	[self setPrimitiveHeight:[NSNumber numberWithShort:value_]];
}





@dynamic prePregnancyWeight;



- (int16_t)prePregnancyWeightValue {
	NSNumber *result = [self prePregnancyWeight];
	return [result shortValue];
}

- (void)setPrePregnancyWeightValue:(int16_t)value_ {
	[self setPrePregnancyWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePrePregnancyWeightValue {
	NSNumber *result = [self primitivePrePregnancyWeight];
	return [result shortValue];
}

- (void)setPrimitivePrePregnancyWeightValue:(int16_t)value_ {
	[self setPrimitivePrePregnancyWeight:[NSNumber numberWithShort:value_]];
}





@dynamic weighIns;

	
- (NSMutableSet*)weighInsSet {
	[self willAccessValueForKey:@"weighIns"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"weighIns"];
  
	[self didAccessValueForKey:@"weighIns"];
	return result;
}
	






@end
