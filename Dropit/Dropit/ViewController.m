//
//  ViewController.m
//  Dropit
//
//  Created by Mohammad Kabajah on 8/19/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) DropitBehavior *dropitBehavior;
@property (strong,nonatomic) UIAttachmentBehavior *attatchment;
@property (strong,nonatomic) UIView *droppingView;
@end

@implementation ViewController

-(UIDynamicAnimator *)animator{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

-(DropitBehavior *) dropitBehavior{
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc]init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompletedRows];
}

-(BOOL)removeCompletedRows{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc]init];
    for (CGFloat y = self.gameView.bounds.size.height-DROP_SIZE.height/2; y>0; y-=DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc]init];
        for (CGFloat x = DROP_SIZE.width/2; x<=self.gameView.bounds.size.width-DROP_SIZE.width/2; x+=DROP_SIZE.width) {
            UIView *hitview = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            
            if ([hitview superview] == self.gameView) {
                [dropsFound addObject:hitview];
            }
            else{
                rowIsComplete = NO;
                break;
            }
        }
        if (![dropsFound count])break;
        if (rowIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
    }
    
    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    
    
    return NO;
}


-(void)animateRemovingDrops:(NSArray *)dropsToRemove{
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             int x = (arc4random() % (int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished) {
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self attatchDroppingViewToPoint:gesturePoint];
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
        self.attatchment.anchorPoint = gesturePoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attatchment];
        self.gameView.path = nil;
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}


-(void) attatchDroppingViewToPoint:(CGPoint)anchorPoint{
    
    if (self.droppingView){
        self.attatchment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        UIView *droppingView = self.droppingView;
        __weak ViewController *weakSelf = self;
        self.attatchment.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc]init];
            [path moveToPoint:weakSelf.attatchment.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        
        self.droppingView = nil;
        [self.animator addBehavior:self.attatchment];
    }
}


static const CGSize DROP_SIZE = {40 , 40};

-(void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc]initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
//    [self.gravity addItem:dropView];
//    [self.collider addItem:dropView];
    self.droppingView = dropView;
    [self.dropitBehavior addItem:dropView];
    
}

-(UIColor *)randomColor{
    switch (arc4random()%5) {
        case 0:return [UIColor greenColor];
        case 1:return [UIColor blueColor];
        case 2:return [UIColor purpleColor];
        case 3:return [UIColor orangeColor];
        case 4:return [UIColor redColor];
    }
    return [UIColor blackColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
