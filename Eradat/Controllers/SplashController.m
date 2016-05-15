//
//  SplashController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "SplashController.h"
#import "LoginController.h"
@implementation SplashController

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

    
}
-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self performSelector:@selector(gotoMainController) withObject:nil afterDelay:5.0];
}
-(void) gotoMainController {
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavigationController"];

    nav.view.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.navigationController.view.alpha = 0;
        nav.view.alpha = 1;
        [appDelegate.window setRootViewController:nav];
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
