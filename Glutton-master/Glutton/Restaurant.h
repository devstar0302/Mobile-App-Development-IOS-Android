//
//  Restaurant.h
//  Glutton
//
//  Created by Tyler on 4/14/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSDictionary *location;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *ratingURL;
@property (strong, nonatomic) NSNumber *reviewCount;
@property (strong, nonatomic) NSString *snippetImageURL;
@property (strong, nonatomic) NSString *snippet;

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
                   snippet:(NSString *)snippet;


+ (NSDictionary *)serialize:(Restaurant *)restaurant;
+ (Restaurant *)deserialize:(NSDictionary *)r;
@end
