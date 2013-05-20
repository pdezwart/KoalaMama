//
//  HealtyMamaSecondViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/15/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HealtyMamaSecondViewController.h"

@interface HealtyMamaSecondViewController ()

@end

@implementation HealtyMamaSecondViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}


//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [@[@"one", @"two", @"three"] objectAtIndex:row];
}

@end
