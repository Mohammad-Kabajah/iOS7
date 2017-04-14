//
//  ViewController.m
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/8/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()
//@property (nonatomic) int flipCount;
//@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
//@property (nonatomic, strong) Deck *deck;
@property (nonatomic,strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLable;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UISwitch *switchFlip;


//@property int tempIndex;
@end

@implementation ViewController
//
//-(NSInteger)tempIndex{
//    return (!_tempIndex) ? _tempIndex : nil;
//}

-(CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

//-(Deck *)deck{
//    if(!_deck) _deck = [self createDeck];
//    return _deck;
//}

-(Deck*)createDeck {
    return [[PlayingCardDeck alloc]init];
}

//-(void)setFlipCount:(int)flipCount{
//    _flipCount = flipCount;
//    self.flipsLable.text=[NSString stringWithFormat:@"Flips: %d",self.flipCount];
//    NSLog(@"flipcount  = %d",self.flipCount);
//}

int oldcard = -1;

- (IBAction)touchCardButton:(UIButton *)sender {
    int cardIndex = [self.cardButtons indexOfObject:sender];

    if (!self.switchFlip.isOn) {
        [self.game chooseCardAtIndex:cardIndex];
        [self updateUI];
        oldcard = cardIndex;
    }
    else{
        [self.game chooseCardAtIndex:cardIndex
         andAnotherIndex:oldcard];
        [self updateUI];
        oldcard = cardIndex;
    }
    
}
- (IBAction)newGameButton:(UIButton *)sender {
    self.modeSwitch.enabled=NO;
    self.game=nil;
    self.scoreLable.text = @"Score = 0";
    [self updateUI];
    self.modeSwitch.enabled=YES;
    
}
- (IBAction)SwitchKey:(UISwitch *)sender {
    if (sender.isOn) {
        self.gameModeLable.text = @"Game Mode 3 Matches";
    }else{
        self.gameModeLable.text = @"Game Mode 2 Matches";
    }
    
}

-(void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score = %d",self.game.score];
}

-(NSString *) titleForCard:(Card *)card{
    return card.isChosen ? card.contents:@"";
}

-(UIImage *) backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront":@"cardBack"];
}

/**
 //    PlayingCardDeck *pcd = [[PlayingCardDeck alloc]init];
 //     Card *c= [[PlayingCard alloc]init];
 
 if([sender.currentTitle length]){
 [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
 forState:UIControlStateNormal];
 [sender setTitle:@"" forState:UIControlStateNormal];
 //        self.flipCount++;
 
 }
 else {
 //c=[pcd drawRandomCard];
 Card *c =[self.deck drawRandomCard];
 if (c) {
 [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
 forState:UIControlStateNormal];
 [sender setTitle:c.contents forState:UIControlStateNormal];
 //            self.flipCount++;
 
 }
 //        NSLog(@"%@",c.contents);
 //        @"A♣︎"
 }
 **/

@end