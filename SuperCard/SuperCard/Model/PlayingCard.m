//
//  PlayingCard.m
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/9/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count]==1) {
        PlayingCard *othercard = [otherCards firstObject];
        if([self.suit isEqualToString:othercard.suit])
            score = 1;
        if(self.rank == othercard.rank)
            score = 4;
    }
    else if ([otherCards count]==2) {
        score = 1;
        PlayingCard *card1 = otherCards[0];
        PlayingCard *card2 = otherCards[1];
        if([self.suit isEqualToString:card1.suit]){
            score *= 2;
            if([self.suit isEqualToString:card2.suit]){
                score *= 2;
            }
        }
        else if ([self.suit isEqualToString:card2.suit]){
            score *=2;
        }
        if(self.rank == card1.rank){
            score *=2;
            if(self.rank == card2.rank){
                score *=2;
            }
        }
        else if(self.rank == card2.rank){
            score *=2;
        }
        if (score == 1) {
            score=0;
        }

    }
    
    
    
    return score;
}

@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }


- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



@end
