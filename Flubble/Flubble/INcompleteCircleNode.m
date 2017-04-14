//
//  INcompleteCircleNode.m
//  Flubble
//
//  Created by Mohammad Kabajah on 8/27/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "INcompleteCircleNode.h"
#import "FlubbleColors.h"

@interface INcompleteCircleNode ()
@property (nonatomic,assign) CGAffineTransform rotation;
@property (nonatomic,assign) CGFloat holeAngle;
@property (nonatomic,assign) CGFloat currentRadius;

@end


@implementation INcompleteCircleNode

-(instancetype)initWithStartingRadius:(CGFloat)radius
                            holeAngle:(CGFloat)holeAngle{
    
    self = [super init];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:2*M_PI-self.holeAngle
                                                         clockwise:YES];
        self.currentRadius =radius;
        self.holeAngle = holeAngle;
        self.rotation = CGAffineTransformMakeRotation(arc4random());
        [path applyTransform:self.rotation];
        self.path = [path CGPath];
        self.fillColor = [SKColor clearColor];
        self.strokeColor = [self enemyColor];
        self.lineWidth = 1.5;
    }
    return self;
    
}

-(SKColor *)enemyColor{
    NSArray *colors = [FlubbleColors enemyColor];
    return colors[(int)arc4random() % [colors count]];
}


-(void)update{
    self.currentRadius *=0.99;
    UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                           radius:self.currentRadius
                                                       startAngle:0
                                                         endAngle:2.0*M_PI-self.holeAngle
                                                        clockwise:YES];
    [newPath applyTransform:self.rotation];
    self.path = [newPath CGPath];
}


@end
