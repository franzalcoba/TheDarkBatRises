//
//  Cross.m
//  Midnight
//
//  Created by Ryan Flores on 5/7/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "Cross.h"

@implementation Cross

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float low_bound = 0;
        float high_bound = 480;
        float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
        int intRndValue = (int)(rndValue + 0.5);
    
        [self setFrame:CGRectMake(intRndValue, 0, 30, 48)];
        [self setImage:[UIImage imageNamed:@"cross.png"]];
    }
    return self;
}

@end
