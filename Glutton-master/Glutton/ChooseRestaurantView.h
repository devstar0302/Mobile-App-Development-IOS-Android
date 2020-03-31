//
//  ChooseRestaurantView.h
//  Glutton
//
//  Created by Tyler on 4/14/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChooseView.h>

@class Restaurant;

@interface ChooseRestaurantView : MDCSwipeToChooseView

@property (nonatomic, strong, readonly) Restaurant *restaurant;

- (instancetype)initWithFrame:(CGRect)frame
                   restaurant:(Restaurant *)restaurant
                      options:(MDCSwipeToChooseViewOptions *)options;

@end
