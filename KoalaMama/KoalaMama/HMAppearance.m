//
//  HMAppearance.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 10/6/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "HMAppearance.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.3]

@implementation HMAppearance

+ (void) applyAppearance
{
    [[UITextView appearance] setBackgroundColor:[UIColor clearColor]];
}

+ (void) drawBackground:(UIView *)view
{
    // Make sure we have the correct view size:
    [view layoutIfNeeded];
    // Get the height and width of the full thing
    float height = view.bounds.size.height;
    float width = view.bounds.size.width;
        
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0x1CD7FC) CGColor], (id)[UIColorFromRGB(0xC0FCE7) CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
}

@end