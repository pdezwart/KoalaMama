//
//  HMFoodEventViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/2/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMFoodEventViewController.h"

@interface HMFoodEventViewController ()

@end

@implementation HMFoodEventViewController

@synthesize datePickerView;
@synthesize datePicker;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];
    [self storeDate:now];
}

- (void) storeDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YYYY @ hh:mm a"];
    
    [self.foodDate setText:[formatter stringFromDate:date]];
    self.date = date;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    [self showDatePicker];
}

-(void) showDatePicker
{
    // Prevent keyboard from showing up when ActionSheet is dismissed
    [self.foodDate resignFirstResponder];
    
    // Build the action sheet contents
    datePickerView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker sizeToFit];
    
    
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
    
    [self storeDate:[datePicker date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
