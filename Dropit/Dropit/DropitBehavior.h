//
//  DropitBehavior.h
//  Dropit
//
//  Created by Mohammad Kabajah on 8/19/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

-(void)addItem:(id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;

@end
