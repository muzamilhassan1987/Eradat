//
//  SideMenuViewController.h
//  DeBusinessCard
//
//  Created by Muzamil Hassan on 12/05/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
@interface SideMenuViewController : BaseController
{
    NSMutableArray* arr_Data;
    NSArray* arr_Images;
    NSIndexPath* lastIndexPath;
    __weak IBOutlet UITableView* tblList;
    __weak IBOutlet UIImageView* imgProfile;
    __weak IBOutlet UILabel* lblName;
    __weak IBOutlet UILabel* lblTime;
    __weak IBOutlet UILabel* lblDate;
    NSInteger selectedIndex;
}

-(void) setSelectedIndex:(UIViewController *) viewController;
@end
