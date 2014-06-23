//
//  HMIntroOneViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/14/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMIntroViewController : UIViewController <UIPageViewControllerDataSource>

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) UIPageViewController *pageController;

@end
