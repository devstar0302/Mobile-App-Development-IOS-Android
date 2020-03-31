//
//  AudioCollectionViewController.m
//  AudioPlay
//
//  Created by dev on 1/1/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "AudioCollectionViewController.h"


@interface AudioCollectionViewController (){
    NSArray *backgroundImages;
    NSArray *audioImages;
    NSArray *audioTitle;
    
    NSString *strAudioFileName;
}

@end
#define CELL_WIDTH 150
#define CELL_SPACING 10
#define COLLECTIONVIEW_WIDTH 414
#define NUMBEROFCELLS 2
@implementation AudioCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
   
    // Do any additional setup after loading the view.

    audioImages = [NSArray arrayWithObjects:@"classical.jpg",
                   @"comedy.jpg",
                   @"decades.jpg",
                   @"dinner.jpg",
                   @"edm.jpg",
                   @"folk.jpg",
                   @"funk.jpg",
                   @"genre.jpg",
                   @"hip.jpg",
                   @"icon.jpg",
                   @"icon1.jpg",
                   @"icon2.jpg",
                   @"icon3.jpg",
                   @"indie.jpg",
                   @"jazz.jpg",
                   @"latin.jpg",
                   @"metal.jpg",
                   @"mood.jpg",
                   @"partyicon.jpg",
                   @"pop.jpg",
                   @"punk.jpg",
                   @"r-b.jpg",
                   @"reggae.jpg",
                   @"rock.jpg",
                   @"romance.jpg",
                   @"sleep.jpg",
                   @"sou.jpg",
                   @"travel.jpg",
                   @"trending.jpg",
                   @"workout.png",
                   @"yearinmusic.png",nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return audioImages.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *audioImageView = (UIImageView *)[cell viewWithTag:100];
    audioImageView.image = [UIImage imageNamed:[audioImages objectAtIndex:indexPath.row]];
   
    //PNG_Example_2.png
    //White image
   /* UIImageView *whiteImageView = (UIImageView *)[cell viewWithTag:4];
    whiteImageView.opaque = NO;
    whiteImageView.image = [UIImage imageNamed:@"PNG_Example_1.png"];
*/
    UILabel *label = (UILabel*)[cell viewWithTag:20];
    label.text = [audioImages objectAtIndex:indexPath.row];

    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSInteger _numberOfCells = NUMBEROFCELLS;
    NSInteger viewWidth = COLLECTIONVIEW_WIDTH;
    NSInteger totalCellWidth = CELL_WIDTH * _numberOfCells;
    NSInteger totalSpacingWidth = CELL_SPACING * (_numberOfCells -1);
    
    NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
    NSInteger rightInset = leftInset;
    
    return UIEdgeInsetsMake(0, leftInset, 0, rightInset);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //strAudioFileName = [audioImages objectAtIndex:indexPath.row];
     strAudioFileName = @"Baby_Crying";
    [self loadBeepSound];
    if (_audioPlayer) {
        [_audioPlayer play];
    }
    

}

-(void) loadBeepSound{
    NSString *beepFilePath = [[NSBundle mainBundle]  pathForResource:strAudioFileName ofType:@"mp3"];
    
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    
    if (error) {
        NSLog(@"Could not play beep file.");
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
