//
//  CollectionViewController.m
//  Glutton
//
//  Created by Tyler Corley on 4/4/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "CollectionViewController.h"
#import "AppDelegate.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import <AFNetworking/AFNetworking.h>
#import "RestaurantDetailViewController.h"
#import "GluttonNavigationController.h"

@interface CollectionViewController () <UIViewControllerPreviewingDelegate>
@property (strong, nonatomic) NSMutableArray *restaurantsToRate;
@property (strong, nonatomic) NSMutableArray *restaurantsRated;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[RestaurantCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view.
    self.restaurantsRated = [[NSMutableArray alloc] init];
    [self registerForPreviewingWithDelegate:(id)self sourceView:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:nil];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
//    self.restaurantsToRate = [((AppDelegate *)[[UIApplication sharedApplication] delegate]).toRate mutableCopy];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![self.restaurantsToRate isEqualToArray:[defaults objectForKey:@"seendictionary"]]) {
        self.restaurantsToRate = [defaults objectForKey:@"seendictionary"];
        [self.collectionView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.restaurantsToRate count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *restaurant = [self.restaurantsToRate objectAtIndex:indexPath.row];
    
    // Configure the cell
    [cell.picLoading setHidesWhenStopped:YES];
    [cell.picLoading startAnimating];
    [cell setBackgroundColor:[UIColor grayColor]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[restaurant objectForKey:@"imageURL"] stringByReplacingOccurrencesOfString:@"ms.jpg" withString:@"o.jpg"]]]];
    [requestOperation setResponseSerializer:[AFImageResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [cell.picLoading stopAnimating];
        cell.imageView.image = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [cell.picLoading stopAnimating];
        cell.imageView.image = [UIImage imageNamed:@"sample"];
    }];
    [requestOperation start];
    cell.restaurantNameLabel.text = [restaurant objectForKey:@"name"];
    [cell.contentView sendSubviewToBack:cell.imageView];
    
    return cell;
}

- (NSMutableArray *)restaurantsToRate {
    return _restaurantsToRate ?: [[NSMutableArray alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"restaurantDetail"]) {
        RestaurantDetailViewController *detail = (RestaurantDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        [detail setRestaurant:[Restaurant deserialize:[self.restaurantsToRate objectAtIndex:indexPath.row]]];
        [detail setSegueIdentifierUsed:segue.identifier];
    }
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if ([self.presentedViewController isKindOfClass:[RestaurantDetailViewController class]]) {
        return nil;
    }
    if (CGRectContainsPoint([self.view convertRect:self.collectionView.frame fromView:self.collectionView.superview], location)) {
        CGPoint locationInTableview = [self.collectionView convertPoint:location fromView:self.view];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationInTableview];
        if (indexPath) {
            UICollectionViewLayoutAttributes *cellAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
            [previewingContext setSourceRect:cellAttributes.frame];
            RestaurantDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"restaurantDetail"];
            [detail setRestaurant:[Restaurant deserialize:[self.restaurantsToRate objectAtIndex:indexPath.row]]];
            return detail;
        }
    }
    
    return nil;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    RestaurantDetailViewController *detail = (RestaurantDetailViewController *)viewControllerToCommit;
    [detail setSegueIdentifierUsed:@"other"];
    
    [self showViewController:detail sender:self];
}


@end
