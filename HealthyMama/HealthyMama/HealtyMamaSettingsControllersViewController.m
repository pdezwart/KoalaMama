//
//  HealtyMamaSettingsControllersViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/15/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HealtyMamaSettingsControllersViewController.h"

typedef void(^MotherLoadedCallback)(Mother* mother);


@interface HealtyMamaSettingsControllersViewController ()

    @property (nonatomic, copy) MotherLoadedCallback callback;

@end


@implementation HealtyMamaSettingsControllersViewController

@synthesize managedObjectContext;
@synthesize callback;

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

-(void) viewDidLoad {

    [super viewDidLoad];
    
        
	self.navigationItem.hidesBackButton = YES; // Important
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
        style:UIBarButtonItemStyleBordered
        target:self action:@selector(myCustomBack)];
   
}

- (void) loadMother {
    managedObjectContext = self.document.managedObjectContext;
    
    // Set the person's current weight:
    self.prePregnancyWeightField.text = [NSString stringWithFormat:@"%@", self.mother.prePregnancyWeight];
    
    // Break down height and weight into its components:
    int height = [self.mother.height intValue];
    NSInteger heightInches = height % 12;
    NSInteger heightFeet = (height - (heightInches)) / 12;
    
    // Load them into the UI
    [self.heightInFeetPicker selectRow:(heightFeet - 4) inComponent:0 animated:NO];
    [self.heightInFeetPicker selectRow:(heightInches) inComponent:1 animated:NO];
    
    // Load the date into the UI
    [self.estimatedDueDatePicker setDate:self.mother.expectedDueDate animated:NO];
    
    self.mother.height = [NSNumber numberWithInt:70];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // Save the pre-preganancy weight:
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    self.mother.prePregnancyWeight = [f numberFromString:[self.prePregnancyWeightField text]];
    
    // Save the estimated due date:
    self.mother.expectedDueDate = [self.estimatedDueDatePicker date];
    
    // Save the person's height:
    
    self.mother.height = [NSNumber numberWithInt:(([self.heightInFeetPicker selectedRowInComponent:0] + 4) * 12 + [self.heightInFeetPicker selectedRowInComponent:1])];
    NSLog(@"Saving mother... %@", self.mother);

    NSError *error = nil;
    [self.managedObjectContext save:&error];
    NSLog(@"%@", error);
    self.mother = nil;
}


-(void) myCustomBack {
	// Some anything you need to do before leaving
	[self.navigationController popViewControllerAnimated:YES];
}

@end

