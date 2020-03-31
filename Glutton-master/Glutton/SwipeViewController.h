//
//  SwipeViewController.h
//  Glutton
//
//  Created by Tyler on 4/2/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseRestaurantView.h"
#import <MDCSwipeToChoose/MDCSwipeToChooseDelegate.h>
#import <CoreLocation/CoreLocation.h>

@interface SwipeViewController : UIViewController <MDCSwipeToChooseDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) Restaurant *currentRestaurant;
@property (strong, nonatomic) ChooseRestaurantView *frontCardView;
@property (strong, nonatomic) ChooseRestaurantView *backCardView;

@end
