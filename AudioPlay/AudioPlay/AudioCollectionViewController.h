//
//  AudioCollectionViewController.h
//  AudioPlay
//
//  Created by dev on 1/1/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioCollectionViewController : UICollectionViewController

    @property(nonatomic, strong) AVAudioPlayer *audioPlayer;
    -(void) loadBeepSound;

@end
