#import "HMTheme.h"


@interface HMTheme ()

// Private interface goes here.

@end

@implementation HMTheme

static NSString *labelFont;


+ (void) applyTheme
{
/*    [self applyThemeToBackground];
    [self applyThemeToTableCells];
    [self applyThemeToStatusBar];
    [self applyThemeToNavigationBar];*/
}

+ (void) applyThemeToBackground
{
    [[UIView appearance] setBackgroundColor:[UIColor colorWithRed:0.88 green:0.55 blue:0.30 alpha:1.0]];
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    [[UILabel appearance] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [[UIButton appearance] setBackgroundColor:[UIColor colorWithRed:1.0 green:0.67 blue:0.42 alpha:1.0]];

    [[UITextField appearance] setAlpha:0.8];
    [[UITextField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITextField appearance] setTextColor:[UIColor redColor]];
}

+ (void) applyThemeToTableCells
{

}

+ (void) applyThemeToStatusBar
{
    
}

+ (void) applyThemeToNavigationBar
{
    [[UITextField appearance] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
}
@end
