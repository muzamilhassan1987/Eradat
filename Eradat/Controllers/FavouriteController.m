//
//  FavouriteController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/2/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "FavouriteController.h"
#import "MapViewController.h"
#import "RMUniversalAlert.h"
#import <objc/runtime.h>

@interface FavouriteController ()

@end

@implementation FavouriteController
static char selectedBtn;
- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerFavourite;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [tblListing setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblListing setBackgroundColor:[UIColor clearColor]];
    
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self getDataFromServer];
}

- (void) changeLanguageBaseController:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"%@",notification);
    if ([[notification name] isEqualToString:@"changeLanguageBaseController"]){
        
        NSLog(@"%@",notification);
        [self localize];
        [self createTitleImage:@"favourite_topbg"];
        [tblListing reloadData];
    }
}

-(void)getDataFromServer {
    
    //checksum, userId, timestamp
    
        NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@%@",TIMESTAMP,singleton.myAccountInfo.user.userId,API_KEY];
        NSLog(@"%@",check);
    
        OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
        [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
        [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
        [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    
        NSLog(@"%@",parameters);
    
    
    [SERVICE_MODEL getFavourite:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);
        favouriteDetail = [BaseFavourite modelObjectWithDictionary:(NSDictionary *)response];
        arrListing = [favouriteDetail.favoriteschedule mutableCopy];
        [tblListing reloadData];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) {
        return 20;
    }
    else{
        return 83;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrListing.count+1;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Favoriteschedule* favourite = nil;
    
    UITableViewCell* cell;
    if (indexPath.row == 0) {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
        return cell;
    }
    else {
       cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        favourite = [arrListing objectAtIndex:indexPath.row-1];
    }
    
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
    
//    NSLog(@"%@",[favourite description]);
    UILabel *routeIDLabel = [cell viewWithTag:119];
    [routeIDLabel setText:favourite.routeNumber];
    [routeIDLabel.layer setCornerRadius:3.0];
    [routeIDLabel setClipsToBounds:YES];
    
    UILabel* lblBusNo = (UILabel*)[cell viewWithTag:eJourneyCellLblBusNo];
    UILabel* lblDriverName = (UILabel*)[cell viewWithTag:eJourneyCellLblDriverName];
    UILabel* lblLocFrom = (UILabel*)[cell viewWithTag:eJourneyCellLblLocFrom];
    UILabel* lblLocTo = (UILabel*)[cell viewWithTag:eJourneyCellLblLocTo];
    UILabel* lblDays = (UILabel*)[cell viewWithTag:eJourneyCellLblDays];
    UILabel* lblVacations = (UILabel*)[cell viewWithTag:eJourneyCellLblVacations];
    UILabel* lblStartTime = (UILabel*)[cell viewWithTag:eJourneyCellLblStartTime];
    UILabel* lblEndTime = (UILabel*)[cell viewWithTag:eJourneyCellLblEndTime];
    
    
    UILabel* lblBusNoTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblBusNo+100];
    UILabel* lblDriverNameTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblDriverName+100];
    UILabel* lblLocFromTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblLocFrom+100];
    UILabel* lblLocToTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblLocTo+100];
    UILabel* lblDaysTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblDays+100];
    UILabel* lblVacationsTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblVacations+100];
    UILabel* lblStartTimeTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblStartTime+100];
    UILabel* lblEndTimeTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblEndTime+100];
    
    if (!singleton.isEnglish) {
        
        lblBusNo = (UILabel*)[cell viewWithTag:eJourneyCellLblBusNo +100];
        lblDriverName = (UILabel*)[cell viewWithTag:eJourneyCellLblDriverName +100];
        lblLocFrom = (UILabel*)[cell viewWithTag:eJourneyCellLblLocFrom +100];
        lblLocTo = (UILabel*)[cell viewWithTag:eJourneyCellLblLocTo +100];
        lblDays = (UILabel*)[cell viewWithTag:eJourneyCellLblDays +100];
        lblVacations = (UILabel*)[cell viewWithTag:eJourneyCellLblVacations +100];
        lblStartTime = (UILabel*)[cell viewWithTag:eJourneyCellLblStartTime +100];
        lblEndTime = (UILabel*)[cell viewWithTag:eJourneyCellLblEndTime +100];
        
        lblBusNoTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblBusNo];
        lblDriverNameTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblDriverName];
        lblLocFromTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblLocFrom];
        lblLocToTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblLocTo];
        lblDaysTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblDays];
        lblVacationsTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblVacations];
        lblStartTimeTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblStartTime];
        lblEndTimeTitle = (UILabel*)[cell viewWithTag:eJourneyCellLblEndTime];
    }

    [lblBusNoTitle setText:[MCLocalization stringForKey:@"Bus #:"]];
    [lblDriverNameTitle setText:[MCLocalization stringForKey:@"Driver Name:"]];
    [lblLocFromTitle setText:[MCLocalization stringForKey:@"Location From:"]];
    [lblLocToTitle setText:[MCLocalization stringForKey:@"Location To:"]];
    [lblDaysTitle setText:[[MCLocalization stringForKey:@"Days:"] stringByAppendingString:@"\n "]];
    [lblVacationsTitle setText:[MCLocalization stringForKey:@"Vacations:"]];
    [lblStartTimeTitle setText:[MCLocalization stringForKey:@"Start Time:"]];
    [lblEndTimeTitle setText:[MCLocalization stringForKey:@"End Time:"]];
    
    
    [lblBusNo setText:favourite.busLicenseNumber];
    [lblDriverName setText:favourite.driverName];
    
    if(singleton.isEnglish){
        [lblLocFrom setText:favourite.busStopFromTitleEn];
        [lblLocTo setText:favourite.busStopToTitleEn];
    }
    else{
        [lblLocFrom setText:favourite.busStopFromTitleAr];
        [lblLocTo setText:favourite.busStopToTitleAr];
    }
    
    [lblDays setText:[favourite.scheduleRecurringDays componentsJoinedByString:@", "]];
    
//    NSTimeInterval timestampDate = (NSTimeInterval)favourite.scheduleEffectiveStartDate;
//    NSDate *StartDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//    
//    timestampDate = (NSTimeInterval)favourite.scheduleEffectiveEndDate;
//    NSDate *EndDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
    
    
    [lblVacations setText:@""];
    [lblStartTime setText:favourite.scheduleEffectiveStartDateString];
    [lblEndTime setText:favourite.scheduleEffectiveEndDateString];
    
    
    UIButton* btnRemindMe = (UIButton*)[cell viewWithTag:9];
    UIButton* btnFavourite = (UIButton*)[cell viewWithTag:10];
    [btnRemindMe addTarget:self action:@selector(remindMe:) forControlEvents:UIControlEventTouchUpInside];
    [btnFavourite addTarget:self action:@selector(removeFromFavourite:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(btnRemindMe, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(btnFavourite, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    
    [btnRemindMe setTitle:[MCLocalization stringForKey:@"REMIND ME"] forState:UIControlStateNormal];
    [btnFavourite setTitle:[MCLocalization stringForKey:@"REMOVE"] forState:UIControlStateNormal];
    
    
    [self iterateSubViewsForLocalization:cell.contentView];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    Favoriteschedule* favourite = [arrListing objectAtIndex:indexPath.row-1];
    mapViewController.isFavourite = YES;
    mapViewController.favourite = favourite;
    mapViewController.journeyDetail = favourite;
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

-(void)remindMe:(id)sender {
 
    UIButton* btn_Sender = (UIButton*)sender;
    //NSInteger tag = btn_Sender.tag;
    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
    //Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:row];
    
}
-(void)removeFromFavourite:(id)sender {
    
    UIButton* btn_Sender = (UIButton*)sender;
    //NSInteger tag = btn_Sender.tag;
    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
    NSLog(@"%ld",(long)row);
    
    Favoriteschedule* favourite = [arrListing objectAtIndex:row-1];
    
    [RMUniversalAlert showAlertInViewController:self withTitle:[MCLocalization stringForKey:@"Alert"] message:[MCLocalization stringForKey:@"Are you sure, you want to remove favorite?"] cancelButtonTitle:[MCLocalization stringForKey:@"No"] destructiveButtonTitle:nil otherButtonTitles:@[[MCLocalization stringForKey:@"Yes"]] tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex) {
        
        if (buttonIndex != alert.cancelButtonIndex) {
            
            NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkscheduleId=%.0f%@",TIMESTAMP,singleton.myAccountInfo.user.userId,favourite.scheduleId,API_KEY];
            NSLog(@"%@",check);
            
            OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
            [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
            [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
            [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
            [parameters insertObject:[NSString stringWithFormat:@"%.0f",favourite.scheduleId] forKey:@"fkscheduleId" atIndex:3];
            
            NSLog(@"%@",parameters);
            
            [SERVICE_MODEL deleteFavourite:parameters completionBlock:^(NSObject *response) {
                
                NSLog(@"%@",response);
                if ([[response valueForKey:@"status"] integerValue] == 200) {
                    [arrListing removeObjectAtIndex:row-1];
                    [tblListing reloadData];
                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Delete From Favourite Successfully"])
                }
                
            } failureBlock:^(NSError *error) {
                
                NSLog(@"%@",error);
            }];
        }
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
