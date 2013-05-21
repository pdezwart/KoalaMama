//
//  HealtyMamaSettingsControllersViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/15/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealtyMamaSettingsControllersViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
}
@property (weak, nonatomic) IBOutlet UITextField *prePregnancyWeightField;
@property (weak, nonatomic) IBOutlet UIPickerView *heightInFeetPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *estimatedDueDatePicker;

@end
