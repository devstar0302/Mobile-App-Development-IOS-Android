//
//  Restaurant.m
//  Glutton
//
//  Created by Tyler on 4/14/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (instancetype)initWithId:(NSString *)id
                      name:(NSString *)name
                categories:(NSArray *)categories
                     phone:(NSString *)phone
                  imageURL:(NSString *)imageURL
                  location:(NSDictionary *)location
                    rating:(NSString *)rating
                 ratingURL:(NSString *)ratingURL
               reviewCount:(NSNumber *)reviewCount
           snippetImageURL:(NSString *)snippetImageURL
                   snippet:(NSString *)snippet {
    self = [super init];
    if (self) {
        _id = id; //nonnull
        _name = name ?: @"Undefined";
        _categories = categories ?: @[@"None"];
        _phone = phone ?: @"";
        _imageURL = imageURL ?: @"http://www.mcie.edu.au/wp-content/uploads/2013/07/iStock_000016978975SmallMedium.jpg";
        _location = location;
        _rating = rating;
        _ratingURL = ratingURL;
        _reviewCount = reviewCount;
        _snippetImageURL = snippetImageURL ?: @"";
        _snippet = snippet ?: @"";
    }
    return self;
}

+ (NSDictionary *)serialize:(Restaurant *)restaurant {
    return @{
        @"id": restaurant.id,
        @"name": restaurant.name,
        @"categories": restaurant.categories,
        @"phone": restaurant.phone,
        @"imageURL": restaurant.imageURL,
        @"location": restaurant.location,
        @"rating": restaurant.rating,
        @"ratingURL": restaurant.ratingURL,
        @"reviewCount": restaurant.reviewCount,
        @"snippetImageURL": restaurant.snippetImageURL,
        @"snippet": restaurant.snippet
             };
}

+ (Restaurant *)deserialize:(NSDictionary *)r {
    return [[Restaurant alloc]
            initWithId:[r objectForKey:@"id"]
            name:[r objectForKey:@"name"]
            categories:[r objectForKey:@"categories"]
            phone:[r objectForKey:@"phone"]
            imageURL:[r objectForKey:@"imageURL"]
            location:[r objectForKey:@"location"]
            rating:[r objectForKey:@"rating"]
            ratingURL:[r objectForKey:@"ratingURL"]
            reviewCount:[r objectForKey:@"reviewCount"]
            snippetImageURL:[r objectForKey:@"snippetImageURL"]
            snippet:[r objectForKey:@"snippet"]];
}

@end
