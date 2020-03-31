//
//  StyledLabel.m
//  Glutton
//
//  Created by Tyler Corley on 4/28/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "StyledLabel.h"

@implementation StyledLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setFont:[UIFont fontWithName:@"Bariol-Regular" size:18]];
}

@end
