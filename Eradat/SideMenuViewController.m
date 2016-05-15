//
//  SideMenuViewController.m
//  DeBusinessCard
//
//  Created by Muzamil Hassan on 12/05/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "UserDashBoardController.h"
#import "JourneyPlannerController.h"
#import "NotificaitonListController.h"
#import "OfferController.h"
#import "ContactUsController.h"
#import "SettingController.h"
#import "FavouriteController.h"
#import "UIImageView+AFNetworking.h"
#import "NotificaitonListController.h"
#import "ViewProfileController.h"

#define CELL_HEIGHT 35

typedef enum{
    eCellHome,
    eCellSearch,
    eCellAboutUs,
    eCellNotification,
    eCellTellFriend,
    eCellShare,
    eCellGenerateQR,
    eCellTerms,
    eCellChangePassword,
    eCellLogout,
}eTagCell;
@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    
//    NSMutableArray* arr = [[NSMutableArray alloc]initWithObjects:<#(id), ...#>, nil]
    arr_Data = [[NSMutableArray alloc]initWithObjects:
                [MCLocalization stringForKey:@"HOME"],
                [MCLocalization stringForKey:@"JOURNEY PLANNER"],
//                [MCLocalization stringForKey:@"DESTINATION SEARCH"],
                [MCLocalization stringForKey:@"NOTIFICATIONS"],
//                [MCLocalization stringForKey:@"OFFERS"],
                [MCLocalization stringForKey:@"CONTACT US"],
                [MCLocalization stringForKey:@"MY FAVOURITES"],
                [MCLocalization stringForKey:@"SETTINGS"],
//                [MCLocalization stringForKey:@"FEEDBACK FORM"],
                nil];
    arr_Images = [NSArray arrayWithObjects:@"sidemenu_btnhome",
                  @"sidemenu_btnjourney",
                  /*@"sidemenu_btndestination",*/
                  @"sidemenu_btnnotification",
//                  @"sidemenu_btnoffer",
                  @"sidemenu_btncontact",
                  @"sidemenu_btnfav",
                  @"sidemenu_btnsetting",
//                  @"sidemenu_btnfeedback",
                  nil];
    
    lastIndexPath = nil;
    [tblList setContentOffset:tblList.contentOffset animated:NO];
    [tblList setScrollEnabled:NO];
    
    imgProfile.layer.cornerRadius = imgProfile.frame.size.height /2;
    imgProfile.layer.masksToBounds = YES;
    imgProfile.layer.borderWidth = 0;
    
    [lblName setText:singleton.myAccountInfo.user.userFullName];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    if(!singleton.isEnglish)
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ar"]];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    [lblTime setText:[stringFromDate lowercaseString]];
    
    [formatter setDateFormat:@"EEEE,dd MMMM yyyy"];
    NSString *stringFromDate1 = [formatter stringFromDate:[NSDate date]];
    [lblDate setText:stringFromDate1];
    [self loadImageFromUrl:singleton.myAccountInfo.user.userPic ImageView:imgProfile];
    
    selectedIndex = 0;
    [singleton setIOfferCount:0];
    [singleton setINotificationCount:0];
//    [self getBubbleCounts];
    
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLanguageSideMenu:)
                                                 name:@"changeLanguageSideMenu"
                                               object:nil];
    
    
    [self performSelectorInBackground:@selector(getStaticEntities) withObject:nil];
}

- (void) changeLanguageSideMenu:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"changeLanguageSideMenu"]){
        [arr_Data removeAllObjects];
        [arr_Data addObject:[MCLocalization stringForKey:@"HOME"]];
        [arr_Data addObject:[MCLocalization stringForKey:@"JOURNEY PLANNER"]];
//        [arr_Data addObject:[MCLocalization stringForKey:@"DESTINATION SEARCH"]];
        [arr_Data addObject:[MCLocalization stringForKey:@"NOTIFICATIONS"]];
//        [arr_Data addObject:[MCLocalization stringForKey:@"OFFERS"]];
        [arr_Data addObject:[MCLocalization stringForKey:@"CONTACT US"]];
        [arr_Data addObject:[MCLocalization stringForKey:@"MY FAVOURITES"]];
        [arr_Data addObject:[MCLocalization stringForKey:@"SETTINGS"]];
//        [arr_Data addObject:[MCLocalization stringForKey:@"FEEDBACK FORM"]];
        
        [tblList reloadData];
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        if(!singleton.isEnglish)
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ar"]];
        NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
        [lblTime setText:[stringFromDate lowercaseString]];
        
        [formatter setDateFormat:@"EEEE,dd MMMM yyyy"];
        NSString *stringFromDate1 = [formatter stringFromDate:[NSDate date]];
        [lblDate setText:stringFromDate1];
    }
    
    
    NSLog (@"Successfully received the test notification!");
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [tblList reloadData];
}

-(IBAction)profileButtonPressed:(id)sender {

    ViewProfileController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"viewProfileController"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:controller];
//    navigationController.viewControllers = controllers;
    [navigationController.viewControllers.lastObject presentViewController:controller
                                                                  animated:YES
                                                                completion:nil];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

#pragma mark -
#pragma mark - UITableViewDataSource
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [NSString stringWithFormat:@"Section %d", section];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arr_Data count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    if (!lastIndexPath && indexPath.row == 0) {
        lastIndexPath = indexPath;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
  
    UIImageView* imgV_Icon = (UIImageView*)[cell viewWithTag:1];
    UIImageView* imgV_greemBg = (UIImageView*)[cell viewWithTag:3];
    UIImageView* imgV_Arrow = (UIImageView*)[cell viewWithTag:4];
    UILabel* lbl_Title = (UILabel*)[cell viewWithTag:2];
    
    UIImageView* imgV_Bubble = (UIImageView*)[cell viewWithTag:10];
    UILabel* lbl_Count = (UILabel*)[cell viewWithTag:11];
    
    if (indexPath.row != 2){
        [imgV_Bubble setHidden:YES];
        [lbl_Count setHidden:YES];
    }
    else {
        if (singleton.iNotificationCount == 0) {
            
            [imgV_Bubble setHidden:YES];
            [lbl_Count setHidden:YES];
        }
        else {
            
            [imgV_Bubble setHidden:NO];
            [lbl_Count setHidden:NO];
            
            [lbl_Count setText:[NSString stringWithFormat:@"%d", singleton.iNotificationCount]];
        }
        
//        else if (indexPath.row == 4){
//            [lbl_Count setText:[NSString stringWithFormat:@"%d", singleton.iOfferCount]];
//        }
    }
    
    [lbl_Title setText:[arr_Data objectAtIndex:indexPath.row]];
    
    if(indexPath.row == selectedIndex) {
        
        [imgV_Icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",[arr_Images objectAtIndex:indexPath.row]]]];
        [imgV_greemBg setHidden:NO];
        [imgV_Arrow setHidden:NO];
    }
    else {
        [imgV_Icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_unsel",[arr_Images objectAtIndex:indexPath.row]]]];
        [imgV_greemBg setHidden:YES];
        [imgV_Arrow setHidden:YES];
    }
    [self iterateSubViewsForLocalization:cell.contentView];

    return cell;
}
-(void)getBubbleCounts {
   
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@%@",TIMESTAMP,singleton.myAccountInfo.user.userId,API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    
    [SERVICE_MODEL getNotificationsCount:parameters completionBlock:^(NSObject *response) {

        
        NSLog(@"%@",parameters);
        
        [SERVICE_MODEL getOffersCount:parameters completionBlock:^(NSObject *response) {
            
            NSLog(@"DONE DONE DONE");
            
            
//            NSLog(@"%ld",singleton.iNotificationCount);
//            NSLog(@"%ld",singleton.iOfferCount);
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"BubbleCount"
             object:self];
            
            [tblList reloadData];
        } failureBlock:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        
        
        
    } failureBlock:^(NSError *error) {
        
        // NSLog(@"%@",error);
    }];
    
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

-(IBAction)facebook {
    NSLog(@"facebook");
}
-(IBAction)twitter {
   NSLog(@"twitter");
}
-(IBAction)linkedin {
    NSLog(@"linkedin");
}

-(void) setSelectedIndex:(UIViewController *) viewController {
    
    if ([viewController isKindOfClass:[UserDashBoardController class]]) {
        selectedIndex = 0;
    }
    else if ([viewController isKindOfClass:[JourneyPlannerController class]]) {
        selectedIndex = 1;
    }
    else if ([viewController isKindOfClass:[NotificaitonListController class]]) {
        selectedIndex = 2;
    }
    else if ([viewController isKindOfClass:[ContactUsController class]]) {
        selectedIndex = 3;
    }
    else if ([viewController isKindOfClass:[FavouriteController class]]) {
        selectedIndex = 4;
    }
    else if ([viewController isKindOfClass:[SettingController class]]) {
        selectedIndex = 5;
    }
    else if ([viewController isKindOfClass:[UserDashBoardController class]]) {
        selectedIndex = 6;
    }
    else if ([viewController isKindOfClass:[UserDashBoardController class]]) {
        selectedIndex = 7;
    }
    lastIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [tblList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(lastIndexPath){
        UITableViewCell* lastSelectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:lastIndexPath];
        UIImageView* imgV_Black = (UIImageView*)[lastSelectedCell.contentView viewWithTag:3];
        [imgV_Black setHidden:YES];
        
        UIImageView* imgV_Arrow = (UIImageView*)[lastSelectedCell viewWithTag:4];
        [imgV_Arrow setHidden:YES];
        
        
        UIImageView* imgV_Icon = (UIImageView*)[lastSelectedCell.contentView viewWithTag:1];
        [imgV_Icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_unsel",[arr_Images objectAtIndex:lastIndexPath.row]]]];
    }
    else {
        
    }
    UITableViewCell* selectedCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    lastIndexPath = nil;
    lastIndexPath = indexPath;
    UIImageView* imgV_BlackCurrent = (UIImageView*)[selectedCell viewWithTag:3];
    [imgV_BlackCurrent setHidden:NO];
    UIImageView* imgV_Arrow1 = (UIImageView*)[selectedCell viewWithTag:4];
    [imgV_Arrow1 setHidden:NO];
    UIImageView* imgV_Icon = (UIImageView*)[selectedCell viewWithTag:1];
    [imgV_Icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",[arr_Images objectAtIndex:lastIndexPath.row]]]];
    
    
    switch (indexPath.row) {
        case 0:
        {
            UserDashBoardController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"userDashBoardController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//            NSArray *controllers = [NSArray arrayWithObject:controller];
//            navigationController.viewControllers = controllers;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[UserDashBoardController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
            
        case 1:
        {
            JourneyPlannerController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"journeyPlannerController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[JourneyPlannerController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
          break;
        }
        /*case 2: // for search destination
            break;*/
        case 2:
        {
            NotificaitonListController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"notificaitonListController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *count = [cell viewWithTag:11];
            [count setText:@"0"];
            singleton.iNotificationCount = 0;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[NotificaitonListController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case -1:
        {
            OfferController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"offerController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[OfferController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case 3:
        {
            ContactUsController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"contactUsController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[ContactUsController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case 4:
        {
            FavouriteController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"favouriteController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[FavouriteController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
        case 5:
        {
            SettingController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"settingController"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            if(![navigationController.viewControllers.lastObject isKindOfClass:[SettingController class]]) {
                
                [navigationController pushViewController:controller animated:YES];
            }
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
        }
            
    
    
}
    
}




-(void)dealloc {
    NSLog(@"SIDE MENU DEALLOC");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) getStaticEntities {
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@%@",TIMESTAMP,API_KEY];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       TIMESTAMP,@"timestamp",
                                       [check.MD5Hash lowercaseString],@"checksum",
                                       nil];
    
    [SERVICE_MODEL getStaticEntities:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);\
        StaticEntities* objStaticEntities = [StaticEntities modelObjectWithDictionary:(NSDictionary *)response];
        singleton.staticEntities = objStaticEntities;
        //[self getServiceTypeFromServer];
        
        
    } failureBlock:^(NSError *error) {
        
    }];
}


@end
