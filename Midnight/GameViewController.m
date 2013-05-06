//
//  GameViewController.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/2/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "GameViewController.h"
#import "TitlePageViewController.h"

#define bat_RADIUS 15
#define max_enemy   3

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
    
    if (newX > 540 - bat_RADIUS)
        newX = 540 - bat_RADIUS;
    
    if (newX < 55 + bat_RADIUS)
        newX = 55 + bat_RADIUS;
    
   
    CGPoint newCenter = CGPointMake(newX, batFly.center.y);
    batFly.center = newCenter;
    
    if (valueX <= 0){
        if( ![batFly isAnimating] || batFly.flyDirection != left)
        {
            [batFly batFlyLeft];
            [[self view] addSubview:batFly];
            [batFly startAnimating];
            DLog(@"aw %d",newX);
        }
    } else {
        if( ![batFly isAnimating] || batFly.flyDirection != right)
        {
            [batFly batFlyRight];
            [[self view] addSubview:batFly];
            [batFly startAnimating];
            DLog(@"we");
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backToTitle:)
         forControlEvents:UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"return-button.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5.0, 5.0, 40.0, 40.0);
    [[self view] addSubview:backButton];
    backButton = nil;
    
    aTimer = [NSTimer scheduledTimerWithTimeInterval:6
                                              target:self
                                            selector:@selector(createEnemy:)
                                            userInfo:nil
                                             repeats:YES];

    //DISPLAY BAT CHARACTER
    batFly = [[BatCharacter alloc] initWithFrame:
                             CGRectMake(100, 125, 150, 130)];
    
    [batFly batFlyUpDown];
    [[self view] addSubview:batFly];
    
    //Setup accelerometer
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
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
    float randomY = arc4random() % (int)(self.view.bounds.size.height);
    float randomDelay = 1 + random() % 10;

    //NSLog(@"random Y: %0.0f ------ delay: %0.0f", randomY, randomDelay);
    int randomDirection = arc4random() % 2;
    
    if(randomDirection)
    {
        //Display enemy from left to right
        EnemyShyGuy *shyguy = [[EnemyShyGuy alloc] initWithFrame:CGRectMake(0, 150, 150, 150)];
        [shyguy flyRight];
        
        [self moveImage:shyguy duration:randomDelay
                  curve:UIViewAnimationCurveLinear x:(self.view.bounds.size.width + 150) y:0.0];
        [[self view] addSubview:shyguy];
        [shyguy release];
    }
    else
    {
        //Display enemy from right to left
        EnemyShyGuy *shyguy = [[EnemyShyGuy alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, 150, 150)];
        [shyguy flyLeft];
        
        [self moveImage:shyguy duration:randomDelay
                  curve:UIViewAnimationCurveLinear x:-(self.view.bounds.size.width + 150) y:0.0];
        [[self view] addSubview:shyguy];
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
