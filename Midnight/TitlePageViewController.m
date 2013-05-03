//
//  TitlePageViewController.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "TitlePageViewController.h"
#import "GameViewController.h"
#import "HighScoresViewController.h"
#import "InstructionsViewController.h"

@interface TitlePageViewController ()

@end

@implementation TitlePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    [backGround setImage:[UIImage imageNamed:@"Graveyard.jpg"]];
    [backGround setAlpha:0.9];
    [[self view] addSubview:backGround];
    [[self view] sendSubviewToBack:backGround];
    [backGround release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToGamePage:(id)sender
{
    GameViewController *gameController = [[GameViewController alloc] init];
    [self presentViewController:gameController animated:NO completion:nil];
    [gameController release];
}

- (IBAction)goToHighScoresPage:(id)sender
{
    HighScoresViewController *highScoresController = [[HighScoresViewController alloc] init];
    [self presentViewController:highScoresController animated:NO completion:nil];
    [highScoresController release];
}

- (IBAction)goToInstructionsPage:(id)sender
{
    InstructionsViewController *howToController = [[InstructionsViewController alloc] init];
    [self presentViewController:howToController animated:NO completion:nil];
    [howToController release];
}

@end
