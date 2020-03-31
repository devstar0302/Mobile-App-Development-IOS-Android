//
//  MapPin.m
//  Glutton
//
//  Created by Tyler on 4/22/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description {
    self = [super init];
    if (self) {
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}

@end
