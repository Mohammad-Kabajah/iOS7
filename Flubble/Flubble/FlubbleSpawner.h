//
//  FlubbleSpawner.h
//  Flubble
//
//  Created by Mohammad Kabajah on 8/27/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;

@interface FlubbleSpawner : NSObject

+ (SKNode * )planetNode;
+(SKNode *)flubbleNode;
+(SKNode *)enemyCircleWithRadius:(CGFloat)radius;

@end
