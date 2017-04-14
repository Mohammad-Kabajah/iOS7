//
//  FlubbleSpawner.m
//  Flubble
//
//  Created by Mohammad Kabajah on 8/27/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "FlubbleSpawner.h"
#import "FlubbleColors.h"
#import "INcompleteCircleNode.h"
#import "FlubleConstants.h"
@implementation FlubbleSpawner

#define PLANET_WIDTH 50
#define PLANET_GLOW_WIDTH 5.0

+(SKNode *)planetNode{
    SKShapeNode *node = [[SKShapeNode alloc]init];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, PLANET_WIDTH, PLANET_WIDTH)];
    
    node.path = [path CGPath];
    node.fillColor = [FlubbleColors planetColor];
    node.strokeColor = [FlubbleColors planetColor];
    node.glowWidth =PLANET_GLOW_WIDTH;
    
    
    NSString *particalePath = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *emitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:particalePath];
    emitterNode.position = CGPointMake(PLANET_WIDTH/2, PLANET_WIDTH/2);
    [node addChild:emitterNode];
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:PLANET_WIDTH/2];
    
    return node;
}

#define FLUBBLE_WIDTH 10
#define FLUBBLE_GLOW_WIDTH 1.0

+(SKNode *)flubbleNode{
    SKShapeNode *node = [[SKShapeNode alloc]init];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, FLUBBLE_WIDTH, FLUBBLE_WIDTH)];
    node.path = [path CGPath];
    node.fillColor =[FlubbleColors flubbleColor];
    node.strokeColor = [FlubbleColors flubbleColor];
    node.glowWidth = FLUBBLE_GLOW_WIDTH;
    
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:FLUBBLE_WIDTH/2];
    node.physicsBody.categoryBitMask = flubbleCategory;
    node.physicsBody.contactTestBitMask = enemyCategory;
    return node;
}


+(SKNode *)enemyCircleWithRadius:(CGFloat)radius{
    INcompleteCircleNode *node = [[INcompleteCircleNode alloc]initWithStartingRadius:radius
                                                                           holeAngle:M_PI /2.0];
    node.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:node.path];
    node.physicsBody.categoryBitMask = enemyCategory;
    node.physicsBody.contactTestBitMask = flubbleCategory;
    return node;
}

@end
