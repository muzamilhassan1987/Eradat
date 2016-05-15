//
//  AppDelegate.m
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "AppDelegate.h"
#import <Appsee/Appsee.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Appsee start:@"1be77b4a03b74a04acd211eb724cf71f"];
    [GMSServices provideAPIKey:@"AIzaSyCFvMHI_sWx8jTcS3qMkvrA6hRYqKKQoGs"];
    NSDictionary * languageURLPairs = @{
                                        @"en":[[NSBundle mainBundle] URLForResource:@"en.json" withExtension:nil],
                                        @"ar":[[NSBundle mainBundle] URLForResource:@"ar.json" withExtension:nil],
                                        };
    [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:@"en"];
    
    [MCLocalization sharedInstance].noKeyPlaceholder = @"[No '{key}' in '{language}']";
    
    if ([[MCLocalization sharedInstance].language isEqualToString:@"en"]){
        [singleton setIsEnglish:YES];
    }
    else {
        [singleton setIsEnglish:NO];
    }
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)setCustomRootController {
    
    
    if(!self.window)
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController =[storyboard instantiateViewControllerWithIdentifier:@"MFSideMenuContainerViewController"]; // determine the initial view controller here and instantiate it with [storyboard instantiateViewControllerWithIdentifier:<storyboard id>];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    [self createSideMenu];
}
-(void)setLoginRootController {
    
    
    if(!self.window)
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController =[storyboard instantiateViewControllerWithIdentifier:@"loginNavigationController"];
    
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
}
-(void)createSideMenu {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"menuNavigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    
    [container setLeftMenuViewController:leftSideMenuViewController];
   // [container setRightMenuViewController:rightSideMenuViewController];
    [container setCenterViewController:navigationController];
    container.panMode = MFSideMenuPanModeDefault;

    
}

-(void)createSideMenu:(MFSideMenuContainerViewController *) mainContainer {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //mainContainer = (MFSideMenuContainerViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"menuNavigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    
    [mainContainer setLeftMenuViewController:leftSideMenuViewController];
    // [container setRightMenuViewController:rightSideMenuViewController];
    [mainContainer setCenterViewController:navigationController];
    mainContainer.panMode = MFSideMenuPanModeDefault;
    
    container = mainContainer;
}

-(void)addSideMenuController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    [container setRightMenuViewController:rightSideMenuViewController];
}
-(void)removeSideMenuController {
    
    [container.rightMenuViewController removeFromParentViewController];
    container.rightMenuViewController = nil;
    [container setRightMenuViewController:nil];
    
}


-(void)addSideMenuController:(MFSideMenuContainerViewController *) mainContainer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    [container setRightMenuViewController:rightSideMenuViewController];
}
-(void)removeSideMenuController:(MFSideMenuContainerViewController *) mainContainer {
    [container.rightMenuViewController removeFromParentViewController];
    container.rightMenuViewController = nil;
    [container setRightMenuViewController:nil];
    
}

@end
