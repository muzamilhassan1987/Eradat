//
//  SettingController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/29/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "SettingController.h"
#import "ChangePasswordController.h"
#import "ViewProfileController.h"
@interface SettingController ()

@end

@implementation SettingController

- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerSetting;
    [super viewDidLoad];
    
    [tblSetting setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblSetting setBackgroundColor:[UIColor clearColor]];
    arrLanguage = [[NSArray alloc] initWithObjects:@"English",@"العربية", nil];
    
    // Do any additional setup after loading the view.
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) {
        return 30;
    }
    else if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7){
        return 46;
    }
    else {
        return 10;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell;
    if (indexPath.row ==  1) {
        
       // cell  = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
        cell  = [tableView dequeueReusableCellWithIdentifier:@"langCell" forIndexPath:indexPath];
        UILabel* lblLangTitle = (UILabel*)[cell viewWithTag:1];
        UILabel* lblLang = (UILabel*)[cell viewWithTag:2];
        
        [lblLangTitle setText:[MCLocalization stringForKey:@"CHANGE LANGUAGE"]];
        if (singleton.isEnglish){
            [lblLang setText:[arrLanguage objectAtIndex:0]];
        }
        else{
            [lblLang setText:[arrLanguage objectAtIndex:1]];
        }
        
    }
    else if (indexPath.row == 3) {
        
        cell  = [tableView dequeueReusableCellWithIdentifier:@"passwordCell" forIndexPath:indexPath];
        UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
        [lblTitle setText:[MCLocalization stringForKey:@"CURRENT PASSWORD"]];
    }
    
    else if (indexPath.row == 5) {
        
        cell  = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
        UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
//        [lblTitle setText:[MCLocalization stringForKey:@"CURRENT PASSWORD"]];
        [lblTitle setText:[MCLocalization stringForKey:@"PROFILE"]];
        
    }
    
    else if (indexPath.row == 7){
        cell  = [tableView dequeueReusableCellWithIdentifier:@"logoutCell" forIndexPath:indexPath];
        UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
        [lblTitle setText:[MCLocalization stringForKey:@"LOGOUT"]];
    }
    else {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
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
    
    
    [self iterateSubViewsForLocalization:cell.contentView];
    
    return cell;
}

-(IBAction)test{
    ViewProfileController *viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"viewProfileController"];
    
    [self presentViewController:viewObj animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
    if(indexPath.row == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self showLanguagePicker:cell];
    }
    if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"EmbedChangePassword" sender:nil];
    }
    if (indexPath.row == 5) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"ShowProfile" sender:nil];
        });
       // UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
   
       // [self.navigationController pushViewController:viewObj animated:YES];
        
       // [self performSegueWithIdentifier:@"ShowProfile" sender:nil];
    
    }
    if (indexPath.row == 7) {
        
        [[[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:[MCLocalization stringForKey:@"Are you sure you want to logout"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"No"] otherButtonTitles:[MCLocalization stringForKey:@"Yes"], nil] show];
        
    }
    
    
//    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
//    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

-(void)showLanguagePicker:(UITableViewCell*)cell {
    
    if(isLanguagePopUpShow)
        return;
    
    
    UILabel* lblLang = (UILabel*)[cell viewWithTag:2];
    if(singleton.isEnglish){
        selectedString = [arrLanguage objectAtIndex:0];
    }
    else{
        selectedString = [arrLanguage objectAtIndex:1];
    }
    [MMPickerView showPickerViewInView:self.view
                           withStrings:arrLanguage
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
                                
                                NSLog(@"COMPLETE");
                                selectedString = selectedString1;
                                lblLang.text = selectedString;
                                
                                if ([selectedString1 isEqualToString:@"English"]){
                                    [MCLocalization sharedInstance].language = @"en";
                                    singleton.isEnglish = YES;
                                }
                                else{
                                    [MCLocalization sharedInstance].language = @"ar";
                                    singleton.isEnglish = NO;
                                }
                                [self createTitleImage:@"settings_topbg"];
                                [[NSNotificationCenter defaultCenter]
                                 postNotificationName:@"changeLanguageSideMenu"
                                 object:self];
                                [tblSetting reloadData];
                            }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"EmbedChangePassword"]) {
        ChangePasswordController *mvc = [segue destinationViewController];
        
    }
}


@end
