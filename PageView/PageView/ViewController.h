//
//  ViewController.h
//  PageView
//
//  Created by dev on 12/19/15.
//  Copyright © 2015 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PageContentViewController.h"

@interface ViewController : UIViewController<UIPageViewControllerDataSource>



    @property(strong, nonatomic) UIPageViewController *pageViewController;
    @property(strong, nonatomic) NSArray *pageTitles;
    @property(strong, nonatomic) NSArray *pageImages;
- (IBAction)OnStartWalk:(id)sender;

@end

