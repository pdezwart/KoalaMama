// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CalorieRequirement.h instead.

#import <CoreData/CoreData.h>


extern const struct CalorieRequirementAttributes {
	__unsafe_unretained NSString *activityLevel;
	__unsafe_unretained NSString *calories;
	__unsafe_unretained NSString *endAge;
	__unsafe_unretained NSString *startAge;
} CalorieRequirementAttributes;

extern const struct CalorieRequirementRelationships {
} CalorieRequirementRelationships;

extern const struct CalorieRequirementFetchedProperties {
} CalorieRequirementFetchedProperties;







@interface CalorieRequirementID : NSManagedObjectID {}
@end

@interface _CalorieRequirement : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CalorieRequirementID*)objectID;





@property (nonatomic, strong) NSNumber* activityLevel;



@property int16_t activityLevelValue;
- (int16_t)activityLevelValue;
- (void)setActivityLevelValue:(int16_t)value_;

//- (BOOL)validateActivityLevel:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* calories;



@property int16_t caloriesValue;
- (int16_t)caloriesValue;
- (void)setCaloriesValue:(int16_t)value_;

//- (BOOL)validateCalories:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* endAge;



@property int16_t endAgeValue;
- (int16_t)endAgeValue;
- (void)setEndAgeValue:(int16_t)value_;

//- (BOOL)validateEndAge:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* startAge;



@property int16_t startAgeValue;
- (int16_t)startAgeValue;
- (void)setStartAgeValue:(int16_t)value_;

//- (BOOL)validateStartAge:(id*)value_ error:(NSError**)error_;






@end

@interface _CalorieRequirement (CoreDataGeneratedAccessors)

@end

@interface _CalorieRequirement (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActivityLevel;
- (void)setPrimitiveActivityLevel:(NSNumber*)value;

- (int16_t)primitiveActivityLevelValue;
- (void)setPrimitiveActivityLevelValue:(int16_t)value_;




- (NSNumber*)primitiveCalories;
- (void)setPrimitiveCalories:(NSNumber*)value;

- (int16_t)primitiveCaloriesValue;
- (void)setPrimitiveCaloriesValue:(int16_t)value_;




- (NSNumber*)primitiveEndAge;
- (void)setPrimitiveEndAge:(NSNumber*)value;

- (int16_t)primitiveEndAgeValue;
- (void)setPrimitiveEndAgeValue:(int16_t)value_;




- (NSNumber*)primitiveStartAge;
- (void)setPrimitiveStartAge:(NSNumber*)value;

- (int16_t)primitiveStartAgeValue;
- (void)setPrimitiveStartAgeValue:(int16_t)value_;




@end
