//
//  BatCharacter.h
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BatCharacter : UIImageView
{
    NSArray * imageArrayBatFlyUpDown;
    NSArray * imageArrayBatFlyRight;
    NSArray * imageArrayBatFlyLeft;
}
- (void)batFlyUpDown;
- (void)batFlyLeft;
- (void)batFlyRight;

@end
