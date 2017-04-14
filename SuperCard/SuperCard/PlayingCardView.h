//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Mohammad Kabajah on 8/18/15.
//  Copyright (c) 2015 Mohammad Kabajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property(nonatomic) NSUInteger rank;
@property(nonatomic,strong) NSString *suit;
@property(nonatomic)BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
