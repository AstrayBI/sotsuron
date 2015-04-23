//
//  AcceleratorViewController.m
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

//
//  SecondViewController.m
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AcceleratorViewController.h"
#import "Globle.h"
#import <sqlite3.h>

@interface AcceleratorViewController ()

@end

@implementation AcceleratorViewController
@synthesize motionManager;
@synthesize AXLabel;
@synthesize AYLabel;
@synthesize AZLabel;
@synthesize GXLabel;
@synthesize GYLabel;
@synthesize GZLabel;
@synthesize accelerButton;
@synthesize stopButton;

- (NSString *)dataFileAPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:aFilename];
}

- (NSString *)dataFileGPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:gFilename];
}


- (void)accelerButtonPressed:(id)sender{
    accelerButton.hidden = YES;
    stopButton.hidden = NO;
    
    self.motionManager = [[[CMMotionManager alloc] init] autorelease];
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = accelerupdate_sign;
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:
         ^(CMAccelerometerData *accelerometerData, NSError *error){
             NSString *labelText;
             NSString *AXText;
             NSString *AYText;
             NSString *AZText;
             if (error) {
                 [motionManager stopAccelerometerUpdates];
                 labelText = [NSString stringWithFormat:@"Accelerometer encountered error: %@", error];
                 [AXLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:YES];
             } else {
                 AXText = [NSString stringWithFormat:@"%+.2f",accelerometerData.acceleration.x];
                 AYText = [NSString stringWithFormat:@"%+.2f",accelerometerData.acceleration.y];
                 AZText = [NSString stringWithFormat:@"%+.2f",accelerometerData.acceleration.z];
                 [AXLabel performSelectorOnMainThread:@selector(setText:) withObject:AXText waitUntilDone:YES];
                 [AYLabel performSelectorOnMainThread:@selector(setText:) withObject:AYText waitUntilDone:YES];
                 [AZLabel performSelectorOnMainThread:@selector(setText:) withObject:AZText waitUntilDone:YES];
                 
                 sqlite3 *accelerADatabase;
                 if (sqlite3_open([[self dataFileAPath] UTF8String], &accelerADatabase) != SQLITE_OK) {
                     sqlite3_close(accelerADatabase);
                     NSAssert(0,@"Failed to open Adatabase");
                 }
                 
                 
                 char *AerrorMsg;
                 NSString *AcreateSQL = @"CREATE TABLE IF NOT EXISTS ADATA(ROW INERGER PRIMARY KEY, A_X TEXT, A_Y TEXT, A_Z TEXT);";
                 if (sqlite3_exec (accelerADatabase, [AcreateSQL UTF8String],NULL,NULL,&AerrorMsg) != SQLITE_OK) {
                     sqlite3_close(accelerADatabase);
                     NSAssert1(0, @"Error creating table: %s", AerrorMsg);
                 }
                 
                 char *Aupdate = "INSERT INTO ADATA(A_X, A_Y, A_Z) VALUES (?,?,?);";
                 sqlite3_stmt *Astmt;
                 if (sqlite3_prepare_v2(accelerADatabase, Aupdate, -1, &Astmt, nil) == SQLITE_OK){
                     sqlite3_bind_text(Astmt, 1, [AXLabel.text UTF8String], -1, NULL);
                     sqlite3_bind_text(Astmt, 2, [AYLabel.text UTF8String], -1, NULL);
                     sqlite3_bind_text(Astmt, 3, [AZLabel.text UTF8String], -1, NULL);
                 }
                 if (sqlite3_step(Astmt) != SQLITE_DONE){
                     NSAssert(0,@"Error updating table.");
                 }
                 sqlite3_finalize(Astmt);
             }
         }];
    } else {
        AXLabel.text = @"This device has no accelerometer.";
    }
    if (motionManager.gyroAvailable) {
        motionManager.gyroUpdateInterval = gyroupdate_sign;
        [motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            NSString *labelText;
            NSString *GXText;
            NSString *GYText;
            NSString *GZText;
            if (error) {
                [motionManager stopGyroUpdates];
                labelText = [NSString stringWithFormat:@"Gyroscope encountered error: %@",error];
                [GXLabel performSelectorOnMainThread:@selector(setText:) withObject:labelText waitUntilDone:YES];
            } else {
                GXText = [NSString stringWithFormat:@"%+.2f",gyroData.rotationRate.x];
                GYText = [NSString stringWithFormat:@"%+.2f",gyroData.rotationRate.y];
                GZText = [NSString stringWithFormat:@"%+.2f",gyroData.rotationRate.z];
                [GXLabel performSelectorOnMainThread:@selector(setText:) withObject:GXText waitUntilDone:YES];
                [GYLabel performSelectorOnMainThread:@selector(setText:) withObject:GYText waitUntilDone:YES];
                [GZLabel performSelectorOnMainThread:@selector(setText:) withObject:GZText waitUntilDone:YES];
                
                sqlite3 *accelerGDatabase;
                if (sqlite3_open([[self dataFileGPath] UTF8String], &accelerGDatabase) != SQLITE_OK) {
                    sqlite3_close(accelerGDatabase);
                    NSAssert(0,@"Failed to open Gdatabase");
                }
                
                char *GerrorMsg;
                NSString *GcreateSQL = @"CREATE TABLE IF NOT EXISTS GDATA(ROW INERGER PRIMARY KEY, G_X TEXT, G_Y TEXT, G_Z TEXT);";
                if (sqlite3_exec (accelerGDatabase, [GcreateSQL UTF8String],NULL,NULL,&GerrorMsg) != SQLITE_OK) {
                    sqlite3_close(accelerGDatabase);
                    NSAssert1(0, @"Error creating table: %s", GerrorMsg);
                }
                
                char *Gupdate = "INSERT INTO GDATA(G_X, G_Y, G_Z) VALUES (?,?,?);";
                sqlite3_stmt *Gstmt;
                if (sqlite3_prepare_v2(accelerGDatabase, Gupdate, -1, &Gstmt, nil) == SQLITE_OK){
                    sqlite3_bind_text(Gstmt, 1, [GXLabel.text UTF8String], -1, NULL);
                    sqlite3_bind_text(Gstmt, 2, [GYLabel.text UTF8String], -1, NULL);
                    sqlite3_bind_text(Gstmt, 3, [GZLabel.text UTF8String], -1, NULL);
                }
                if (sqlite3_step(Gstmt) != SQLITE_DONE){
                    NSAssert(0,@"Error updating table.");
                }
                sqlite3_finalize(Gstmt);
            }
            
        }];
    } else {
        GXLabel.text = @"This device has no gyroscope";
    }
}

- (IBAction)stopButtonPressed:(id)sender{
    [motionManager stopGyroUpdates];
    [motionManager stopAccelerometerUpdates];
    AXLabel.text = nil;
    AYLabel.text = nil;
    AZLabel.text = nil;
    GXLabel.text = nil;
    GYLabel.text = nil;
    GZLabel.text = nil;
    stopButton.hidden = YES;
    accelerButton.hidden = NO;
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
}

- (void)viewDidUnload
{
    self.motionManager = nil;
    self.AXLabel = nil;
    self.AYLabel = nil;
    self.AZLabel = nil;
    self.GXLabel = nil;
    self.GYLabel = nil;
    self.GZLabel = nil;
    self.accelerButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) dealloc
{
    [motionManager release];
    [AXLabel release];
    [AYLabel release];
    [AZLabel release];
    [GXLabel release];
    [GYLabel release];
    [GZLabel release];
    [accelerButton release];
    [stopButton release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
