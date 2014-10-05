//
//  HMIntroBaseViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/30/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroBaseViewController.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.3]

@interface HMIntroBaseViewController ()

@end

@implementation HMIntroBaseViewController

- (void) viewDidLoad
{
    // Make sure we have the correct view size:
    [self.view layoutIfNeeded];
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0x1CD7FC) CGColor], (id)[UIColorFromRGB(0xC0FCE7) CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

@end
