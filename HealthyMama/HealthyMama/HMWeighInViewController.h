//
//  HMWeighInViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 6/16/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeighIn.h"

@interface HMWeighInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UIDatePicker *weighInDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
@end
