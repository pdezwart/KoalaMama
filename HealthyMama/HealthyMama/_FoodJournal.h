// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodJournal.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodJournalAttributes {
	__unsafe_unretained NSString *calories;
	__unsafe_unretained NSString *label;
	__unsafe_unretained NSString *time;
} FoodJournalAttributes;

extern const struct FoodJournalRelationships {
} FoodJournalRelationships;

extern const struct FoodJournalFetchedProperties {
} FoodJournalFetchedProperties;






@interface FoodJournalID : NSManagedObjectID {}
@end

@interface _FoodJournal : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodJournalID*)objectID;





@property (nonatomic, strong) NSNumber* calories;



@property int16_t caloriesValue;
- (int16_t)caloriesValue;
- (void)setCaloriesValue:(int16_t)value_;

//- (BOOL)validateCalories:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* label;



//- (BOOL)validateLabel:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* time;



//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;






@end

@interface _FoodJournal (CoreDataGeneratedAccessors)

@end

@interface _FoodJournal (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCalories;
- (void)setPrimitiveCalories:(NSNumber*)value;

- (int16_t)primitiveCaloriesValue;
- (void)setPrimitiveCaloriesValue:(int16_t)value_;




- (NSString*)primitiveLabel;
- (void)setPrimitiveLabel:(NSString*)value;




- (NSDate*)primitiveTime;
- (void)setPrimitiveTime:(NSDate*)value;




@end
