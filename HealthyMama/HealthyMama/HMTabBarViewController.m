//
//  HMTabBarViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/22/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMTabBarViewController.h"
#import "HMIntroViewController.h"

@interface HMTabBarViewController ()

@end

@implementation HMTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    // Show the tutorial for new users that have not use the app yet
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];
        HMIntroViewController *intro = [storyboard instantiateViewControllerWithIdentifier:@"HMIntroViewController"];
        [intro setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:intro animated:YES completion:nil];
        
        return;
    }

    // Do the normal stuff
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
