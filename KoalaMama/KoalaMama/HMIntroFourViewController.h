//
//  HMIntroFourViewController.h
//  KoalaMama
//
//  Created by Pieter de Zwart on 6/22/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMIntroBaseViewController.h"


@interface HMIntroFourViewController : HMIntroBaseViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)buttonCompletePushed:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPicker;
@property (weak, nonatomic) IBOutlet UITextField *prePregnancyWeightInput;

@end
