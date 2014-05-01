//
//  HMFoodJournalViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/27/13.
//  Copyright (c) 2013 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFoodJournalViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate> {
}

@property (nonatomic, retain) UIActionSheet *datePickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *foodDate;

@end
