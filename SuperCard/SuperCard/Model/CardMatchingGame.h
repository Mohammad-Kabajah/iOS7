//
//  CardMatchingGame.h
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/10/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck*)deck;

-(void) chooseCardAtIndex:(NSUInteger)Index;


-(void) chooseCardAtIndex:(NSUInteger)Index
          andAnotherIndex:(NSUInteger)anotherIndex;


-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;

@end
