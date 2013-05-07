//
//  EnemyShyGuy.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "EnemyShyGuy.h"

@implementation EnemyShyGuy
@synthesize rightToLeft;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float low_bound = -130;
        float high_bound = 170;
        float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
        int intRndValueFromRightToLeft = (int)(rndValue + 0.5);
        
        float low_bound2 = -140;
        float high_bound2 = 160;
        float rndValue2 = (((float)arc4random()/0x100000000)*(high_bound2-low_bound2)+low_bound2);
        int intRndValueFromLeftToRight = (int)(rndValue2 + 0.5);
        
        int randomDirection = arc4random() % 2;
        
        if(randomDirection) {
            
            rightToLeft = NO;
            //Display enemy from left to right
            [self setFrame:CGRectMake(0, intRndValueFromRightToLeft, 42, 38)];
            
            imageArrayFlyLeft  = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"shy-3.png"],
                                  [UIImage imageNamed:@"shy-4.png"],
                                  nil];
            
            [self setAnimationImages:imageArrayFlyLeft];
            [self setAnimationDuration:0.5];
            [self setContentMode:UIViewContentModeBottomLeft];
            [self startAnimating];

        } else {
            
            rightToLeft = YES;
            //Display enemy from right to left
            [self setFrame:CGRectMake(480, intRndValueFromLeftToRight, 42, 38)];
            
            imageArrayFlyRight  = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"shy-1.png"],
                                  [UIImage imageNamed:@"shy-2.png"],
                                  nil];
            
            [self setAnimationImages:imageArrayFlyRight];
            [self setAnimationDuration:0.5];
            [self setContentMode:UIViewContentModeBottomRight];
            [self startAnimating];

        }
    }
    return self;
}

-(void)dealloc
{
    [imageArrayFlyLeft release];
    [imageArrayFlyRight release];
    [super dealloc];
}

@end
