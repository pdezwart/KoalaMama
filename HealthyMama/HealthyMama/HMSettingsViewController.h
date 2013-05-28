//
//  HMSettingsViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)closeModalWindow:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *prePregnancyWeightField;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *estimatedDueDatePicker;

@end
