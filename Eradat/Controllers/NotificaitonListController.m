//
//  NotificaitonListController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/1/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "NotificaitonListController.h"
#import "NotificationDetailController.h"
#import "NSDate+Utilities.h"

@interface NotificaitonListController ()
{
    NSMutableDictionary *notificationsDictionary;
    NSArray *datesArray;
}
@end

@implementation NotificaitonListController

- (void)viewDidLoad {
    eCurrentTagController = eTagControllerNotification;
    [tblListing setBackgroundColor:[UIColor clearColor]];
    [tblListing setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [super viewDidLoad];
    isNotificationLoad = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [tblListing reloadData];
    }
}

-(void)localize {
    
    [self createTitleImage:@"notification_topbg"];
  //  [btnSchedule setTitle:[MCLocalization stringForKey:@"GET SCHEDULE"] forState:UIControlStateNormal];
    [super localize];
}

-(void)getDataFromServer {
    
    //checksum, userId, timestamp
    
    if(isNotificationLoad)
        return;
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@%@",TIMESTAMP,singleton.myAccountInfo.user.userId,API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    
    NSLog(@"%@",parameters);
    
    [SERVICE_MODEL getNotifications:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);
        isNotificationLoad = YES;
        arrNotificationList = [NotificationBase modelObjectWithDictionary:(NSDictionary *)response].notification;
        [self performSelectorOnMainThread:@selector(manageNotificationsAccordingToDate)
                               withObject:nil
                            waitUntilDone:true];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

-(void) manageNotificationsAccordingToDate {
    
    notificationsDictionary = [NSMutableDictionary dictionary];
    
    for (Notification *notification in arrNotificationList) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:notification.notifyCreated.doubleValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        
        NSString *dateString = [formatter stringFromDate:date];
        
        NSDate *date2 = [formatter dateFromString:dateString];
        
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[notificationsDictionary objectForKey:date2]];
        [temp addObject:notification];
        [notificationsDictionary setObject:temp forKey:date2];
    }
    datesArray = [[notificationsDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
       
        NSLog(@"%@ compare %@", obj1, obj2);
        return [(NSDate *)obj2 compare:obj1];
    }];
    
    NSLog(@"dates:%@", datesArray);
    [tblListing reloadData];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [datesArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 22.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    double width = [UIScreen mainScreen].bounds.size.width;
    double height = 22.0;
    CGRect frame = CGRectMake(5, 0, width - 10, height);
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15.0]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDate *date = [datesArray objectAtIndex:section];// [formatter dateFromString:[datesArray objectAtIndex:section]];
    
    if (singleton.isEnglish) {
        [label setTextAlignment:NSTextAlignmentLeft];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
    }
    else {
        [label setTextAlignment:NSTextAlignmentRight];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ar"]];
    }
    [label setTextColor:[UIColor whiteColor]];
    
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"[datesArray objectAtIndex:section]:%@", [datesArray objectAtIndex:section]);
    NSLog(@"date:%@", date);
    if ([date distanceInDaysToDate:[NSDate date]] == 0) {
        dateString = [MCLocalization stringForKey:@"Today"];
    }
    else if ([date distanceInDaysToDate:[NSDate date]] == 1) {
        dateString = [MCLocalization stringForKey:@"Yesterday" ];
    }
    
    
    
    [label setText:dateString];
    
    [view addSubview:label];
    return view;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  NSLog(@"COUNT IS %d",[arr_CardListing count]);
    return [[notificationsDictionary objectForKey:[datesArray objectAtIndex:section] ] count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [notificationsDictionary objectForKey:[datesArray objectAtIndex:indexPath.section]];
    
    Notification* notification = [array objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    
    UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
    UILabel* lblTime = (UILabel*)[cell viewWithTag:2];
    UILabel* lblDescription = (UILabel*)[cell viewWithTag:3];
    
    // double timestampval =  [[updates objectForKey:@"timestamp"] doubleValue]/1000;
    NSTimeInterval timestamp = (NSTimeInterval)[notification.notifyCreated doubleValue];
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"%@",updatetimestamp);
    
    NSString* strTime = [Utility timeFromDate:updatetimestamp];// [Utility prettyStringServerFromDate:updatetimestamp withServerDate:[NSDate date]];
    
    
    if (!singleton.isEnglish){
        [lblTitle setText:notification.notifyTitleAr];
        [lblTime setText:strTime];
        [lblDescription setText:notification.notifyMessageAr];
    }
    else{
        [lblTitle setText:notification.notifyTitleEn];
        [lblTime setText:strTime];
        [lblDescription setText:notification.notifyMessageEn];
    }
    
    
    [self iterateSubViewsForLocalization:cell.contentView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath");
//    [self performSegueWithIdentifier:@"EmbedNotificationDetail" sender:indexPath];
    NSArray *array = [notificationsDictionary objectForKey:[datesArray objectAtIndex:indexPath.section]];
    NotificationDetailController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"notificationDetailController"];
    detail.notificationDetail = [array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *path = [tblListing indexPathForSelectedRow];
    Notification* notification = [arrNotificationList objectAtIndex:path.row];
    if ([segue.identifier isEqualToString:@"EmbedNotificationDetail"]) {
        NotificationDetailController *mvc = [segue destinationViewController];
        mvc.notificationDetail = notification;
        
    }
}


@end
