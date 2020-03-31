//
//  BounceViewBehaviour.h
//  Glutton
//
//  Created by Tyler Corley on 5/4/15.
//  Copyright (c) 2015 TylerCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BounceViewBehaviour : UIDynamicBehavior
- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;
@end
