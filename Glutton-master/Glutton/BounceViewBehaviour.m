//
//  BounceViewBehaviour.m
//  Glutton
//
//  Created by Tyler Corley on 5/4/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import "BounceViewBehaviour.h"

@interface BounceViewBehaviour()
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;

@end
@implementation BounceViewBehaviour

- (UIDynamicItemBehavior *) animationOptions {
    if (!_animationOptions) {
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = NO;
        _animationOptions.elasticity = 0.9f;
    }
    return _animationOptions;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}


- (UICollisionBehavior *)collider {
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
        [_collider addBoundaryWithIdentifier:@"bottom"
                                   fromPoint:CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - 50)
                                     toPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [[UIScreen mainScreen] bounds].size.height - 50)];
    }
    return _collider;
}

- (void)addItem:(id <UIDynamicItem>) item{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
}
- (void)removeItem:(id <UIDynamicItem>) item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
}

- (instancetype)init {
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.animationOptions];
    return self;
}
@end

