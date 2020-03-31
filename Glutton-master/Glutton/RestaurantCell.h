//
//  RestaurantCell.h
//  Glutton
//
//  Created by Tyler on 4/20/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface RestaurantCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *picLoading;
@end
