//
//  GameViewController.h
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BatCharacter.h"
#import "EnemyShyGuy.h"
#import "Cross.h"

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
    NSTimer *crossTimer;
    NSTimer *shyTimer;
    float valueX;
    BatCharacter *batFly;
    
    float dy;
    NSTimer *timer;
    BOOL game_over;
    
}
@property BOOL right;

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y;
@end
