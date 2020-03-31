//
//  RestaurantCell.m
//  Glutton
//
//  Created by Tyler on 4/20/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

- (void)setRestaurantNameLabel:(UILabel *)restaurantNameLabel {
    _restaurantNameLabel = restaurantNameLabel;
    [_restaurantNameLabel setFont:[UIFont fontWithName:@"Bariol-Regular" size:14]];
    [_restaurantNameLabel setTextColor:[UIColor whiteColor]];
    [_restaurantNameLabel setBackgroundColor:[UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:0.5]];
}

@end
