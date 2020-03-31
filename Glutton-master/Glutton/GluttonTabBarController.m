//
//  GluttonTabBarController.m
//  Glutton
//
//  Created by Tyler on 4/19/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "GluttonTabBarController.h"

@implementation GluttonTabBarController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:1];
    [self.tabBar setTintColor:[UIColor colorWithRed: 0.749 green: 0.341 blue: 0 alpha: 1]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Bariol-Regular" size:[UIFont systemFontSize]], NSFontAttributeName, nil] forState:UIControlStateNormal];
}
@end
