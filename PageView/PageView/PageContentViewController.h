//
//  PageContentViewController.h
//  PageView
//
//  Created by dev on 12/19/15.
//  Copyright © 2015 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

    @property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
    @property (strong, nonatomic) IBOutlet UILabel *titleLabel;

    @property NSInteger pageIndex;
    @property NSString *titleText;
    @property NSString *imageFile;

@end
