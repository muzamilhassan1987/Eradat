//
//  ScheduleResultController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/26/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "ScheduleResultController.h"
#import "MapViewController.h"
#import <objc/runtime.h>
@interface ScheduleResultController ()

@end

@implementation ScheduleResultController
static char selectedBtn;
@synthesize dicData;
- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerScheduleResult;
    
    [super viewDidLoad];
    
    [tblListing setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblListing setBackgroundColor:[UIColor clearColor]];
    
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    [lblResult setText:[MCLocalization stringForKey:@"RESULT"]];
    
    
    [self getDataFromServer];
    [appDelegate addSideMenuController:nil];
    [super localize];
}
-(void)viewWillAppear:(BOOL)animated {
    eCurrentTagController = eTagControllerScheduleResult;
    [super viewWillAppear:YES];
    [self createTitleImage:@"journey_topbg"];
    

    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    
//    [appDelegate removeSideMenuController:nil];
}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
}


-(void)getDataFromServer {
    
    //checksum, userId, timestamp
    
//    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=1%@",TIMESTAMP,API_KEY];
//    NSLog(@"%@",check);
//    
//    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
//    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
//    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
//    [parameters insertObject:@"1" forKey:@"userId" atIndex:2];
//    
//    NSLog(@"%@",parameters);
    

    
    
    NSLog(@"%@",dicData);
//    NSString* checkSum = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkRegionId=%@fkCityId=%@%@",
//                          TIMESTAMP,singleton.myAccountInfo.user.userId,@"2",@"8",API_KEY];
//    
//    
//    dicData = [OrderedDictionary dictionary ];
//    [dicData insertObject:[checkSum.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
//    [dicData insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
//    [dicData insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
//    [dicData insertObject:@"2" forKey:@"fkRegionId" atIndex:3];
//    [dicData insertObject:@"8" forKey:@"fkCityId" atIndex:4];
    
  //  [dicData insertObject:@"2" forKey:@"fkRegionId" atIndex:3];
  //  [dicData insertObject:@"8" forKey:@"fkCityId" atIndex:4];
    
    //[dicData removeAllObjects];
    NSLog(@"params should be %@",dicData);
    [SERVICE_MODEL getJourneyPlan:dicData completionBlock:^(NSObject *response) {
        
//        NSLog(@"%@",response);
        [self performSelectorOnMainThread:@selector(loadScheduleResultsOnMainThread:)
                               withObject:response
                            waitUntilDone:true];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        [[[UIAlertView alloc] initWithTitle:[MCLocalization stringForKey:@"Error"] message:[MCLocalization stringForKey:[error localizedDescription]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        [SERVICE_MODEL hideProgressAlert];
    }];
    
}

-(void) loadScheduleResultsOnMainThread:( NSObject *) response {
    
    objAllJourneyDetail = [JourneyBase modelObjectWithDictionary:(NSDictionary *)response];
    if ([objAllJourneyDetail.journey count] == 0) {
        
        [[[UIAlertView alloc] initWithTitle:[MCLocalization stringForKey:@"Alert"] message:[MCLocalization stringForKey:@"No record found!"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    [tblListing reloadData];
    [SERVICE_MODEL hideProgressAlert];
}

-(void)getServiceData {
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 20;
//}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return [objAllJourneyDetail.journey count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
    
    UILabel *routeIDLabel = [cell viewWithTag:119];
    [routeIDLabel setText:journeyDetail.routeNumber];
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
    
//    [lblDays setNumberOfLines:2];
    
    NSLog(@"%@",[journeyDetail description]);
    [lblVacations setHidden:YES];
    [lblVacationsTitle setHidden:YES];
    [lblBusNo setText:journeyDetail.busLicenseNumber];
    [lblDriverName setText:journeyDetail.driverName];
    
    if(singleton.isEnglish){
        [lblLocFrom setText:journeyDetail.busStopFromTitleEn];
        [lblLocTo setText:journeyDetail.busStopToTitleEn];
    }
    else{
        [lblLocFrom setText:journeyDetail.busStopFromTitleAr];
        [lblLocTo setText:journeyDetail.busStopToTitleAr];
    }
    
    [lblDays setText:[journeyDetail.scheduleRecurringDays componentsJoinedByString:@", "]];
    
//    NSTimeInterval timestampDate = (NSTimeInterval)journeyDetail.scheduleEffectiveStartDate;
//    NSDate *StartDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//    
//    timestampDate = (NSTimeInterval)journeyDetail.scheduleEffectiveEndDate;
//    NSDate *EndDate = [NSDate dateWithTimeIntervalSince1970:timestampDate];
//    
//    
//    [lblVacations setText:@""];
//    [lblStartTime setText:[formatter stringFromDate:StartDate]];
//    [lblEndTime setText:[formatter stringFromDate:EndDate]];
    
    [lblStartTime setText:journeyDetail.scheduleEffectiveStartDateString];
    [lblEndTime setText:journeyDetail.scheduleEffectiveEndDateString];
    
    
    UIButton* btnRemindMe = (UIButton*)[cell viewWithTag:9];
    UIButton* btnFavourite = (UIButton*)[cell viewWithTag:10];
    [btnRemindMe addTarget:self action:@selector(remindMe:) forControlEvents:UIControlEventTouchUpInside];
    [btnFavourite addTarget:self action:@selector(Favourite:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(btnRemindMe, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(btnFavourite, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    
    [btnRemindMe setTitle:[MCLocalization stringForKey:@"REMIND ME"]
                 forState:UIControlStateNormal];
    [btnFavourite setTitle:[MCLocalization stringForKey:@"MARK AS FAVOURITE"]
                  forState:UIControlStateNormal];
    
    [self iterateSubViewsForLocalization:cell.contentView];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:indexPath.row];
    mapViewController.isFavourite = NO;
    mapViewController.journeyDetail = journeyDetail;
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

-(void)remindMe:(id)sender {
    
    UIButton* btn_Sender = (UIButton*)sender;
    //NSInteger tag = btn_Sender.tag;
    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
    Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:row];
    NSLog(@"%f",journeyDetail.scheduleId);
    
}
-(void)Favourite:(id)sender {
    //checksum, userId, fkscheduleId, timestamp
    UIButton* btn_Sender = (UIButton*)sender;
    //NSInteger tag = btn_Sender.tag;
    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
    Journey* journeyDetail = [objAllJourneyDetail.journey objectAtIndex:row];
    NSLog(@"%f",journeyDetail.scheduleId);
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkscheduleId=%.0f%@",TIMESTAMP, singleton.myAccountInfo.user.userId, journeyDetail.scheduleId, API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    [parameters insertObject:[NSString stringWithFormat:@"%.0f",journeyDetail.scheduleId] forKey:@"fkscheduleId" atIndex:3];
    NSLog(@"%@",parameters);
    
    [SERVICE_MODEL addFavourite:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);
        if ([[response valueForKey:@"status"] integerValue] == 200) {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Add To Favourite Successfully"])
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

-(void)gotoPreviousController {
    [appDelegate removeSideMenuController];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
