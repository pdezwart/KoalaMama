//
//  HMWeighInViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/16/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMWeighInViewController.h"
#import "Flurry.h"

@interface HMWeighInViewController ()

@end

@implementation HMWeighInViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Page_WeighIn"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Only allow the character if the result of the field results in a numeric string
    NSUInteger numberOfMatches = 1;
    if (textField == self.weightField) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^[0-9]+$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:nil];
        numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    }
    
    return numberOfMatches == 0 ? NO : YES;
}

- (IBAction)saveButtonClicked:(id)sender {
    
    // Make sure we have at least one digit
    if ([[self.weightField text] length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Weight" message:@"Please enter your weight." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
    
    WeighIn *event = [WeighIn factory];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    event.imperialWeight = [f numberFromString:[self.weightField text]];
    event.mother = [Mother getMother];
    event.time = [self.weighInDatePicker date];
    [event save];

    [Flurry logEvent:@"Action_Settings_Save"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [Flurry logEvent:@"Action_Settings_Cancel"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
