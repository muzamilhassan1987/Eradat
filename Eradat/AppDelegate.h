//
//  AppDelegate.h
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    @public
        MFSideMenuContainerViewController *container;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MFSideMenuContainerViewController *mainContainer;


-(void)createSideMenu;
-(void)setCustomRootController;
-(void)setLoginRootController;
-(void)addSideMenuController;
-(void)removeSideMenuController;
-(void)createSideMenu:(MFSideMenuContainerViewController *) mainContainer ;
-(void)addSideMenuController:(MFSideMenuContainerViewController *) mainContainer;
-(void)removeSideMenuController:(MFSideMenuContainerViewController *) mainContainer;

@end

