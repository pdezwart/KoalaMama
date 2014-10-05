//
//  HMSettingsViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/26/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMSettingsViewController.h"
#import "Mother.h"
#import "Flurry.h"

@interface HMSettingsViewController ()

@end

@implementation HMSettingsViewController

@synthesize datePickerView;
@synthesize datePicker;
@synthesize estimatedDueDate;
@synthesize dateOfBirth;

- (void) selectionDidChange:(id<UITextInput>)textInput {}
- (void) selectionWillChange:(id<UITextInput>)textInput {}
- (void) textDidChange:(id<UITextInput>)textInput {}
- (void) textWillChange:(id<UITextInput>)textInput {}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [Flurry logEvent:@"Page_Settings"];
    
    Mother *mother = [Mother getMother];

    // Load mom's info:
    self.measurementSystemController.selectedSegmentIndex = [mother isMetric] == YES ? 1 : 0;
    self.prePregnancyWeightField.text = [NSString stringWithFormat:@"%@", mother.imperialPrePregnancyWeight];
    
    // Break down height and weight into its components:
    int height = [mother.imperialHeight intValue];
    NSInteger heightInches = height % 12;
    NSInteger heightFeet = (height - (heightInches)) / 12;
    
    // Load them into the UI
    [self.heightPicker selectRow:(heightFeet - 4) inComponent:0 animated:NO];
    [self.heightPicker selectRow:(heightInches) inComponent:1 animated:NO];
    
    // Load everything else:
    self.estimatedDueDate = mother.estimatedDueDate;
    [self storeDate:self.estimatedDueDate textField:self.estimatedDueDateInput];
    self.dateOfBirth = mother.dateOfBirth;
    [self storeDate:self.dateOfBirth textField:self.dateOfBirthInput];
    [self.expectingTwinsSwitch setOn:[mother.expectingTwins boolValue]];
    
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
    mother.imperialPrePregnancyWeight = [f numberFromString:[self.prePregnancyWeightField text]];
    
    // Save all the other basic fields:
    if (self.measurementSystemController.selectedSegmentIndex == 1) {
        [mother makeMetric];
    } else {
        [mother makeImperial];
    }
    mother.estimatedDueDate = self.estimatedDueDate;
    mother.expectingTwins = [NSNumber numberWithBool:[self.expectingTwinsSwitch isOn]];
    mother.dateOfBirth = self.dateOfBirth;
    
    
    // Save the person's height:
    mother.imperialHeight = [NSNumber numberWithInt:((int)([self.heightPicker selectedRowInComponent:0] + 4) * 12 + (int)[self.heightPicker selectedRowInComponent:1])];

    // Call save
    [mother save];
}

/* Height Picker View */
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
        return [NSString stringWithFormat:@"%d ft", (int)row + 4];
    } else {
        return [NSString stringWithFormat:@"%d in", (int)row];
    }
}

/* Date pickers */

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    // Keep a reference of who got us here
    self.sender = sender;
    
    NSDate *date = [NSDate date];
    if ([self.sender.restorationIdentifier isEqualToString:@"estimatedDueDateField"]) {
        date = self.estimatedDueDate;
    } else {
        date = self.dateOfBirth;
    }
    
    [self showDatePicker:date];
}

-(void) showDatePicker:(NSDate *)date
{
    // Prevent keyboard from showing up when ActionSheet is dismissed
    [self.sender resignFirstResponder];
    
    // Build the action sheet contents
    datePickerView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker sizeToFit];
    [datePicker setDate:date];
    
    
    UIToolbar *controlBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, datePickerView.bounds.size.width, 44)];
    [controlBar setBarStyle:UIBarStyleBlackTranslucent];
    [controlBar sizeToFit];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(setPickerDate)];
    
    [controlBar setItems:[NSArray arrayWithObject:setButton] animated:NO];
    
    [datePickerView addSubview:datePicker];
    [datePickerView addSubview:controlBar];
    [datePickerView showInView:[self.view superview]];
    [datePickerView setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)setPickerDate {
    [datePickerView dismissWithClickedButtonIndex:0 animated:YES];
    
    [self storeDate:[datePicker date] textField:self.sender];
}

- (void) storeDate:(NSDate *)date textField:(UITextField *)textField {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YYYY"];
    
    [textField setText:[formatter stringFromDate:date]];
    
    // Figure out which one got us here and store the value there
    if ([self.sender.restorationIdentifier isEqualToString:@"estimatedDueDateInput"]) {
        self.estimatedDueDate = date;
    } else {
        self.dateOfBirth = date;
    }
    
    // Get rid of our reference to the UITextInputField
    self.sender = nil;
}



- (IBAction)closeModalWindow:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
