//
//  BaseController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import "ContactUsController.h"
#import "UIImageView+AFNetworking.h"
#import "SideMenuViewController.h"
#import "MapViewController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [self createUI];
    
    eCurrentPickerType = ePickerTypeNone;
    
    arrLanguageList = [[NSArray alloc] initWithObjects:@"English",@"العربية", nil];
    
    isLanguagePopUpShow = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLanguageBaseController:)
                                                 name:@"changeLanguageBaseController"
                                               object:nil];
}

- (void) changeLanguageBaseController:(NSNotification *) notification {
    
    NSLog(@"%@",notification);
//    [self localize];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) localize {
    
    
    for (id subview in self.view.subviews) {
        
        if ([subview isKindOfClass:[UITableView class]]) {
            //do nothing
        }
        else if ([subview subviews].count > 0) {
            
            [self iterateSubViewsForLocalization:subview];
        }
        else {
            [self applyTranslation:subview];
        }
    }
}

-(void) iterateSubViewsForLocalization:(UIView *) view {
    
    for (id subview in view.subviews) {
        
        if ([subview subviews].count > 0) {
            [self iterateSubViewsForLocalization:subview];
        }
        else {
            [self applyTranslation:subview];
        }
    }
}

-(void) applyTranslation:(UIView *) subview {
    
    NSTextAlignment alighment = singleton.isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    UIControlContentHorizontalAlignment buttonAlighment = singleton.isEnglish ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentRight;
    
    if ([subview isKindOfClass:[UITextField class]]) {
        
        if([(UITextField *)subview textAlignment] != NSTextAlignmentCenter)
            [(UITextField *)subview setTextAlignment:alighment];
        
    }
    else if ([subview isKindOfClass:[UILabel class]]) {
        
        if([(UILabel *)subview textAlignment] != NSTextAlignmentCenter)
            [(UILabel *)subview setTextAlignment:alighment];
    }
    else if ([subview isKindOfClass:[UIButton class]]) {
        
        if([(UIButton *)subview contentHorizontalAlignment] != UIControlContentHorizontalAlignmentCenter)
            [(UIButton *)subview setContentHorizontalAlignment:buttonAlighment];
    }
    else if ([subview isKindOfClass:[UITextView class]]) {
        
        if([(UITextView *)subview textAlignment] != NSTextAlignmentCenter)
            [(UITextView *)subview setTextAlignment:alighment];
    }
}

-(void)createUI {
    
    singleton.eCurrentTagController = eCurrentTagController;
    if (eCurrentTagController == eTagControllerSplash ||
        eCurrentTagController == eTagControllerLogin ||
        eCurrentTagController == eTagControllerRegister) {
        [[self navigationController] setNavigationBarHidden:YES animated:NO];
        return;
    }
//    if([self.navigationController.viewControllers count]>1)
  //      self.navigationItem.leftBarButtonItems = [self backArrowButtonWithTarget];
    
    //Dashbaord_topbar1
    else if (eCurrentTagController == eTagControllerUserDashBoardController) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        
//        if(singleton.isEnglish){
//            [self createTitleImage:@"dashboard_topbg"];
//        }
//        else {
//          [self createTitleImage:@"dashboard_topbg_ar"];
//        }
        [self createTitleImage:@"dashboard_topbg"];
        [self createNavigationItems];
    }
    else if (eCurrentTagController == eTagControllerContactUs) {
        
        [[self navigationController] setNavigationBarHidden:NO animated:NO];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createTitleImage:@"contact_topbg"];
        [self createNavigationItemsContactUs];
    }
    else if (eCurrentTagController == eTagControllerJourneyPlannerController) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createTitleImage:@"journey_topbg"];
        [self createNavigationItemsJourneyPlanner];
    }
    else if (eCurrentTagController == eTagControllerSetting) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createTitleImage:@"settings_topbg"];
        [self createNavigationItemsSetting];
    }
    else if (eCurrentTagController == eTagControllerOffer) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createTitleImage:@"offers_topbg"];
        [self createNavigationItemsOffer];
        
    }
    else if (eCurrentTagController == eTagControllerScheduleResult) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createNavigationItemsScheduleResult];
        [self createTitleImage:@"journey_topbg"];
    }
    else if (eCurrentTagController == eTagControllerFavourite) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createTitleImage:@"favourite_topbg"];
        [self createNavigationItemsFavourite];
    }
    else if (eCurrentTagController == eTagControllerMapView) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
//        [self createTitleImage:@"destinationsearch_topbg"];
        if ([(MapViewController *)self isFavourite]) {
            [self createTitleImage:@"favourite_topbg"];
        }
        else {
            [self createTitleImage:@"journey_topbg"];
        }

        [self createNavigationItemsScheduleResult];
    }
    else if (eCurrentTagController == eTagControllerChangePassword) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createNavigationItemsChangePassword];
        [self createTitleImage:@"settings_topbg"];
    }
    else if (eCurrentTagController == eTagControllerNotification) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        //[self createNavigationItemsNotificationsList];
        //[self createNavigationItemsOffer];
        [self createNavigationItemsJourneyPlanner];
        [self createTitleImage:@"notification_topbg"];
    }
    else if (eCurrentTagController == eTagControllerNotificationDetail) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"test_top.png"] forBarMetrics:UIBarMetricsDefault];
        [self createNavigationItemsJourneyPlanner];
        [self createTitleImage:@"notification_topbg"];
    }
    

}

-(void)createTitleImage:(NSString*)strName {
 
    NSLog(@"%d",eCurrentTagController);
    
    if(!singleton.isEnglish){
        strName = [NSString stringWithFormat:@"%@_ar",strName];
    }
    NSLog(@"TITLE NAME -- %@",strName);
//    NSString*  strName1 = @"journey_topbg_ar";
//    if ([strName isEqualToString:strName1]) {
//        NSLog(@"Match");
//    }
    
    UIImageView* imgVOld = (UIImageView*)[self.navigationController.navigationBar viewWithTag:10];
    if(imgVOld)
    {
        [imgVOld removeFromSuperview];
        imgVOld = nil;
    }
    UIImageView* topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strName]];
    [topImg setFrame:CGRectMake(0, 0, 165, 44)];
    [topImg setTag:10];
    [topImg setCenter:CGPointMake(SCREEN_SIZE.width/2, 22)];
    [self.navigationController.navigationBar addSubview: topImg];
    
}
-(void)createNavigationItemsNotifications {
    
    UIImage *buttonImageBack = [UIImage imageNamed:@"register_btnback"];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    //menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
}

-(void)createNavigationItemsChangePassword {
//
    UIImage *buttonImageBack = [UIImage imageNamed:@"register_btnback"];
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    //menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
}
-(void)createNavigationItemsScheduleResult{
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIImage *buttonImage1 = [UIImage imageNamed:@"register_btnback"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    //UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn1.frame = CGRectMake(0, 0, buttonImage1.size.width, buttonImage1.size.height);
    UIView *backButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView1.bounds = CGRectOffset(backButtonView1.bounds, 50, 0);
    [backButtonView1 addSubview:backBtn1];
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton,backButton1, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    if ([self isKindOfClass:[MapViewController class]]) {
        
        if ([(MapViewController*)self isFavourite]) {
            
            return;
        }
    }
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"journey_btnplanmodifier"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showRightJourneyPlanner:) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
    
}
-(void)createNavigationItemsNotificationsList {
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIImage *buttonImage1 = [UIImage imageNamed:@"register_btnback"];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);
    
    //    [backButtonView setBackgroundColor:[UIColor orangeColor]];
    
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn1.frame = CGRectMake(0, 0, buttonImage1.size.width, buttonImage1.size.height);
    UIView *backButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView1.bounds = CGRectOffset(backButtonView1.bounds, 50, 0);
    [backButtonView1 addSubview:backBtn1];
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton,backButton1, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
    
}
-(void)createNavigationItemsOffer {
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);
    
    //    [backButtonView setBackgroundColor:[UIColor orangeColor]];
    
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
}
-(void)createNavigationItems {

    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [backBtn setImage:buttonImage forState:UIControlStateNormal];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);

//    [backButtonView setBackgroundColor:[UIColor orangeColor]];
    
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
}
-(void)createNavigationItemsFavourite {
    

    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIImage *buttonImage1 = [UIImage imageNamed:@"register_btnback"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    //UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn1.frame = CGRectMake(0, 0, buttonImage1.size.width, buttonImage1.size.height);
    UIView *backButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView1.bounds = CGRectOffset(backButtonView1.bounds, 50, 0);
    [backButtonView1 addSubview:backBtn1];
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton,backButton1, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
}

-(void)createNavigationItemsContactUs {
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([(ContactUsController *)self navigatedFromLogin]) {
        
        buttonImage = [UIImage imageNamed:@"register_btnback"];
        [backBtn addTarget:self
                    action:@selector(gotoPreviousController)
          forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        
        [backBtn addTarget:self
                    action:@selector(showLeftMenuPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (![(ContactUsController *) self navigatedFromLogin]) {
        
        UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
        UIImage *buttonImage1 = [UIImage imageNamed:@"register_btnback"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        backBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
        backButtonView.bounds = CGRectOffset(backButtonView.bounds, 50, 0);
        [backButtonView addSubview:backBtn];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        
        //UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnmenu"];
        UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
        [backBtn1 addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
        
        backBtn1.frame = CGRectMake(0, 0, buttonImage1.size.width, buttonImage1.size.height);
        UIView *backButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
        backButtonView1.bounds = CGRectOffset(backButtonView1.bounds, 50, 0);
        [backButtonView1 addSubview:backBtn1];
        UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:0];
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton,backButton1, nil];
        self.navigationItem.leftBarButtonItems = myButtonArray;
        
    }
    else {
        
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:0];
        
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:negativeSpacer,backButton, nil];
        self.navigationItem.leftBarButtonItems = myButtonArray;
    }
    
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
}


-(void)createNavigationItemsMapView {
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIImage *buttonImageBack = [UIImage imageNamed:@"register_btnback"];
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [menuBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    
    [menuBtn addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    
}

-(void)createNavigationItemsSetting{
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnlang"];
//    UIImage *buttonImageBack = [UIImage imageNamed:@"register_btnback"];
    UIImage *buttonImageBack = [UIImage imageNamed:@"Dashbaord_btnmenu"];

    
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [menuBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIImage *buttonImage1 = [UIImage imageNamed:@"register_btnback"];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn1.frame = CGRectMake(0, 0, buttonImage1.size.width, buttonImage1.size.height);
    UIView *backButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, buttonImage.size.width+130, buttonImage.size.height)];
    backButtonView1.bounds = CGRectOffset(backButtonView1.bounds, 50, 0);
    [backButtonView1 addSubview:backBtn1];
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, backButton1, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"journey_btnplanmodifier"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showRightJourneyPlanner:) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
   // self.navigationItem.rightBarButtonItems = myButtonArray1;
}

-(void)createNavigationItemsJourneyPlanner{
    
    UIImage *buttonImage = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIImage *buttonImageBack = [UIImage imageNamed:@"Dashbaord_btnmenu"];
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backBtn setBackgroundColor:[UIColor yellowColor]];
    [menuBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    
    UIImage *buttonImageBackNew = [UIImage imageNamed:@"register_btnback"];
    
    UIButton *backBtnNew = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtnNew setBackgroundImage:buttonImageBackNew forState:UIControlStateNormal];
    [backBtnNew addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtnNew.frame = CGRectMake(0, 0, buttonImageBackNew.size.width, buttonImageBackNew.size.height);
    //menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_BackNew = [[UIBarButtonItem alloc] initWithCustomView:backBtnNew];
    //UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
//    return myButtonArray;
    
    NSLog(@"COUNT IS %ld",self.navigationController.viewControllers.count);
    if(self.navigationController.viewControllers.count>1) {
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back,customBarItem_BackNew, nil];
        self.navigationItem.leftBarButtonItems = myButtonArray;
    }
    else {
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
        self.navigationItem.leftBarButtonItems = myButtonArray;
    }
    
    
//    UIImage *buttonImageAdd = [UIImage imageNamed:@"journey_btnplanmodifier"];
//    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
//    [btnAdd addTarget:self action:@selector(showRightJourneyPlanner:) forControlEvents:UIControlEventTouchUpInside];
//    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
//    
//    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    [negativeSpacer1 setWidth:-5];
//    
//    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
   // self.navigationItem.rightBarButtonItems = myButtonArray1;
    
    
    
    UIImage *buttonImageAdd = [UIImage imageNamed:@"Dashbaord_btnlang"];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd setBackgroundImage:buttonImageAdd forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(showLanguage) forControlEvents:UIControlEventTouchUpInside];
    btnAdd.frame = CGRectMake(0, 0, buttonImageAdd.size.width, buttonImageAdd.size.height);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer1 setWidth:-5];
    
    NSArray *myButtonArray1 = [[NSArray alloc] initWithObjects:negativeSpacer1,addButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray1;
}


- (void)showLeftMenuPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
- (void)showRightJourneyPlanner:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}
- (void)changeLanguage {
}

-(void) viewDidAppear:(BOOL)animated
{
    if (!isExclusiveTouchMethodCall) {
        isExclusiveTouchMethodCall = YES;
        [self exclusiveTouchOn];
    }
    
    if (appDelegate->container) {
        
         SideMenuViewController *sideMenu = appDelegate->container.leftMenuViewController;
        
        [sideMenu setSelectedIndex:self];
    }
    [self setTopBarImage];
}

-(void) exclusiveTouchOn
{
    [BaseController setExclusiveTouchToChildrenOf:self.view.subviews];
    self.navigationItem.rightBarButtonItem.customView.exclusiveTouch = YES;
    self.navigationItem.leftBarButtonItem.customView.exclusiveTouch = YES;
}
+ (void)setExclusiveTouchToChildrenOf:(NSArray *)subviews
{
    for (UIView *v in subviews) {
        [self setExclusiveTouchToChildrenOf:v.subviews];
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)v;
            [btn setExclusiveTouch:YES];
        }
    }
}


-(NSArray*)backArrowButtonWithTarget {
    
    UIImage *buttonImageBack = [UIImage imageNamed:@"register_btnback"];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(gotoPreviousController) forControlEvents:UIControlEventTouchUpInside];
    
    backBtn.frame = CGRectMake(0, 0, buttonImageBack.size.width, buttonImageBack.size.height);
    //menuBtn.frame = CGRectMake(20, 0, buttonImage.size.width, buttonImage.size.height);
    
    UIBarButtonItem *customBarItem_Back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //UIBarButtonItem *customBarItem_Menu = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:customBarItem_Back, nil];
    return myButtonArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)gotoPreviousController {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadImageFromUrl:(NSString*)strLink ImageView:(UIImageView*)imgV{
    
    __weak UIImageView* imgView = imgV;
    [imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strLink]]
                   placeholderImage:nil
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                
                                [UIView transitionWithView:imgView
                                                  duration:0.2
                                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                                animations:^{
                                                    imgView.image = image;
                                                    
                                                }
                                                completion:NULL];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                            }];
    
}

-(void)showLanguage {
    
    NSLog(@"%@",self.view.subviews);
//    if(isLanguagePopUpShow)
//        return;
    for (UIView* view in self.view.subviews) {
        if([view isKindOfClass:[MMPickerView class]]) {
            return;
        }
    }
    
    isLanguagePopUpShow = YES;
    NSString* selectedString = nil;
    
    
  //  UILabel* lblLang = (UILabel*)[cell viewWithTag:2];
    if(singleton.isEnglish){
        selectedString = [arrLanguageList objectAtIndex:0];
    }
    else{
        selectedString = [arrLanguageList objectAtIndex:1];
    }

    [MMPickerView showPickerViewInView:self.navigationController.view
                           withStrings:arrLanguageList
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                isLanguagePopUpShow = NO;
                                if ([selectedString1 isEqualToString:@"English"]){
                                    [MCLocalization sharedInstance].language = @"en";
                                    singleton.isEnglish = YES;
                                }
                                else{
                                    [MCLocalization sharedInstance].language = @"ar";
                                    singleton.isEnglish = NO;
                                }
                               // [self createTitleImage:@"settings_topbg"];
                                [[NSNotificationCenter defaultCenter]
                                 postNotificationName:@"changeLanguageSideMenu"
                                 object:self];
                                
                                
                                [[NSNotificationCenter defaultCenter]
                                 postNotificationName:@"changeLanguageBaseController"
                                 object:self];
                            
                            }];
}

-(void) setTopBarImage {
    
    if (eCurrentTagController == eTagControllerSplash ||
        eCurrentTagController == eTagControllerLogin ||
        eCurrentTagController == eTagControllerRegister) {
        [[self navigationController] setNavigationBarHidden:YES animated:NO];
        return;
    }
    else if (eCurrentTagController == eTagControllerUserDashBoardController) {
    
        [self createTitleImage:@"dashboard_topbg"];

    }
    else if (eCurrentTagController == eTagControllerContactUs) {
        
        [self createTitleImage:@"contact_topbg"];

    }
    else if (eCurrentTagController == eTagControllerJourneyPlannerController) {

        [self createTitleImage:@"journey_topbg"];

    }
    else if (eCurrentTagController == eTagControllerSetting) {

        [self createTitleImage:@"settings_topbg"];

    }
    else if (eCurrentTagController == eTagControllerOffer) {

        [self createTitleImage:@"offers_topbg"];

        
    }
    else if (eCurrentTagController == eTagControllerScheduleResult) {


        [self createTitleImage:@"journey_topbg"];
    }
    else if (eCurrentTagController == eTagControllerFavourite) {

        [self createTitleImage:@"favourite_topbg"];

    }
    else if (eCurrentTagController == eTagControllerMapView) {

        //        [self createTitleImage:@"destinationsearch_topbg"];
        [self createTitleImage:@"journey_topbg"];

    }
    else if (eCurrentTagController == eTagControllerChangePassword) {


        [self createTitleImage:@"settings_topbg"];
    }
    else if (eCurrentTagController == eTagControllerNotification) {

        [self createTitleImage:@"notification_topbg"];
    }
    else if (eCurrentTagController == eTagControllerNotificationDetail) {


        [self createTitleImage:@"notification_topbg"];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
//    
    for (UIView* view in self.view.subviews) {
        if([view isKindOfClass:[MMPickerView class]]) {
            [MMPickerView dismissWithCompletion:nil];
        }
    }
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
