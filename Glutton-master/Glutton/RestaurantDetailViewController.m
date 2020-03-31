//
//  RestaurantDetailViewController.m
//  Glutton
//
//  Created by Tyler on 4/20/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "YelpYapper.h"
#import <MapKit/MapKit.h>
#import "MapPin.h"
#import <AFNetworking/AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "DetailEmbedTableViewController.h"
#import "StyledLabel.h"
#import <URBMediaFocusViewController/URBMediaFocusViewController.h>

@interface RestaurantDetailViewController () <MBProgressHUDDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *reviewCount;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rateButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (nonatomic) CLLocationCoordinate2D coord;
@property (strong, nonatomic) MBProgressHUD *loader;
@property (weak, nonatomic) IBOutlet StyledLabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet StyledLabel *ratingLabel;
@property (strong, nonatomic) URBMediaFocusViewController *imageView;

@end

@implementation RestaurantDetailViewController

static NSString * const imbiberyPath = @"http://tcorley.info:5000/reviewcheck";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:self.restaurant.name];
    //Don't show the rate button if the user hasn't swiped on it yet!
    if ([self.segueIdentifierUsed isEqualToString:@"cardDetail"]) {
        self.rateButton.style = UIBarButtonItemStylePlain;
        self.rateButton.enabled = false;
        self.rateButton.title = nil;
        //Don't show this on the swipe detail!
        self.verifyButton.hidden = YES;
        
    }
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 0);
    [self.rateButton setTitleTextAttributes:@{NSShadowAttributeName: shadow, NSFontAttributeName: [UIFont fontWithName:@"Bariol-Regular" size:20]} forState:UIControlStateNormal];
    
    NSDictionary *coordinate = [self.restaurant.location objectForKey:@"coordinate"];
    self.coord = CLLocationCoordinate2DMake([[coordinate objectForKey:@"latitude"] floatValue], [[coordinate objectForKey:@"longitude"] floatValue]);

    MKCoordinateSpan span = MKCoordinateSpanMake(0.008, 0.008);
    MKCoordinateRegion region = {self.coord, span};
    [self.map setRegion:region];
    [self.map addAnnotation:[[MapPin alloc] initWithCoordinates:self.coord
                                                      placeName:self.restaurant.name
                                                    description:[[self.restaurant.location objectForKey:@"address"] objectAtIndex:0]]];
    // For the restaurant image
    AFHTTPRequestOperation *imageRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.restaurant.imageURL stringByReplacingOccurrencesOfString:@"ms.jpg" withString:@"o.jpg"]]]];
    [imageRequestOperation setResponseSerializer:[AFImageResponseSerializer serializer]];
    [imageRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.restaurantImage.image = responseObject;
//        [self.restaurantImage setUserInteractionEnabled:NO];
        [self.restaurantImage setUserInteractionEnabled:YES];
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.restaurantImage addGestureRecognizer:imageTap];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Do something here
    }];
    [imageRequestOperation start];
    // For the rating image
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.restaurant.ratingURL]]];
    [requestOperation setResponseSerializer:[AFImageResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.ratingImage.image = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [requestOperation start];

    self.reviewCount.text = [self.restaurant.reviewCount stringValue];
    [self.reviewCountLabel setText:@"Review Count"];
    [self.ratingLabel setText:@"Rating "];
    [self.verifyButton.titleLabel setFont:[UIFont fontWithName:@"Bariol-Light" size:22]];
    
}

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    self.imageView = [[URBMediaFocusViewController alloc] init];
    [self.imageView showImage:self.restaurantImage.image fromRect:self.restaurantImage.frame];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedseg"]) {
        DetailEmbedTableViewController *embed = (DetailEmbedTableViewController *)[segue destinationViewController];
        [embed setRestaurant:self.restaurant];
    }
}

- (IBAction)goToYelp:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"userid"];
    if (userID) {
        //later, verify that they have inputed their user id
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Rate on Yelp?"
                                    message:@"Because of API restrictions, you cannot rate within another app.\n Come back here after you've rated and we'll continue from there 💁"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *go = [UIAlertAction
                             actionWithTitle:@"Open Yelp"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"yelp4:///biz/%@", self.restaurant.id]]];
                             }];
        UIAlertAction *no = [UIAlertAction
                             actionWithTitle:@"Maybe some other time"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:go];
        [alert addAction:no];
        
        //set variable to check in NSUserDefaults
        [self presentViewController:alert animated:YES completion:^{
            //do something here...
        }];
    } else {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Whoah there buddy 👮"
                                    message:@"You aren't \"logged in\" yet. You need to head on over to the settings page and enter your yelp info for me! (Summary Tab > Cog in top right > Yelp Account Name)" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"My bad..." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}

- (IBAction)openMaps:(id)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Open In Maps?"
                                message:[[self.restaurant.location objectForKey:@"address"] objectAtIndex:0] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *apple = [UIAlertAction
                         actionWithTitle:@"Apple Maps"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coord
                                                                            addressDictionary:nil];
                             MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
                             [item setName:self.restaurant.name];
                             [item openInMapsWithLaunchOptions:nil];
                         }];
    UIAlertAction *google = [UIAlertAction
                             actionWithTitle:@"Google Maps"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 NSString *urlString = [NSString stringWithFormat:@"comgooglemaps-x-callback://?q=%@&center=%f,%f&x-success=glutton://?resume=true&x-source=Glutton", [self.restaurant.name stringByReplacingOccurrencesOfString:@" " withString:@"+"],self.coord.latitude, self.coord.longitude];
                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                             }];
    UIAlertAction *nope = [UIAlertAction
                           actionWithTitle:@"Don't Do Anything"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action) {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           }];
    [alert addAction:apple];
    [alert addAction:google];
    [alert addAction:nope];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)verifyUserReview:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user = [defaults objectForKey:@"userid"];
    
    if (!user) {
        [self notifyWithResult:@"Hold it there! 👮" andMessage:@"You need to supply a user id before I can check for a rating! Do that in the settings page!" withButtonTitle:@"Alright then"];
        return;
    }
    //display an alertview with a loading indicator
    self.loader = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.loader.labelText = @"Verifying Review...";

    //make the network call to imbibery
    
    NSDictionary *params = @{
                             @"user_id": user,
                             @"restaurant": self.restaurant.id
                             };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:imbiberyPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject objectForKey:@"review"]) {
            NSUInteger pointsForReview = [[responseObject objectForKey:@"review"] length] / 2;
            [self notifyWithResult:@"Success ✅" andMessage:[NSString stringWithFormat:@"Successful Review! You'll get %lu points for this review:\n%@", pointsForReview, [responseObject objectForKey:@"review"]] withButtonTitle:@"Okay!"];
            [defaults setInteger:[defaults integerForKey:@"rated"] + 1 forKey:@"rated"];
            [defaults setInteger:[defaults integerForKey:@"points"] + pointsForReview forKey:@"points"];
        } else {
            [self notifyWithResult:@"Oops! 😲" andMessage:@"Couldn't find your post... could you check and make sure it was submitted correctly on Yelp and try again?" withButtonTitle:@"Yea, I guess so."];
        }
        [self.loader hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self notifyWithResult:@"Error...😭" andMessage:[NSString stringWithFormat:@"Whoops! Something went wrong:\n\n%@", error] withButtonTitle:@"Well that doesn't look good"];
        [self.loader hide:YES];
    }];
    //make alert with success
    //add the points to the nsuserdefaults
    //something with the ui (quickfix)
}

     - (void)notifyWithResult:(NSString *)result andMessage:(NSString *)message withButtonTitle:(NSString *)buttonTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:result message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
