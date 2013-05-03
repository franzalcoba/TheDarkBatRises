//
//  InstructionsViewController.m
//  Midnight
//
//  Created by Franz Carelle Alcoba on 5/3/13.
//  Copyright (c) 2013 Franz Carelle Alcoba. All rights reserved.
//

#import "InstructionsViewController.h"
#import "TitlePageViewController.h"

@interface InstructionsViewController ()

@end

@implementation InstructionsViewController

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
    [backGround setAlpha:0.4];
    [[self view] addSubview:backGround];
    [[self view] sendSubviewToBack:backGround];
    [backGround release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backToTitle:)
         forControlEvents:UIControlEventTouchDown];
    [backButton setImage:[UIImage imageNamed:@"return-button.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5.0, 5.0, 40.0, 40.0);
    [[self view] addSubview:backButton];
    backButton = nil;
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
    // Dispose of any resources that can be recreated.
}

@end
