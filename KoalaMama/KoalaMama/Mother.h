#import "_Mother.h"

@interface Mother : _Mother {}

+ (NSNumber *)convertWeightToKilos:(NSNumber *)weight;
+ (NSNumber *)convertHeightToCentimeters:(NSNumber *)height;
+ (NSNumber *)convertWeightToPounds:(NSNumber *)weight;
+ (NSNumber *)convertHeightToInches:(NSNumber *)height;


+ (Mother *)getMother;
- (void) save;
- (int) weeksIntoPregnancy;
- (NSString * )timeLeftInPregnancy;
- (BOOL)isMetric;
- (void)makeMetric;
- (void)makeImperial;
- (NSNumber *) age;
- (int) getWeightGain;

@end
