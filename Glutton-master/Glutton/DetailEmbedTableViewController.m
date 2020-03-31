//
//  DetailEmbedTableViewController.m
//  Glutton
//
//  Created by Tyler Corley on 4/28/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "DetailEmbedTableViewController.h"
#import "YelpYapper.h"
#import "StyledLabel.h"

@interface DetailEmbedTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *snippetLabel;
@property (weak, nonatomic) IBOutlet StyledLabel *cLabel;
@property (weak, nonatomic) IBOutlet StyledLabel *pLabel;
@property (weak, nonatomic) IBOutlet StyledLabel *aLabel;

@end

@implementation DetailEmbedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Style the static text
    [self.cLabel setText:@"Categories"];
    [self.pLabel setText:@"Phone Number"];
    [self.aLabel setText:@"Address"];
    
    //add the dynamic information
    [self.categoryLabel setText:[YelpYapper CategoryString:self.restaurant.categories]];
    [self.categoryLabel setAdjustsFontSizeToFitWidth:YES];
    [self.phoneNumberLabel setTitle:[YelpYapper styledPhoneNumber:self.restaurant.phone] forState:UIControlStateNormal];
    [self.addressLabel setText:[[self.restaurant.location objectForKey:@"address"] objectAtIndex:0]];
    [self.phoneNumberLabel.titleLabel setFont:[UIFont fontWithName:@"Bariol-Regular" size:15]];
    [self.snippetLabel setText:self.restaurant.snippet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)callBiz:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", self.restaurant.phone]];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
