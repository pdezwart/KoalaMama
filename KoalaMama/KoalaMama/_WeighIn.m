// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WeighIn.m instead.

#import "_WeighIn.h"

const struct WeighInAttributes WeighInAttributes = {
	.imperialWeight = @"imperialWeight",
	.metricWeight = @"metricWeight",
	.time = @"time",
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
	
	if ([key isEqualToString:@"imperialWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imperialWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"metricWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"metricWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic imperialWeight;



- (int16_t)imperialWeightValue {
	NSNumber *result = [self imperialWeight];
	return [result shortValue];
}

- (void)setImperialWeightValue:(int16_t)value_ {
	[self setImperialWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveImperialWeightValue {
	NSNumber *result = [self primitiveImperialWeight];
	return [result shortValue];
}

- (void)setPrimitiveImperialWeightValue:(int16_t)value_ {
	[self setPrimitiveImperialWeight:[NSNumber numberWithShort:value_]];
}





@dynamic metricWeight;



- (int16_t)metricWeightValue {
	NSNumber *result = [self metricWeight];
	return [result shortValue];
}

- (void)setMetricWeightValue:(int16_t)value_ {
	[self setMetricWeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMetricWeightValue {
	NSNumber *result = [self primitiveMetricWeight];
	return [result shortValue];
}

- (void)setPrimitiveMetricWeightValue:(int16_t)value_ {
	[self setPrimitiveMetricWeight:[NSNumber numberWithShort:value_]];
}





@dynamic time;






@dynamic mother;

	






@end
