// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WeighIn.h instead.

#import <CoreData/CoreData.h>


extern const struct WeighInAttributes {
	__unsafe_unretained NSString *imperialWeight;
	__unsafe_unretained NSString *metricWeight;
	__unsafe_unretained NSString *time;
} WeighInAttributes;

extern const struct WeighInRelationships {
	__unsafe_unretained NSString *mother;
} WeighInRelationships;

extern const struct WeighInFetchedProperties {
} WeighInFetchedProperties;

@class Mother;





@interface WeighInID : NSManagedObjectID {}
@end

@interface _WeighIn : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (WeighInID*)objectID;





@property (nonatomic, strong) NSNumber* imperialWeight;



@property int16_t imperialWeightValue;
- (int16_t)imperialWeightValue;
- (void)setImperialWeightValue:(int16_t)value_;

//- (BOOL)validateImperialWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* metricWeight;



@property int16_t metricWeightValue;
- (int16_t)metricWeightValue;
- (void)setMetricWeightValue:(int16_t)value_;

//- (BOOL)validateMetricWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* time;



//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Mother *mother;

//- (BOOL)validateMother:(id*)value_ error:(NSError**)error_;





@end

@interface _WeighIn (CoreDataGeneratedAccessors)

@end

@interface _WeighIn (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveImperialWeight;
- (void)setPrimitiveImperialWeight:(NSNumber*)value;

- (int16_t)primitiveImperialWeightValue;
- (void)setPrimitiveImperialWeightValue:(int16_t)value_;




- (NSNumber*)primitiveMetricWeight;
- (void)setPrimitiveMetricWeight:(NSNumber*)value;

- (int16_t)primitiveMetricWeightValue;
- (void)setPrimitiveMetricWeightValue:(int16_t)value_;




- (NSDate*)primitiveTime;
- (void)setPrimitiveTime:(NSDate*)value;





- (Mother*)primitiveMother;
- (void)setPrimitiveMother:(Mother*)value;


@end
