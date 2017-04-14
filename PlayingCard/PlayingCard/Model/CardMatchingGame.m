//
//  CardMatchingGame.m
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/10/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;//of Card


@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck*)deck{
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                //                self.cards[i] = card;
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}
//#define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNS = 4;
static const int COST_TO_CHOOSE = 1;

-(void) chooseCardAtIndex:(NSUInteger)Index{
    Card *card = [self cardAtIndex:Index];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BOUNS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -=COST_TO_CHOOSE;
            card.chosen=YES;
        }
    }
}

-(void) chooseCardAtIndex:(NSUInteger)Index
          andAnotherIndex:(NSUInteger)anotherIndex{
    Card *card = [self cardAtIndex:Index];
    Card *card2;
    if (anotherIndex ==-1) {
        card2 = nil;
    }
    else{
        card2 = [self cardAtIndex:anotherIndex];
    }
    
    if(!card.isMatched && !card2.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard,card2]];
                    if (matchScore && anotherIndex !=-1) {
                        self.score += matchScore * MATCH_BOUNS;
                        card.matched = YES;
                        card2.matched = YES;
                        otherCard.matched = YES;
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        card.chosen=NO;
                        card2.chosen=NO;
                        
                    }
                    break;
                }
            }
            self.score -=COST_TO_CHOOSE;
            card.chosen=YES;
            card2.chosen=YES;
        }
    }
    
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}

@end
