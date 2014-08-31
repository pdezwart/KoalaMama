#import "_Mother.h"

// Based on popular 40 week pregnancy from last period, not actual conception.
#define PREGNANCY_IN_DAYS       280

@interface Mother : _Mother {}

+ (NSNumber *)convertWeightToKilos:(NSNumber *)weight;
+ (NSNumber *)convertHeightToCentimeters:(NSNumber *)height;
+ (NSNumber *)convertWeightToPounds:(NSNumber *)weight;
+ (NSNumber *)convertHeightToInches:(NSNumber *)height;


+ (Mother *)getMother;
- (void)save;
- (int)weeksIntoPregnancy;
- (int)weeksIntoPregnancyForDate:(NSDate *)date;
- (int)daysIntoPregnancyForDate:(NSDate *)date;
- (NSString * )timeLeftInPregnancy;
- (BOOL)isMetric;
- (void)makeMetric;
- (void)makeImperial;
- (NSNumber *)getAge;
- (int)getWeightGain;
- (double)getBMI;

@end
