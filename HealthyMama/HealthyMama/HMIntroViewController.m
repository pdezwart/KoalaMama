//
//  HMIntroOneViewController.m
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/14/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroViewController.h"
#import "HMIntroOneViewController.h"
#import "HMIntroTwoViewController.h"
#import "HMIntroThreeViewController.h"
#import "HMIntroFourViewController.h"

@interface HMIntroViewController ()


@end


@implementation HMIntroViewController

@synthesize index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    self.index = 0;
    
    HMIntroOneViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    index--;

    if (index < 0) {
        return nil;
    }
    
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    
    index++;
    
    if (index >= 4) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    UIViewController *childViewController;
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];

    switch (index) {
        case 0:
            childViewController = [board instantiateViewControllerWithIdentifier:@"HMIntroOneViewController"];
            break;
        case 1:
            childViewController = [board instantiateViewControllerWithIdentifier:@"HMIntroTwoViewController"];
            break;
        case 2:
            childViewController = [board instantiateViewControllerWithIdentifier:@"HMIntroThreeViewController"];
            break;
        case 3:
            childViewController = [board instantiateViewControllerWithIdentifier:@"HMIntroFourViewController"];
            break;
    }

    self.index = index;
    
    return childViewController;
    
}

@end
