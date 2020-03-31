//
//  AppDelegate.h
//  Glutton
//
//  Created by Tyler on 4/1/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Properties to pass between tabs (non-persistent)
@property (strong, nonatomic) NSArray *toRate;

@end

