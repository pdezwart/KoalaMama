//
//  HMWeighInViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/16/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import "HMWeighInViewController.h"

@interface HMWeighInViewController ()

@end

@implementation HMWeighInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)saveButtonClicked:(id)sender {
    WeighIn *event = [WeighIn factory];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    event.imperialWeight = [f numberFromString:[self.weightField text]];
    event.mother = [Mother getMother];
    event.time = [self.weighInDatePicker date];
    [event save];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
