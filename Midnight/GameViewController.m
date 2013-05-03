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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
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
    
	batFly = [[BatCharacter alloc] initWithFrame:
                             CGRectMake(100, 125, 150, 130)];
    [batFly batFlyUpDown];
    [batFly setUserInteractionEnabled:YES];
    [[self view] addSubview:batFly];
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];

}


-(IBAction)backToTitle:(id)sender
{
    TitlePageViewController *titlePage = [[TitlePageViewController alloc] init];
    [titlePage setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:titlePage animated:YES completion:nil];
    [titlePage release];
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
