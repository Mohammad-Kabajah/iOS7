//
//  INcompleteCircleNode.h
//  Flubble
//
//  Created by Mohammad Kabajah on 8/27/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface INcompleteCircleNode : SKShapeNode
-(instancetype)initWithStartingRadius:(CGFloat)radius
                            holeAngle:(CGFloat)holeAngle;

-(void)update;

@end
