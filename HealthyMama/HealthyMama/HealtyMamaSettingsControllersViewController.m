//
//  HealtyMamaSettingsControllersViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/15/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HealtyMamaSettingsControllersViewController.h"

@interface HealtyMamaSettingsControllersViewController ()

@end

@implementation HealtyMamaSettingsControllersViewController

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
    
    [self loadViewData];
}

- (void) loadViewData {
    self.prePregnancyWeightField.text = @"110";
    
    NSInteger totalHeightInInches = 64;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:10];
    [comps setMonth:8];
    [comps setYear:2013];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    
    // Break down height and weight into its components:
    NSInteger heightInches = totalHeightInInches % 12;
    NSInteger heightFeet = (totalHeightInInches - (heightInches)) / 12;
    
    // Load them into the UI
    [self.heightInFeetPicker selectRow:(heightFeet - 4) inComponent:0 animated:NO];
    [self.heightInFeetPicker selectRow:(heightInches) inComponent:1 animated:NO];
    
    // Load the date into the UI
    [self.estimatedDueDatePicker setDate:date animated:NO];
}

-(void) myCustomBack {
	// Some anything you need to do before leaving
	[self.navigationController popViewControllerAnimated:YES];
}

@end

