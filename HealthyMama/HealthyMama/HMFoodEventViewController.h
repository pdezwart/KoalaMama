//
//  HMFoodEventViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/2/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFoodEventViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) UIActionSheet *datePickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDate *date;

@property (weak, nonatomic) IBOutlet UITextField *foodDate;


@end
