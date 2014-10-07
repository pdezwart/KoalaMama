//
//  HMIntroTwoViewController.m
//  KoalaMama
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
    
    Mother* mother = [Mother getMother];
    [self.dueDateDatePicker setDate:mother.estimatedDueDate];

    self.index = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    [Flurry logEvent:@"Intro_Two"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    Mother* mother = [Mother getMother];
    
    mother.estimatedDueDate = [self.dueDateDatePicker date];
    
    [mother save];
}

@end
