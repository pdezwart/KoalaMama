// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Mother.h instead.

#import <CoreData/CoreData.h>


extern const struct MotherAttributes {
	__unsafe_unretained NSString *dateOfBirth;
	__unsafe_unretained NSString *estimatedDueDate;
	__unsafe_unretained NSString *expectingTwins;
	__unsafe_unretained NSString *imperialHeight;
	__unsafe_unretained NSString *imperialPrePregnancyWeight;
	__unsafe_unretained NSString *measurementSystem;
	__unsafe_unretained NSString *metricHeight;
	__unsafe_unretained NSString *metricPrePregnancyWeight;
} MotherAttributes;

extern const struct MotherRelationships {
	__unsafe_unretained NSString *weighIns;
} MotherRelationships;

extern const struct MotherFetchedProperties {
} MotherFetchedProperties;

@class WeighIn;










@interface MotherID : NSManagedObjectID {}
@end

@interface _Mother : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MotherID*)objectID;





@property (nonatomic, strong) NSDate* dateOfBirth;



//- (BOOL)validateDateOfBirth:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* estimatedDueDate;



//- (BOOL)validateEstimatedDueDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* expectingTwins;



@property BOOL expectingTwinsValue;
- (BOOL)expectingTwinsValue;
- (void)setExpectingTwinsValue:(BOOL)value_;

//- (BOOL)validateExpectingTwins:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* imperialHeight;



@property int16_t imperialHeightValue;
- (int16_t)imperialHeightValue;
- (void)setImperialHeightValue:(int16_t)value_;

//- (BOOL)validateImperialHeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* imperialPrePregnancyWeight;



@property int16_t imperialPrePregnancyWeightValue;
- (int16_t)imperialPrePregnancyWeightValue;
- (void)setImperialPrePregnancyWeightValue:(int16_t)value_;

//- (BOOL)validateImperialPrePregnancyWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* measurementSystem;



//- (BOOL)validateMeasurementSystem:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* metricHeight;



@property int16_t metricHeightValue;
- (int16_t)metricHeightValue;
- (void)setMetricHeightValue:(int16_t)value_;

//- (BOOL)validateMetricHeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* metricPrePregnancyWeight;



@property int16_t metricPrePregnancyWeightValue;
- (int16_t)metricPrePregnancyWeightValue;
- (void)setMetricPrePregnancyWeightValue:(int16_t)value_;

//- (BOOL)validateMetricPrePregnancyWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *weighIns;

- (NSMutableSet*)weighInsSet;





@end

@interface _Mother (CoreDataGeneratedAccessors)

- (void)addWeighIns:(NSSet*)value_;
- (void)removeWeighIns:(NSSet*)value_;
- (void)addWeighInsObject:(WeighIn*)value_;
- (void)removeWeighInsObject:(WeighIn*)value_;

@end

@interface _Mother (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDateOfBirth;
- (void)setPrimitiveDateOfBirth:(NSDate*)value;




- (NSDate*)primitiveEstimatedDueDate;
- (void)setPrimitiveEstimatedDueDate:(NSDate*)value;




- (NSNumber*)primitiveExpectingTwins;
- (void)setPrimitiveExpectingTwins:(NSNumber*)value;

- (BOOL)primitiveExpectingTwinsValue;
- (void)setPrimitiveExpectingTwinsValue:(BOOL)value_;




- (NSNumber*)primitiveImperialHeight;
- (void)setPrimitiveImperialHeight:(NSNumber*)value;

- (int16_t)primitiveImperialHeightValue;
- (void)setPrimitiveImperialHeightValue:(int16_t)value_;




- (NSNumber*)primitiveImperialPrePregnancyWeight;
- (void)setPrimitiveImperialPrePregnancyWeight:(NSNumber*)value;

- (int16_t)primitiveImperialPrePregnancyWeightValue;
- (void)setPrimitiveImperialPrePregnancyWeightValue:(int16_t)value_;




- (NSString*)primitiveMeasurementSystem;
- (void)setPrimitiveMeasurementSystem:(NSString*)value;




- (NSNumber*)primitiveMetricHeight;
- (void)setPrimitiveMetricHeight:(NSNumber*)value;

- (int16_t)primitiveMetricHeightValue;
- (void)setPrimitiveMetricHeightValue:(int16_t)value_;




- (NSNumber*)primitiveMetricPrePregnancyWeight;
- (void)setPrimitiveMetricPrePregnancyWeight:(NSNumber*)value;

- (int16_t)primitiveMetricPrePregnancyWeightValue;
- (void)setPrimitiveMetricPrePregnancyWeightValue:(int16_t)value_;





- (NSMutableSet*)primitiveWeighIns;
- (void)setPrimitiveWeighIns:(NSMutableSet*)value;


@end
