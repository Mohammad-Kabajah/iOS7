//
//  Card.h
//  PlayingCard
//
//  Created by Mohammad Kabajah on 8/9/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
