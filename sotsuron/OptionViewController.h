//
//  OptionViewController.h
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSwitchesSegmentIndex   0

@interface OptionViewController : UIViewController{
    UISlider *accuracyControl;
    UISlider *accelerControl;
    UISlider *gyroControl;
    UILabel *accuracySlider;
    UILabel *accelerSlider;
    UILabel *gyroSlider;
}

@property (nonatomic,retain) IBOutlet UILabel *accuracySlider;
@property (nonatomic,retain) IBOutlet UILabel *accelerSlider;
@property (nonatomic,retain) IBOutlet UILabel *gyroSlider;
@property (nonatomic,retain) IBOutlet UISlider *accuracyControl;
@property (nonatomic,retain) IBOutlet UISlider *accelerControl;
@property (nonatomic,retain) IBOutlet UISlider *gyroControl;

- (IBAction)accuracyChanged:(id)sender;
- (IBAction)accelerChanged:(id)sender;
- (IBAction)gyroChanged:(id)sender;
- (IBAction)toggleControls:(id)sender;

@end

