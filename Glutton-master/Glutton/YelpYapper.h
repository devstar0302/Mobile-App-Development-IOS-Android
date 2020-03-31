//
//  YelpYapper.h
//  Glutton
//
//  Created by Tyler on 4/2/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// Paths to yelp star assets
#define YELP_RATING_5 @"stars_large_5.png"
#define YELP_RATING_4_HALF @"stars_large_4_half.png"
#define YELP_RATING_4 @"stars_large_4.png"
#define YELP_RATING_3_HALF @"stars_large_3_half.png"
#define YELP_RATING_3 @"stars_large_3.png"
#define YELP_RATING_2_HALF @"stars_large_2_half.png"
#define YELP_RATING_2 @"stars_large_2.png"
#define YELP_RATING_1_HALF @"stars_large_1_half.png"
#define YELP_RATING_1 @"stars_large_1.png"

@interface YelpYapper : NSObject 

+ (NSArray *)getBusinesses;
+ (NSArray *)getBusinesses:(float)offsetFromCurrentLocation;
+ (NSArray *)getBusinessDetail:(NSArray *)ids;
+ (NSURLRequest *)searchRequest:(CLLocationCoordinate2D)coord withOffset:(long)offset;
+ (NSURL *)URLforRatingAsset:(NSString *)rating;
+ (NSString *)CategoryString:(NSArray *)categoryArray;
+ (NSString *)styledPhoneNumber:(NSString *)phoneNumber;

@end
