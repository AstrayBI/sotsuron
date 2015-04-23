//
//  DataBaseViewController.m
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import "DataBaseViewController.h"
#import "Globle.h"
#import <sqlite3.h>

@interface DataBaseViewController ()

@end

@implementation DataBaseViewController
@synthesize dataAView;
@synthesize dataGView;

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

- (IBAction)updateButtonPressed:(id)sender{
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
    NSString *Aquery = @"SELECT * FROM ADATA";
    sqlite3_stmt *Astate;
    if (sqlite3_prepare_v2(accelerADatabase, [Aquery UTF8String], -1, &Astate, nil) == SQLITE_OK) {
        while (sqlite3_step(Astate) == SQLITE_ROW) {
            char *AXData = (char *)sqlite3_column_text(Astate,1);
            char *AYData = (char *)sqlite3_column_text(Astate, 2);
            char *AZData = (char *)sqlite3_column_text(Astate, 3);
            
            NSString *AXOut = [[NSString alloc] initWithUTF8String:AXData];
            NSString *AYOut = [[NSString alloc] initWithUTF8String:AYData];
            NSString *AZOut = [[NSString alloc] initWithUTF8String:AZData];
            NSString *AOut = [[NSString alloc] initWithFormat:@"%s\t%s\t%s\n",[AXOut UTF8String],[AYOut UTF8String],[AZOut UTF8String]];
            NSString *Atemp = [[NSString alloc] initWithFormat:@"%s",[dataAView.text UTF8String]];
            NSString *AFinal = [[NSString alloc] initWithFormat:@"%s%s",[Atemp UTF8String],[AOut UTF8String]];
            
            dataAView.text = AFinal;
            [AXOut release];
            [AYOut release];
            [AZOut release];
            [AOut release];
            [Atemp release];
            [AFinal release];
            
        }
        sqlite3_finalize(Astate);
    }
    sqlite3_close(accelerADatabase);
    
    
    
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
    
    NSString *Gquery = @"SELECT * FROM GDATA";
    sqlite3_stmt *Gstate;
    if (sqlite3_prepare_v2(accelerGDatabase, [Gquery UTF8String], -1, &Gstate, nil) == SQLITE_OK) {
        while (sqlite3_step(Gstate) == SQLITE_ROW) {
            char *GXData = (char *)sqlite3_column_text(Gstate,1);
            char *GYData = (char *)sqlite3_column_text(Gstate, 2);
            char *GZData = (char *)sqlite3_column_text(Gstate, 3);
            
            NSString *GXOut = [[NSString alloc] initWithUTF8String:GXData];
            NSString *GYOut = [[NSString alloc] initWithUTF8String:GYData];
            NSString *GZOut = [[NSString alloc] initWithUTF8String:GZData];
            NSString *GOut = [[NSString alloc] initWithFormat:@"%s\t%s\t%s\n",[GXOut UTF8String],[GYOut UTF8String],[GZOut UTF8String]];
            NSString *Gtemp = [[NSString alloc] initWithFormat:@"%s",[dataGView.text UTF8String]];
            NSString *GFinal = [[NSString alloc] initWithFormat:@"%s%s",[Gtemp UTF8String],[GOut UTF8String]];
            dataGView.text = GFinal;
            [GXOut release];
            [GYOut release];
            [GZOut release];
            [GOut release];
            [Gtemp release];
            [GFinal release];
        }
        sqlite3_finalize(Gstate);
    }
    sqlite3_close(accelerGDatabase);
    
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [dataAView release];
    [dataGView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
