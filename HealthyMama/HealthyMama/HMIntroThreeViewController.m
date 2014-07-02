//
//  HMIntroThreeViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/22/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroThreeViewController.h"

@interface HMIntroThreeViewController ()

@end

// Intro Three
// Ask for birthday

@implementation HMIntroThreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 2;
    
    Mother* mother = [Mother getMother];

    [self.birthdayDatePicker setDate:mother.dateOfBirth];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Intro_Three"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    Mother* mother = [Mother getMother];
    
    mother.dateOfBirth = [self.birthdayDatePicker date];
    
    [mother save];
}

@end
