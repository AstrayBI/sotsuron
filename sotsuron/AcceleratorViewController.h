//
//  AcceleratorViewController.h
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#define aFilename   @"accelerAdata.sqlite3"
#define gFilename   @"accelerGdata.sqlite3"

@interface AcceleratorViewController : UIViewController
{
    CMMotionManager *motionManager;
    UILabel *AXLabel;
    UILabel *AYLabel;
    UILabel *AZLabel;
    UILabel *GXLabel;
    UILabel *GYLabel;
    UILabel *GZLabel;
    UIButton *accelerButton;
    UIButton *stopButton;
}

@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) IBOutlet UILabel *AXLabel;
@property (nonatomic, retain) IBOutlet UILabel *AYLabel;
@property (nonatomic, retain) IBOutlet UILabel *AZLabel;
@property (nonatomic, retain) IBOutlet UILabel *GXLabel;
@property (nonatomic, retain) IBOutlet UILabel *GYLabel;
@property (nonatomic, retain) IBOutlet UILabel *GZLabel;
@property (nonatomic, retain) IBOutlet UIButton *accelerButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

- (IBAction)accelerButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;

@end
