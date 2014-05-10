//
//  HMFoodEventViewController.h
//  HealthyMama
//
//  Created by Pieter de Zwart on 5/2/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFoodEventViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UIActionSheet *datePickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDate *date;

@property (nonatomic, retain) UITableView *autocompleteTableView;
@property (nonatomic, retain) NSMutableArray *autocompleteFoodNames;
@property (nonatomic, retain) NSMutableArray *allFoodNames;


@property (weak, nonatomic) IBOutlet UITextField *foodDate;
@property (weak, nonatomic) IBOutlet UITextField *foodName;



@end
