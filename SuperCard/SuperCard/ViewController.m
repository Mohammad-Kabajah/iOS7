//
//  ViewController.m
//  SuperCard
//
//  Created by Mohammad Kabajah on 8/18/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong,nonatomic) Deck *deck;

@end

@implementation ViewController
-(Deck *)deck{
    if(!_deck) _deck = [[PlayingCardDeck alloc]init];
    return _deck;
}

-(void) drawRandomPlayingCard{
    Card *card = [self.deck drawRandomCard];
    if([card isKindOfClass:[PlayingCard class]]){
        PlayingCard *playingcard = (PlayingCard *)card;
        self.playingCardView.rank = playingcard.rank;
        self.playingCardView.suit = playingcard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if(!self.playingCardView.faceUp) [self drawRandomPlayingCard];
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.suit = @"❤️";
    self.playingCardView.rank=13;
    [self.playingCardView addGestureRecognizer: [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget:self.playingCardView
                                                                                         action:@selector(pinch:)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
