//
//  OptionViewController.m
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import "OptionViewController.h"
#import "Globle.h"

@interface OptionViewController ()

@end

@implementation OptionViewController
@synthesize accuracySlider;
@synthesize accelerSlider;
@synthesize gyroSlider;
@synthesize accuracyControl;
@synthesize accelerControl;
@synthesize gyroControl;

- (IBAction)toggleControls:(id)sender{
    if ([sender selectedSegmentIndex] == kSwitchesSegmentIndex) {
        accuracyControl.enabled = NO;
        accuracySlider.text = @"AccuracyBest";
        desiredaccuracy_sign = 0;
    }
    else {
        accuracyControl.enabled = YES;
    }
}

- (IBAction)accuracyChanged:(id)sender{
    int accuracyValue = (int)(accuracyControl.value + 0.5f);
    if (accuracyValue == 0) {
        accuracySlider.text = @"AccuracyBest";
        desiredaccuracy_sign = 0;
    } else if (accuracyValue == 1) {
        accuracySlider.text = @"NearestTenMeters";
        desiredaccuracy_sign = 1;
    } else if (accuracyValue == 2) {
        accuracySlider.text = @"HundredMeters";
        desiredaccuracy_sign = 2;
    } else if (accuracyValue == 3) {
        accuracySlider.text = @"Kilometer";
        desiredaccuracy_sign = 3;
    } else if (accuracyValue == 4) {
        accuracySlider.text = @"ThreeKilometers";
        desiredaccuracy_sign = 4;
    }
}

- (IBAction)accelerChanged:(id)sender{
    float accelerTemp = (float)(accelerControl.value);
    accelerSlider.text = [[NSString alloc] initWithFormat:@"%+.2f",accelerTemp];
    accelerupdate_sign = accelerTemp;
}

-(IBAction)gyroChanged:(id)sender{
    float gyroTemp = (float)(gyroControl.value);
    gyroSlider.text = [[NSString alloc] initWithFormat:@"%+.2f",gyroTemp];
    gyroupdate_sign = gyroTemp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    extern int desiredaccuracy_sign;
    desiredaccuracy_sign = 0;
    extern float accelerupdate_sign;
    accelerupdate_sign = 0.1;
    extern float gyroupdate_sign;
    gyroupdate_sign = 0.1;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
