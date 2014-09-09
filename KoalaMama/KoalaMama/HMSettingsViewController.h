//
//  HMSettingsViewController.h
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextInputDelegate, UIActionSheetDelegate>

- (IBAction)closeModalWindow:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *measurementSystemController;

@property (weak, nonatomic) IBOutlet UITextField *estimatedDueDateInput;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthInput;

@property (weak, nonatomic) IBOutlet UITextField *prePregnancyWeightField;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (weak, nonatomic) IBOutlet UISwitch *expectingTwinsSwitch;

/* Storage for the ActionSheet elements */
@property (nonatomic, retain) UIActionSheet *datePickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, weak) UITextField *sender;

@property (nonatomic, retain) NSDate *estimatedDueDate;
@property (nonatomic, retain) NSDate *dateOfBirth;


@end
