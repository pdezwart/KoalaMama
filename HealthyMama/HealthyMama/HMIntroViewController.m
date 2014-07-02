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

#import <Crashlytics/Crashlytics.h>

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
    
    HMIntroBaseViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}


- (HMIntroBaseViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(HMIntroBaseViewController *)viewController {

    int previousIndex = viewController.index - 1;

    if (previousIndex < 0) {
        return nil;
    }
    
    return [self viewControllerAtIndex:previousIndex];
}

- (HMIntroBaseViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(HMIntroBaseViewController *)viewController {
    
    int nextIndex = viewController.index + 1;
    
    if (nextIndex > 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:nextIndex];
}

- (HMIntroBaseViewController *)viewControllerAtIndex:(NSUInteger)controllerIndex {

    HMIntroBaseViewController *childViewController;
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"iPhoneStoryboard" bundle:nil];

    switch (controllerIndex) {
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
    
    return childViewController;
}

@end
