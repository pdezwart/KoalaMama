//
//  HMFoodEventViewController.m
//  KoalaMama
//
//  Created by Pieter de Zwart on 5/2/14.
//  Copyright (c) 2014 Pieter de Zwart. All rights reserved.
//

#import "HMFoodEventViewController.h"
#import "Flurry.h"


@interface HMFoodEventViewController ()

@end

@implementation HMFoodEventViewController

#define INPUT_DATE 100
#define INPUT_FOOD 101

@synthesize datePickerView;
@synthesize datePicker;
@synthesize autocompleteTableView;
@synthesize autocompleteFoodNames;
@synthesize allFoodNames;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add ability to resign keyboard when touch outside of the text field:
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    NSDate *now = [NSDate date];
    [self storeDate:now];
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 165, 320, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];
    
    self.autocompleteFoodNames = [[NSMutableArray alloc] init];
    self.allFoodNames = [FoodJournal getDistinctFoodNames];

    // Add tags to the text views:
    self.foodDate.tag = INPUT_DATE;
    self.foodName.tag = INPUT_FOOD;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Flurry logEvent:@"Page_FoodEvent"];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.autocompleteTableView]) {
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

- (void)dismissKeyboard {
    [self.foodName resignFirstResponder];
    [self.foodCalories resignFirstResponder];
}

- (void) storeDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YYYY @ hh:mm a"];
    
    [self.foodDate setText:[formatter stringFromDate:date]];
    self.date = date;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (sender.tag == INPUT_DATE) {
        [self showDatePicker];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL allowCharacter = YES;
    
    if (textField == self.foodCalories) {
        // Only allow the character if the result of the field results in a numeric string
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^[0-9]+$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:nil];
        allowCharacter = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    } else if (textField == self.foodName) {
        autocompleteTableView.hidden = NO;
        
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
    }

    return allowCharacter;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteFoodNames removeAllObjects];
    for(NSString *curString in self.allFoodNames) {
        NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        if (substringRange.location == 0) {
            [autocompleteFoodNames addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}

- (void) showDatePicker
{
    // Prevent keyboard from showing up when ActionSheet is dismissed
    [self.foodDate resignFirstResponder];
    
    // Build the action sheet contents
    datePickerView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker sizeToFit];
    
    
    UIToolbar *controlBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, datePickerView.bounds.size.width, 44)];
    [controlBar setBarStyle:UIBarStyleBlackTranslucent];
    [controlBar sizeToFit];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(setPickerDate)];
    
    [controlBar setItems:[NSArray arrayWithObject:setButton] animated:NO];
    
    [datePickerView addSubview:datePicker];
    [datePickerView addSubview:controlBar];
    [datePickerView showInView:[self.view superview]];
    [datePickerView setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)setPickerDate {
    [datePickerView dismissWithClickedButtonIndex:0 animated:YES];
    
    [self storeDate:[datePicker date]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return [autocompleteFoodNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [autocompleteFoodNames objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.foodName.text = selectedCell.textLabel.text;
    // Find the most recent calories for that food:
    self.foodCalories.text = [[FoodJournal getMostRecentCaloriesOfFood:self.foodName.text] stringValue];
    
    autocompleteTableView.hidden = YES;
    
    // Make sure the keyboard is hidden:
    [self dismissKeyboard];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    // Make sure we have at least one digit
    if ([[self.foodCalories text] length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Calories" message:@"Please a calorie value." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    } else if ([[self.foodName text] length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Food Name" message:@"Please a food." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
        
    }
    
    FoodJournal *fj = [FoodJournal factory];
    fj.calories = [NSNumber numberWithInt:(int)[self.foodCalories.text integerValue]];
    fj.label = self.foodName.text;
    fj.time = self.date;
    [fj save];
    
    [Flurry logEvent:@"Action_FoodEvent_Save"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [Flurry logEvent:@"Action_FoodEvent_Cancel"];

    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
