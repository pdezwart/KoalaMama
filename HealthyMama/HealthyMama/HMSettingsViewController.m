//
//  HMSettingsViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMSettingsViewController.h"
#import "Mother.h"

@interface HMSettingsViewController ()

@end

@implementation HMSettingsViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 3;
    } else {
        return 12;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%d ft", row + 4];
    } else {
        return [NSString stringWithFormat:@"%d in", row];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    Mother *mother = [Mother getMother];
    
    // Load mom's info:
    self.prePregnancyWeightField.text = [NSString stringWithFormat:@"%@", mother.prePregnancyWeight];
    
    // Break down height and weight into its components:
    int height = [mother.height intValue];
    NSInteger heightInches = height % 12;
    NSInteger heightFeet = (height - (heightInches)) / 12;
    
    // Load them into the UI
    [self.heightPicker selectRow:(heightFeet - 4) inComponent:0 animated:NO];
    [self.heightPicker selectRow:(heightInches) inComponent:1 animated:NO];
    
    // Load the date into the UI
    [self.estimatedDueDatePicker setDate:mother.estimatedDueDate animated:NO];
    
    [self.expectingTwinsSwitch setOn:NO];
    
    // Hook up the back button
    self.navigationItem.hidesBackButton = YES; // Important
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
       style:UIBarButtonItemStyleBordered
       target:self
       action:@selector(myCustomBack)];

}

- (void) viewDidDisappear:(BOOL)animated {
    Mother *mother = [Mother getMother];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    mother.prePregnancyWeight = [f numberFromString:[self.prePregnancyWeightField text]];
    
    // Save the estimated due date:
    mother.estimatedDueDate = [self.estimatedDueDatePicker date];
    
    // Save the person's height:
    mother.height = [NSNumber numberWithInt:(([self.heightPicker selectedRowInComponent:0] + 4) * 12 + [self.heightPicker selectedRowInComponent:1])];
    NSLog(@"Saving mother... %@", mother);
    
    // Call save
    [mother save];
}

- (IBAction)closeModalWindow:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
