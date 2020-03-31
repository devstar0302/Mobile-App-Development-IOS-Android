//
//  ChooseRestaurantView.m
//  Glutton
//
//  Created by Tyler on 4/14/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "ChooseRestaurantView.h"
#import "ImageLabelView.h"
#import "Restaurant.h"
#import <AFNetworking/AFNetworking.h>

static const CGFloat ChooseRestaurantViewImageLabelWidth = 42.f;

@interface ChooseRestaurantView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ImageLabelView *reviewersImageLabelView;
@property (nonatomic, strong) ImageLabelView *starImageLabelView;
@property (nonatomic, strong) UIActivityIndicatorView *picLoading;
@end

@implementation ChooseRestaurantView

- (instancetype)initWithFrame:(CGRect)frame restaurant:(Restaurant *)restaurant options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        
        
        [self setBackgroundColor:[UIColor grayColor]];
        _restaurant = restaurant;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleWidth  |
                                UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        self.picLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.picLoading setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
        [self.picLoading setHidesWhenStopped:YES];
        [self addSubview:self.picLoading];
        [self.picLoading startAnimating];
        [self setImageInBackground];
        
        [self constructInformationView];
        
    }
    return self;
}

- (void)setImageInBackground {
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.restaurant.imageURL stringByReplacingOccurrencesOfString:@"ms.jpg" withString:@"o.jpg"]]]];
    [requestOperation setResponseSerializer:[AFImageResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.picLoading stopAnimating];
        self.imageView.image = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.picLoading stopAnimating];
        self.imageView.image = [UIImage imageNamed:@"sample"];
    }];
    [requestOperation start];
}

- (void)constructInformationView {
    CGFloat bottomHeight = 60.f;
    CGRect bottomFrame = CGRectMake(0,
                                    CGRectGetHeight(self.bounds) - bottomHeight,
                                    CGRectGetWidth(self.bounds),
                                    bottomHeight);
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor whiteColor];
    _informationView.clipsToBounds = YES;
    _informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_informationView];
    
    [self constructNameLabel];
    [self constructReviewersImageLabelView];
    [self constructStarImageLabelView];
}

- (void)constructNameLabel {
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = 2.f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)/1.33),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
//    _nameLabel.font = [UIFont fontWithName:@"Lobster-Regular" size:29];
    _nameLabel.font = [UIFont fontWithName:@"Bariol-Bold" size:29];
    [_nameLabel setAdjustsFontSizeToFitWidth:YES];
    _nameLabel.text = _restaurant.name;
//    _nameLabel.shadowColor = [UIColor grayColor];
//    _nameLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    [_informationView addSubview:_nameLabel];
}

- (void)constructReviewersImageLabelView {
    CGFloat rightPadding = 10.f;
    UIImage *image = [UIImage imageNamed:@"user"];
    _reviewersImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetWidth(_informationView.bounds) - rightPadding image:image text:[_restaurant.reviewCount stringValue]];
    [_informationView addSubview:_reviewersImageLabelView];
}

- (void)constructStarImageLabelView {
    UIImage *image = [UIImage imageNamed:@"star"];
    
    _starImageLabelView = [self buildImageLabelViewLeftOf:CGRectGetMinX(_reviewersImageLabelView.frame) image:image text:_restaurant.rating];
    [_informationView addSubview:_starImageLabelView];
}

- (ImageLabelView *)buildImageLabelViewLeftOf:(CGFloat)x image:(UIImage *)image text:(NSString *)text {
    CGRect frame = CGRectMake(x - ChooseRestaurantViewImageLabelWidth, 0, ChooseRestaurantViewImageLabelWidth, CGRectGetHeight(_informationView.bounds));
    ImageLabelView *view = [[ImageLabelView alloc] initWithFrame:frame image:image text:text];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    return view;
}

@end
