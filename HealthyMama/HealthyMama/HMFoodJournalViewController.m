//
//  HMFoodJournalViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMFoodJournalViewController.h"

@interface HMFoodJournalViewController ()

@end


@implementation HMFoodJournalViewController

@synthesize datePickerView;
@synthesize datePicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    [self showAction];
}

-(void) showAction
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
    
    NSLog(@"%@", [datePicker date]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
