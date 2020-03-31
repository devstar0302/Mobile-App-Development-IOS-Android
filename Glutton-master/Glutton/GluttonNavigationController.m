//
//  GluttonNavigationController.m
//  Glutton
//
//  Created by Tyler on 4/19/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "GluttonNavigationController.h"

@implementation GluttonNavigationController

- (void)viewDidLoad {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 0);
    [self.navigationBar setBarTintColor:[UIColor colorWithRed: 0.749 green: 0.341 blue: 0 alpha: 1]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Bariol-Bold" size:32],
                                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSShadowAttributeName: shadow}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationBar]
    
}

@end
