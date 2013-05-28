// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Mother.h instead.

#import <CoreData/CoreData.h>


extern const struct MotherAttributes {
	__unsafe_unretained NSString *estimatedDueDate;
	__unsafe_unretained NSString *height;
	__unsafe_unretained NSString *prePregnancyWeight;
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





@property (nonatomic, strong) NSDate* estimatedDueDate;



//- (BOOL)validateEstimatedDueDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* height;



@property int16_t heightValue;
- (int16_t)heightValue;
- (void)setHeightValue:(int16_t)value_;

//- (BOOL)validateHeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* prePregnancyWeight;



@property int16_t prePregnancyWeightValue;
- (int16_t)prePregnancyWeightValue;
- (void)setPrePregnancyWeightValue:(int16_t)value_;

//- (BOOL)validatePrePregnancyWeight:(id*)value_ error:(NSError**)error_;





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


- (NSDate*)primitiveEstimatedDueDate;
- (void)setPrimitiveEstimatedDueDate:(NSDate*)value;




- (NSNumber*)primitiveHeight;
- (void)setPrimitiveHeight:(NSNumber*)value;

- (int16_t)primitiveHeightValue;
- (void)setPrimitiveHeightValue:(int16_t)value_;




- (NSNumber*)primitivePrePregnancyWeight;
- (void)setPrimitivePrePregnancyWeight:(NSNumber*)value;

- (int16_t)primitivePrePregnancyWeightValue;
- (void)setPrimitivePrePregnancyWeightValue:(int16_t)value_;





- (NSMutableSet*)primitiveWeighIns;
- (void)setPrimitiveWeighIns:(NSMutableSet*)value;


@end
