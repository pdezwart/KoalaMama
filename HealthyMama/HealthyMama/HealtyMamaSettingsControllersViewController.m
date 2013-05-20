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

- (IBAction)dueDatePickerChanged:(id)sender {

}

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

-(void) myCustomBack {
	// Some anything you need to do before leaving
	[self.navigationController popViewControllerAnimated:YES];
}

@end

