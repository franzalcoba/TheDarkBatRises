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
    NSArray *imageArrayFlyLeft;
    NSArray *imageArrayFlyRight;
}
@property BOOL rightToLeft;

@end
