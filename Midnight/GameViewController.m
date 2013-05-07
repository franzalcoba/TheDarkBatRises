//
//  GameViewController.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "GameViewController.h"
#import "TitlePageViewController.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define mainScreenRect CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)

#define bat_RADIUS 14
#define max_enemy   3
#define ASCEND_VALUE  25

enum{
    up = 0,
    down,
    left,
    right
};

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    valueX = acceleration.y*25.0;
    
    int newX = (int)(batFly.center.x + valueX);
    
    int limit_r = SCREEN_WIDTH - bat_RADIUS;
    int limit_l = 0 + bat_RADIUS;
    
    if (newX > limit_r)
        newX = limit_r;
    
    if (newX < limit_l)
        newX = limit_l;
    
   
    CGPoint newCenter = CGPointMake(newX, batFly.center.y);
    batFly.center = newCenter;
    
    if (valueX <= 0){
        if( ![batFly isAnimating] || batFly.flyDirection != left)
        {
            [batFly batFlyLeft];
            [[self view] addSubview:batFly];
            [batFly startAnimating];
        }
    } else {
        if( ![batFly isAnimating] || batFly.flyDirection != right)
        {
            [batFly batFlyRight];
            [[self view] addSubview:batFly];
            [batFly startAnimating];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(CGRect)getCurrentScreenBoundsDependOnOrientation
{
    CGRect screenBounds = self.view.frame;//[UIScreen mainScreen].bounds ;
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    game_over = FALSE;
    
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backGround setImage:[UIImage imageNamed:@"Graveyard.jpg"]];
    [backGround setAlpha:0.9];
    [[self view] addSubview:backGround];
    [backGround release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backToTitle:)
         forControlEvents:UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"return-button.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5.0, 5.0, 40.0, 40.0);
    [[self view] addSubview:backButton];
    backButton = nil;
    
    aTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(createEnemy:)
                                            userInfo:nil
                                             repeats:YES];
    
    //DISPLAY BAT CHARACTER
    batFly = [[BatCharacter alloc] initWithFrame: CGRectMake(CGRectGetMidX(mainScreenRect) - bat_RADIUS,CGRectGetMidY(mainScreenRect), 28, 28)];
    [batFly batFlyUpDown];
    [[self view] addSubview:batFly];
    
    //Setup accelerometer
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    dy = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(batDescend) userInfo:NULL repeats:YES];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //disable tapping on game over
    if(!game_over){
        UITouch *touch = [[event allTouches] anyObject];
    
        if (touch) {
            CGRect f = batFly.frame;
        
            if((f.origin.y - ASCEND_VALUE) <= 0)
                f.origin.y = 1;
            else
                f.origin.y -= ASCEND_VALUE;
        
            batFly.frame = CGRectOffset(f, 0, -1);
        }
    }
}

-(void)batDescend
{
    batFly.frame = CGRectOffset(batFly.frame, 0, dy);
    
    if (CGRectContainsRect(mainScreenRect, batFly.frame) == false) {
        NSLog(@"Deads");
        [timer invalidate];
        timer = nil;
        game_over = TRUE;
    }
}

-(IBAction)backToTitle:(id)sender
{
    TitlePageViewController *titlePage = [[TitlePageViewController alloc] init];
    [titlePage setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:titlePage animated:YES completion:nil];
    [titlePage release];
}

- (void)createEnemy:(NSTimer *) theTimer
{
    float low_bound = 0;
    float high_bound = 170;
    float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    int intRndValueFromRightToLeft = (int)(rndValue + 0.5);
    
    float low_bound2 = 0;
    float high_bound2 = 160;
    float rndValue2 = (((float)arc4random()/0x100000000)*(high_bound2-low_bound2)+low_bound2);
    
    
    int intRndValueFromLeftToRight = (int)(rndValue2 + 0.5);
    float randomDelay = 1 + random() % 8;
    int randomDirection = arc4random() % 2;
    
    if(randomDirection)
    {
        //Display enemy from left to right
        EnemyShyGuy *shyguy = [[EnemyShyGuy alloc] initWithFrame:CGRectMake(0, intRndValueFromRightToLeft, 42, 38)];
        [shyguy flyRight];
        
        [self moveImage:shyguy duration:randomDelay
                  curve:UIViewAnimationCurveLinear x:(self.view.bounds.size.width + 42) y:0.0];
        [[self view] addSubview:shyguy];
        //NSLog(@"random Y: %0.0f ------ delay: %0.0f", randomY, randomDelay);
        [shyguy release];
    }
    else
    {
        //Display enemy from right to left
        EnemyShyGuy *shyguy = [[EnemyShyGuy alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, intRndValueFromLeftToRight, 42, 38)];
        [shyguy flyLeft];
        
        [self moveImage:shyguy duration:randomDelay
                  curve:UIViewAnimationCurveLinear x:-(self.view.bounds.size.width + 42) y:0.0];
        [[self view] addSubview:shyguy];
        //NSLog(@"random Y: %0.0f ------ delay: %0.0f", randomY, randomDelay);
        [shyguy release];
    }
    
}

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[UIAccelerometer sharedAccelerometer]setDelegate:nil];
    [super dealloc];
    
}
-(void)viewDidUnload
{
    batFly = nil;
    [batFly release];
    [[UIAccelerometer sharedAccelerometer]setDelegate:nil];
}

@end
