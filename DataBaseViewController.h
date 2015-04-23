//
//  DataBaseViewController.h
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define aFilename   @"accelerAdata.sqlite3"
#define gFilename   @"accelerGdata.sqlite3"


@interface DataBaseViewController : UIViewController{
    UITextView *dataAView;
    UITextView *dataGView;
    UIButton *updateButton;
}

@property (nonatomic, retain) IBOutlet UITextView *dataAView;
@property (nonatomic, retain) IBOutlet UITextView *dataGView;
@property (nonatomic, retain) IBOutlet UIButton *updateButton;

- (IBAction)updateButtonPressed:(id)sender;

@end
