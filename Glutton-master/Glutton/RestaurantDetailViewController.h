//
//  RestaurantDetailViewController.h
//  Glutton
//
//  Created by Tyler on 4/20/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface RestaurantDetailViewController : UIViewController
@property (strong, nonatomic) Restaurant *restaurant;
@property (strong, nonatomic) NSString *segueIdentifierUsed;

@end
