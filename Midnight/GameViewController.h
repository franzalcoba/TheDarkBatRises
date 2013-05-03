//
//  GameViewController.h
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BatCharacter.h"

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
    float valueX;
    BatCharacter *batFly;
    
}
@property BOOL right;
@end
