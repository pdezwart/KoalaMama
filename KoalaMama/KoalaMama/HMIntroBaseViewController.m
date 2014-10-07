//
//  HMIntroBaseViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/30/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMIntroBaseViewController.h"
#import "HMAppearance.h"

@interface HMIntroBaseViewController ()

@end

@implementation HMIntroBaseViewController

- (void) viewDidLoad
{
    [HMAppearance drawBackground:self.view];
}

@end
