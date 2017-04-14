//
//  GameScene.m
//  Flubble
//
//  Created by Mohammad Kabajah on 8/27/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "GameScene.h"
#import "FlubbleSpawner.h"

@interface GameScene ()<SKPhysicsContactDelegate>
@property (strong,nonatomic) SKNode *flubbleNode;
@property (strong,nonatomic) SKNode *planetNode;
@property (nonatomic) CGFloat flubbleAngle;
@property (nonatomic) CGFloat flubbleOrbitRadius;
@property (nonatomic) CGPoint flubbleSpeed;
@property (nonatomic,strong) NSMutableArray *enemies;

@end

@implementation GameScene

-(NSMutableArray*)enemies{
    if(!_enemies){
        _enemies = [NSMutableArray array];
    }
    return _enemies;
}


-(void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)]];
    
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)gesture{
    self.flubbleSpeed = [gesture velocityInView:self.view];
    
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"Contact detected");
//    contact.bodyA.node
    
}


#define FLUBBLE_PLABET_OFFSET 50

-(id)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        SKNode *planetNode = [FlubbleSpawner planetNode];
        planetNode.position = CGPointMake(-CGRectGetMidX(planetNode.frame),
                                          -CGRectGetMidY(planetNode.frame));
//                                          -planetNode.frame.size.width/2, -planetNode.frame.size.height/2);
        [self addChild:planetNode];
        
        self.planetNode = planetNode;
        self.flubbleNode = [FlubbleSpawner flubbleNode];
        self.flubbleAngle = 0.0;
        self.flubbleOrbitRadius = planetNode.frame.size.width/2 + self.flubbleNode.frame.size.width/2 + FLUBBLE_PLABET_OFFSET;
        
        [planetNode addChild:self.flubbleNode];
        
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(addEnemy:)
                                       userInfo:nil
                                        repeats:YES];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}

-(void)addEnemy:(NSTimer *)timer {

    SKNode *newEnemy = [FlubbleSpawner enemyCircleWithRadius:self.size.width];
    [self.enemies addObject:newEnemy];
    [self addChild:newEnemy];
    
}

/*
-(void)didMoveToView:(SKView *)view {
    // Setup your scene here
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}
*/

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Called when a touch begins
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}
*/
#define  DECELERATION_FACTOR 1.1
#define GESTURE_TO_SPEED_FACTOR 2000

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    self.flubbleSpeed = CGPointMake(self.flubbleSpeed.x / DECELERATION_FACTOR, self.flubbleSpeed.y);
    self.flubbleAngle += self.flubbleSpeed.x / GESTURE_TO_SPEED_FACTOR;
    
    
    self.flubbleNode.position = CGPointMake(self.flubbleOrbitRadius*cos(self.flubbleAngle) + [self planetWidth]/2 - [self flubbleWidth]/2,
                                            self.flubbleOrbitRadius*sin(self.flubbleAngle) + [self planetWidth]/2 -[self flubbleWidth]/2);
    [self.enemies makeObjectsPerformSelector:@selector(update)];
}

-(CGFloat)planetWidth {
    return self.planetNode.frame.size.width;
}

-(CGFloat)flubbleWidth{
    return self.flubbleNode.frame.size.width;
}
@end
