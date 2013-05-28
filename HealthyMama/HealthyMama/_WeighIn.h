// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WeighIn.h instead.

#import <CoreData/CoreData.h>


extern const struct WeighInAttributes {
	__unsafe_unretained NSString *time;
	__unsafe_unretained NSString *weight;
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





@property (nonatomic, strong) NSDate* time;



//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* weight;



@property int16_t weightValue;
- (int16_t)weightValue;
- (void)setWeightValue:(int16_t)value_;

//- (BOOL)validateWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Mother *mother;

//- (BOOL)validateMother:(id*)value_ error:(NSError**)error_;





@end

@interface _WeighIn (CoreDataGeneratedAccessors)

@end

@interface _WeighIn (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveTime;
- (void)setPrimitiveTime:(NSDate*)value;




- (NSNumber*)primitiveWeight;
- (void)setPrimitiveWeight:(NSNumber*)value;

- (int16_t)primitiveWeightValue;
- (void)setPrimitiveWeightValue:(int16_t)value_;





- (Mother*)primitiveMother;
- (void)setPrimitiveMother:(Mother*)value;


@end
