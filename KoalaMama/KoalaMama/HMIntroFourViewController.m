//
//  HMIntroFourViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/22/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroFourViewController.h"
#import "HMTabBarViewController.h"

@interface HMIntroFourViewController ()

@end

// Intro Four
// Ask for height and pre-pregnancy weight

@implementation HMIntroFourViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 3;
    
    Mother* mother = [Mother getMother];
    
    // Break down height and weight into its components:
    int height = [mother.imperialHeight intValue];
    NSInteger heightInches = height % 12;
    NSInteger heightFeet = (height - (heightInches)) / 12;
    
    // Load them into the UI
    [self.heightPicker selectRow:(heightFeet - 4) inComponent:0 animated:NO];
    [self.heightPicker selectRow:(heightInches) inComponent:1 animated:NO];
    
    self.prePregnancyWeightInput.text = [NSString stringWithFormat:@"%@", mother.imperialPrePregnancyWeight];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Intro_Four"];
}

- (IBAction)buttonCompletePushed:(id)sender {
    
    // Save height and weight:
    Mother* mother = [Mother getMother];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    mother.imperialPrePregnancyWeight = [f numberFromString:[self.prePregnancyWeightInput text]];
    mother.imperialHeight = [NSNumber numberWithInt:(([self.heightPicker selectedRowInComponent:0] + 4) * 12 + (int)[self.heightPicker selectedRowInComponent:1])];

    
    // Remember that user has now seen the tutorial
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Send user to the original page:
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];
    HMTabBarViewController *tabView = [storyboard instantiateViewControllerWithIdentifier:@"HMTabBarViewController"];
    [tabView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:tabView animated:YES completion:nil];
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
        return [NSString stringWithFormat:@"%d ft", row + 4];
    } else {
        return [NSString stringWithFormat:@"%d in", row];
    }
}

@end
