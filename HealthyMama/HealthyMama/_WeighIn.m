// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WeighIn.m instead.

#import "_WeighIn.h"

const struct WeighInAttributes WeighInAttributes = {
	.time = @"time",
	.weight = @"weight",
};

const struct WeighInRelationships WeighInRelationships = {
	.mother = @"mother",
};

const struct WeighInFetchedProperties WeighInFetchedProperties = {
};

@implementation WeighInID
@end

@implementation _WeighIn

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WeighIn" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WeighIn";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WeighIn" inManagedObjectContext:moc_];
}

- (WeighInID*)objectID {
	return (WeighInID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"weightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"weight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic time;






@dynamic weight;



- (int16_t)weightValue {
	NSNumber *result = [self weight];
	return [result shortValue];
}

- (void)setWeightValue:(int16_t)value_ {
	[self setWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveWeightValue {
	NSNumber *result = [self primitiveWeight];
	return [result shortValue];
}

- (void)setPrimitiveWeightValue:(int16_t)value_ {
	[self setPrimitiveWeight:[NSNumber numberWithShort:value_]];
}





@dynamic mother;

	






@end
