//
//  LocationViewController.m
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import "LocationViewController.h"
#import "Globle.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize locationManager;
@synthesize startingPoint;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize horizontalAccuracyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;
@synthesize distanceTraveledLabel;

#pragma mark -

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
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    switch (desiredaccuracy_sign) {
        case 0:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            break;
        case 1:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            break;
        case 2:
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            break;
        case 3:
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            break;
        case 4:
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        default:
            break;
    }
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.locationManager = nil;
    self.latitudeLabel = nil;
    self.longitudeLabel = nil;
    self.horizontalAccuracyLabel = nil;
    self.altitudeLabel = nil;
    self.verticalAccuracyLabel = nil;
    self.distanceTraveledLabel = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc
{
    [locationManager release];
    [startingPoint release];
    [latitudeLabel release];
    [longitudeLabel release];
    [horizontalAccuracyLabel dealloc];
    [altitudeLabel release];
    [verticalAccuracyLabel release];
    [distanceTraveledLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (startingPoint == nil)
        self.startingPoint = newLocation;
    
    NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g\u00B0",newLocation.coordinate.latitude];
    latitudeLabel.text = latitudeString;
    [latitudeString release];
    
    NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g\u00B0",newLocation.coordinate.longitude];
    longitudeLabel.text = longitudeString;
    [longitudeString release];
    
    NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",newLocation.horizontalAccuracy];
    horizontalAccuracyLabel.text = horizontalAccuracyString;
    [horizontalAccuracyString release];
    
    NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm",newLocation.altitude];
    altitudeLabel.text = altitudeString;
    [altitudeString release];
    
    NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm",newLocation.verticalAccuracy];
    verticalAccuracyLabel.text = verticalAccuracyString;
    [verticalAccuracyString release];
    
    CLLocationDistance distance = [newLocation distanceFromLocation:startingPoint];
    NSString *distanceString = [[NSString alloc] initWithFormat:@"%gm",distance];
    distanceTraveledLabel.text = distanceString;
    [distanceString release];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorType = (error.code == kCLErrorDenied)?
    @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location" message:errorType delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end
