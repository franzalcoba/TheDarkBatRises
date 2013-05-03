//
//  BatCharacter.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "BatCharacter.h"

@implementation BatCharacter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArrayBatFlyUpDown  = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"1.png"],
                                   [UIImage imageNamed:@"2.png"],
                                   [UIImage imageNamed:@"3.png"],
                                   nil];
        imageArrayBatFlyLeft= [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:@"4.png"],
                               [UIImage imageNamed:@"5.png"],
                               [UIImage imageNamed:@"6.png"],
                               nil];
        imageArrayBatFlyRight  = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"7.png"],
                                  [UIImage imageNamed:@"8.png"],
                                  [UIImage imageNamed:@"9.png"],
                                  nil];
        
    }
    return self;
}

- (void)batFlyUpDown
{
    [self setAnimationImages:imageArrayBatFlyUpDown];
    [self setAnimationDuration:0.5];
    [self setContentMode:UIViewContentModeBottomLeft];
	[self startAnimating];
}

- (void)batFlyLeft
{
    [self setAnimationImages:imageArrayBatFlyLeft];
    [self setAnimationDuration:0.5];
    [self setContentMode:UIViewContentModeBottomLeft];
	[self startAnimating];
}

- (void)batFlyRight
{
    [self setAnimationImages:imageArrayBatFlyRight];
    [self setAnimationDuration:0.5];
    [self setContentMode:UIViewContentModeBottomLeft];
	[self startAnimating];    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
