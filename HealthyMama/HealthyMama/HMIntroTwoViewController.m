//
//  HMIntroTwoViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/22/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroTwoViewController.h"


@interface HMIntroTwoViewController ()

@end

// Intro Two
// Ask for due date

@implementation HMIntroTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 1;
    
    Mother* mother = [Mother getMother];
    [self.dueDateDatePicker setDate:mother.estimatedDueDate];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    Mother* mother = [Mother getMother];
    
    mother.dateOfBirth = [self.dueDateDatePicker date];
    
    [mother save];
}

@end
