//
//  SummaryTitleLabel.m
//  Glutton
//
//  Created by Tyler Corley on 4/23/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "SummaryTitleLabel.h"

@implementation SummaryTitleLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setText:(NSString *)text {
    [super setText:text];
    [self setFont:[UIFont fontWithName:@"Bariol-Regular" size:23]];
    [self setTextColor:[UIColor whiteColor]];
    [self setShadowColor:[UIColor blackColor]];
    [self setShadowOffset:CGSizeMake(1, 0)];
}


@end
