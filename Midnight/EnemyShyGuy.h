//
//  EnemyShyGuy.h
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnemyShyGuy : UIImageView
{
    NSTimer *aTimer;
    NSArray *imageArrayFlyLeft;
    NSArray *imageArrayFlyRight;
}
- (void)flyLeft;
- (void)flyRight;
@end
