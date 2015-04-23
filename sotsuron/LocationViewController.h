//
//  LocationViewController.h
//  sotsuron
//
//  Created by Astray Bi on 2014/05/20.
//  Copyright (c) 2014年 Astray Bi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation        *startingPoint;
    
    UILabel *latitudeLabel;
    UILabel *longitudeLabel;
    UILabel *horizontalAccuracyLabel;
    UILabel *altitudeLabel;
    UILabel *verticalAccuracyLabel;
    UILabel *distanceTraveledLabel;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startingPoint;
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *horizontalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *altitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *verticalAccuracyLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceTraveledLabel;

@end
