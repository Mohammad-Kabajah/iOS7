//
//  PlayingCard.h
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/9/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"
@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;


+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
