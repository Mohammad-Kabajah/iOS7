//
//  DropitBehavior.m
//  Dropit
//
//  Created by Mohammad Kabajah on 8/19/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior()
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UICollisionBehavior *collider;
@property (strong,nonatomic) UIDynamicItemBehavior *animationOptions;

@end

@implementation DropitBehavior


#pragma mark -init

-(instancetype)init{
    
    self = [super init];
    
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.animationOptions];
    
    return self;
}
#pragma mark - Instantiations

-(UIDynamicItemBehavior *) animationOptions{
    if (!_animationOptions) {
        _animationOptions = [[UIDynamicItemBehavior alloc]init];
        _animationOptions.allowsRotation = NO;
//        _animationOptions.friction
//        _animationOptions.elasticity
//        _animationOptions.density
    }
    
    return _animationOptions;
}

-(UIGravityBehavior *)gravity{
    if (!_gravity){
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 0.9;
//        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

-(UICollisionBehavior *)collider{
    if(!_collider){
        _collider = [[UICollisionBehavior alloc]init];
        //        [_collider setTranslatesReferenceBoundsIntoBoundary:YES];
        _collider.translatesReferenceBoundsIntoBoundary=YES;
//        [self.animator addBehavior:_collider];
    }
    return _collider;
}


#pragma mark - Public API

-(void)addItem:(id <UIDynamicItem>)item{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
}


-(void)removeItem:(id <UIDynamicItem>)item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
}


@end
