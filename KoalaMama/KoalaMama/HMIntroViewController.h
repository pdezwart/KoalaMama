//
//  HMIntroOneViewController.h
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/14/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMIntroViewController : UIViewController <UIPageViewControllerDataSource>

@property int index;
@property (strong, nonatomic) UIPageViewController *pageController;

@end
