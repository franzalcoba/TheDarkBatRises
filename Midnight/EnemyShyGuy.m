//
//  EnemyShyGuy.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "EnemyShyGuy.h"

@implementation EnemyShyGuy

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArrayFlyLeft  = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"shy-1.png"],
                                   [UIImage imageNamed:@"shy-2.png"],
                                   nil];

    }
    return self;
}

- (void)flyLeft
{
    [self setAnimationImages:imageArrayFlyLeft];
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
