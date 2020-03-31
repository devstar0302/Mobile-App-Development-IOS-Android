//
//  SummaryViewController.m
//  Glutton
//
//  Created by Tyler Corley on 4/4/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "SummaryViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "BounceViewBehaviour.h"

@interface SummaryViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIView *rankBubble;
@property (weak, nonatomic) IBOutlet UIView *reviewBubble;
@property (weak, nonatomic) IBOutlet UIView *friendBubble;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsLabel;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) BounceViewBehaviour *bounceBehaviour;
@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.userPhoto.layer setCornerRadius:CGRectGetHeight(self.userPhoto.frame)/2.0];
    [self.userPhoto.layer setMasksToBounds:YES];
    [self.userPhoto.layer setBorderWidth:0.1];
    self.levelLabel.text = @"Level: Meh?";
    [self.levelLabel setFont:[UIFont fontWithName:@"Bariol-Bold" size:24]];
    
    [self.rankBubble setBackgroundColor:[UIColor colorWithRed:0.404 green:0.227 blue:0.718 alpha:1]];
    [self.rankBubble.layer setCornerRadius:CGRectGetHeight(self.rankBubble.frame)/2.0];
    [self.rankBubble.layer setMasksToBounds:YES];
    [self.reviewBubble setBackgroundColor:[UIColor colorWithRed:0 green:0.737 blue:0.831 alpha:1]];
    [self.reviewBubble.layer setCornerRadius:CGRectGetHeight(self.reviewBubble.frame)/2.0];
    [self.reviewBubble.layer setMasksToBounds:YES];
    [self.friendBubble setBackgroundColor:[UIColor colorWithRed:1 green:0.341 blue:0.133 alpha:1]];
    [self.friendBubble.layer setCornerRadius:CGRectGetHeight(self.friendBubble.frame)/2.0];
    [self.friendBubble.layer setMasksToBounds:YES];
    
    [self.rankLabel setText:@"Swiped"];
    [self.pointsLabel setText:@"Glutton\nPoints"];
    [self.friendsLabel setText:@"Rated"];
    
    // Animate the items onto the view
    [self.bounceBehaviour addItem:self.userPhoto];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bounceBehaviour addItem:self.reviewBubble];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bounceBehaviour addItem:self.rankBubble];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bounceBehaviour addItem:self.friendBubble];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.rankValueLabel.text = [NSString stringWithFormat:@"%lu",[defaults integerForKey:@"swipeCount"]];
    self.friendsValueLabel.text = [NSString stringWithFormat:@"%lu", [defaults integerForKey:@"rated"]];
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", [defaults objectForKey:@"name"] ?: @"User"];
    [self.navigationController.navigationBar.topItem setTitle:title];
    NSString *points = [NSString stringWithFormat:@"%lu", [defaults integerForKey:@"points"]];
    [self.pointsValueLabel setText:points];
    if([defaults objectForKey:@"name"]) {
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[defaults objectForKey:@"userimage"]]]];
        [operation setResponseSerializer:[AFImageResponseSerializer serializer]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.userPhoto.image = responseObject;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.userPhoto.image = [UIImage imageNamed:@"blankprofile"];
        }];
        [operation start];
    } else {
        self.userPhoto.image = [UIImage imageNamed:@"blankprofile"];
    }
    
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        _animator.delegate = self;
    }
    return _animator;
}

- (BounceViewBehaviour *)bounceBehaviour {
    if (!_bounceBehaviour) {
        _bounceBehaviour = [[BounceViewBehaviour alloc] init];
        [self.animator addBehavior:_bounceBehaviour];
    }
    return _bounceBehaviour;
}

@end
