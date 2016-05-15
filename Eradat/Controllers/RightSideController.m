//
//  RightSideController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/4/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "RightSideController.h"

#import "ScheduleResultController.h"
#import <objc/runtime.h>
#import "IQUIView+Hierarchy.h"
@interface RightSideController ()

@end

@implementation RightSideController
static char myIndexPath;
static char myTextField;
static char selectedBtn;
static char labelTitle;
- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerJourneyPlannerController;
    isInitialDataLoad = NO;
    
    [super viewDidLoad];
    
    arrDestination = [NSMutableArray new];
    arrPlistData = [Utility getPlistValuesArray:@"JourneyPlanner"];
    dicFieldValueDictionary = [NSMutableDictionary dictionary];
    [tblListing setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblListing setBackgroundColor:[UIColor clearColor]];
    destinationCount =1;
    
    objStaticEntities = singleton.staticEntities;
    serviceDetail = singleton.serviceDetail;
    
    [self getCities];
    [self getRegion];
    [self getServiceType];
    
    [self setFieldsValueDictionary];
    
    [lblTitle setText:[MCLocalization stringForKey:@"PLAN MODIFIER"]];
    
    
    NSLog(@"%@",singleton.dicJourneyPlanner);
    // Do any additional setup after loading the view.
}

-(void)setFieldsValueDictionary{
    
    for(int i=0; i<[arrPlistData count]; i++){
        NSMutableDictionary* cellData=(NSMutableDictionary*)[arrPlistData objectAtIndex:i];
        
        if ([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"EmptyCell"]) {
            
        }
        
        else if ([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"StarCell"]) {
            
            
            [dicFieldValueDictionary setObject:@"" forKey:[cellData objectForKey:@"DatabaseKey"]];
        }
        //        else if ([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"LabelCell"]) {
        //
        //        }
        else if ([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"TextFieldCell"]) {
            
            // [dicFieldValueDictionary setObject:@"" forKey:@"b"];
            [dicFieldValueDictionary setObject:@"" forKey:[cellData objectForKey:@"DatabaseKey"]];
        }
        //        else if ([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"SignUpButton"]) {
        //            
        //        }
    }
    
    NSLog(@"singleton.dicJourneyPlanner: setFieldsValue%@", singleton.dicJourneyPlanner);
    
    selectedRegionRow = [[singleton.dicJourneyPlanner valueForKey:@"fkRegionId"] integerValue];
    selectedCityRow = [[singleton.dicJourneyPlanner valueForKey:@"fkCityId"] integerValue];
    
    NSLog(@"selectedRegionRow:%d selectedCityRow:%d", (int)selectedRegionRow, (int)selectedCityRow);
    
    if ([[singleton.dicJourneyPlanner valueForKey:@"routeServiceTypeId"] length]>0){
        selectedServiceTypeRow = [[singleton.dicJourneyPlanner valueForKey:@"routeServiceTypeId"] integerValue];
    }
    
    dicFieldValueDictionary = nil;
    dicFieldValueDictionary = singleton.dicJourneyPlanner;
    
    Region* region = [objStaticEntities.region objectAtIndex:selectedRegionRow];
    City* city = [objStaticEntities.city objectAtIndex:selectedCityRow];
    
    if(singleton.isEnglish){
        [dicFieldValueDictionary setValue:region.locationTitleEn forKey:@"fkRegionId"];
        [dicFieldValueDictionary setValue:city.locationTitleEn forKey:@"fkCityId"];
        }
    else{
        [dicFieldValueDictionary setValue:region.locationTitleAr forKey:@"fkRegionId"];
        [dicFieldValueDictionary setValue:city.locationTitleEn forKey:@"fkCityId"];
    }
    if ([[singleton.dicJourneyPlanner valueForKey:@"routeServiceTypeId"] length]>0) {
        ServiceServiceType* serviceType  = [serviceDetail.serviceType objectAtIndex:selectedServiceTypeRow];
        if(singleton.isEnglish){
            [dicFieldValueDictionary setValue:serviceType.serviceTypeTitleEn forKey:@"routeServiceTypeId"];
        }
        else{
            [dicFieldValueDictionary setValue:serviceType.serviceTypeTitleAr forKey:@"routeServiceTypeId"];
        }
    }
    
    [self addRowInitial];
    [tblListing reloadData];
    
    
}

-(void)addRowInitial {
    
//    UIButton* btn_Sender = (UIButton*)sender;
//    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue
    
    int index = 6;
    for (NSString *key in dicFieldValueDictionary.allKeys) {
        if ([key rangeOfString:@"destination"].location == NSNotFound) {
            NSLog(@"string does not contain destination");
        }
        else{
            
            if (![key isEqualToString:@"destination"]) {
                NSMutableDictionary* dic = [[arrPlistData objectAtIndex:5] mutableCopy];
                [dic setValue:key forKey:@"DatabaseKey"];
                destinationCount++;
                [arrPlistData insertObject:dic atIndex:index];
                index++;
            }
            
        }
    }
    [tblListing reloadData];
    //    tblListing inser
    //    UITableViewCell* cell = [tblListing dequeueReusableCellWithIdentifier:@"a" forIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary* cellData=(NSMutableDictionary*)[arrPlistData objectAtIndex:indexPath.row];
    
    return [[cellData objectForKey:@"CellHeight"] floatValue];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrPlistData count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSMutableDictionary* cellData=(NSMutableDictionary*)[arrPlistData objectAtIndex:indexPath.row];
    
    NSLog(@"%@",cellData);
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[cellData objectForKey:@"CellIdentifier"] forIndexPath:indexPath];
    
    
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
    objc_setAssociatedObject(cell, &myIndexPath, indexPath, OBJC_ASSOCIATION_RETAIN);
    
    if([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"StarCell"])
    {
        [self starCell:cell indexPath:indexPath andCellData:cellData];
    }
    else if([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"TextFieldCell"])
    {
        [self textFieldCell:cell indexPath:indexPath andCellData:cellData];
    }
    else if([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"ButtonCell"])
    {
        [self buttonCell:cell indexPath:indexPath andCellData:cellData];
    }
    else if([[cellData objectForKey:@"CellIdentifier"] isEqualToString:@"GetScheduleCell"])
    {
        [self getScheduleCell:cell indexPath:indexPath andCellData:cellData];
    }
    [self iterateSubViewsForLocalization:cell.contentView];
    return cell;
}
#pragma -mark TextField Cell
-(UITableViewCell*)starCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath andCellData:(NSMutableDictionary*)cellData{
    // 1= bg ,2= label,3 = icon ,4 = button ,5 = star img
    
    BOOL isCompulsory = [[cellData valueForKey:@"isCompulsory"] boolValue];
    if (!isCompulsory){
        UIImageView* imgVStar = (UIImageView*)[cell viewWithTag:5];
        [imgVStar setHidden:YES];
    }
    else {
        UIImageView* imgVStar = (UIImageView*)[cell viewWithTag:5];
        [imgVStar setHidden:NO];
    }
    UIImageView* imgVIcon = (UIImageView*)[cell viewWithTag:3];
    [imgVIcon setImage:[UIImage imageNamed:[cellData valueForKey:@"icon"]]];
    [imgVIcon sizeToFit];
    
    UILabel* lblSubTitle = (UILabel*)[cell viewWithTag:2];
    
    
    if ([Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]]) {
        [lblSubTitle setText:[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]];
        [lblSubTitle setTextColor:[UIColor blackColor]];
    }
    else {
        [lblSubTitle setTextColor:[UIColor colorWithRed:(182/255.f) green:(183/255.f) blue:(192/255.f) alpha:(255.f)]];
//        [lblTitle setText:[cellData valueForKey:@"Title"]];
        [lblSubTitle setText:[MCLocalization stringForKey:[cellData valueForKey:@"Title"]]];
    }
    
    //    if([cellData valueForKey:@"DatabaseKey"] isEqualToString:@"") {
    //
    //    }
    //    else if([cellData valueForKey:@"DatabaseKey"]) {
    //
    //    }
    //    else if([cellData valueForKey:@"DatabaseKey"]) {
    //
    //    }
    
    UIButton* btnShowPicker=(UIButton*)[cell viewWithTag:4];
    
    [btnShowPicker removeTarget:nil
                         action:NULL
               forControlEvents:UIControlEventAllEvents];
    
    SEL selector = NSSelectorFromString([cellData valueForKey:@"Selector"]);
    [btnShowPicker addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(btnShowPicker, &labelTitle, cell, OBJC_ASSOCIATION_RETAIN);
    
    
    // imgVIcon.contentMode = UIViewContentModeScaleToFill;
    //    UIImageView* imgV_Icon = (UIImageView*)[cell viewWithTag:1];
    //    [imgV_Icon setImage:[UIImage imageNamed:[cellData valueForKey:@"iconImage"]]];
    //    [imgV_Icon sizeToFit];
    //    UITextField* txt_Data = (UITextField*)[cell viewWithTag:2];
    //    if([[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"email"]){
    //        [txt_Data setKeyboardType:UIKeyboardTypeEmailAddress];
    //
    //    }
    //    if([[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"password"] ||
    //       [[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"confirmPassword"]){
    //        [txt_Data setSecureTextEntry:YES];
    //    }
    //
    //    objc_setAssociatedObject(txt_Data, &myTextField, cell, OBJC_ASSOCIATION_ASSIGN);
    //    NSLog(@"%@",txt_Data.text);
    //    if (![Validation ValidateStringLength:[dic_FieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]]) {
    //        //if (![Validation ValidateStringLength:txt_Data.text]) {
    //        txt_Data.text = @"";
    //        [txt_Data setPlaceholder:[cellData valueForKey:@"Title"]];
    //        [txt_Data setPlaceHolderColor];
    //    }
    return cell;
}
-(UITableViewCell*)textFieldCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath andCellData:(NSMutableDictionary*)cellData{
    //2 = field
    UITextField* txtField = (UITextField*)[cell viewWithTag:2];
//    [txtField setPlaceholder:[cellData valueForKey:@"Title"]];
    [txtField setPlaceholder:[MCLocalization stringForKey:[cellData valueForKey:@"Title"]]];
    [txtField setText:[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]];
    
    NSLog(@"%@",[cellData valueForKey:@"Title"]);
    NSLog(@"%@",[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]);
    [txtField setDelegate:nil];
    [txtField setDelegate:self];
    objc_setAssociatedObject(txtField, &myTextField, [cellData valueForKey:@"DatabaseKey"], OBJC_ASSOCIATION_RETAIN);
    
    if (![[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]] isEqualToString:[cellData valueForKey:@"Title"]]) {
        [txtField setText:[dicFieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]];
    }
    //    UIImageView* imgV_Icon = (UIImageView*)[cell viewWithTag:1];
    //    [imgV_Icon setImage:[UIImage imageNamed:[cellData valueForKey:@"iconImage"]]];
    //    [imgV_Icon sizeToFit];
    //    UITextField* txt_Data = (UITextField*)[cell viewWithTag:2];
    //    if([[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"email"]){
    //        [txt_Data setKeyboardType:UIKeyboardTypeEmailAddress];
    //
    //    }
    //    if([[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"password"] ||
    //       [[cellData objectForKey:@"DatabaseKey"] isEqualToString:@"confirmPassword"]){
    //        [txt_Data setSecureTextEntry:YES];
    //    }
    //
    //    objc_setAssociatedObject(txt_Data, &myTextField, cell, OBJC_ASSOCIATION_ASSIGN);
    //    NSLog(@"%@",txt_Data.text);
    //    if (![Validation ValidateStringLength:[dic_FieldValueDictionary valueForKey:[cellData valueForKey:@"DatabaseKey"]]]) {
    //        //if (![Validation ValidateStringLength:txt_Data.text]) {
    //        txt_Data.text = @"";
    //        [txt_Data setPlaceholder:[cellData valueForKey:@"Title"]];
    //        [txt_Data setPlaceHolderColor];
    //    }
    return cell;
}
-(UITableViewCell*)buttonCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath andCellData:(NSMutableDictionary*)cellData{
    //1 = button
    UIButton* btnAddRow=(UIButton*)[cell viewWithTag:1];
    [btnAddRow addTarget:self action:@selector(addRow:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btnAddRow, &selectedBtn, [NSNumber numberWithInteger:indexPath.row], OBJC_ASSOCIATION_RETAIN);
    
    UILabel* lblText = (UILabel*)[cell viewWithTag:2];
    [lblText setText:[MCLocalization stringForKey:@"Add More Destinations for Multiple Routes."]];
    
    return cell;
}
-(UITableViewCell*)getScheduleCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath andCellData:(NSMutableDictionary*)cellData{
    //1 = button
    UIButton* btnGetSchedule=(UIButton*)[cell viewWithTag:1];
    [btnGetSchedule addTarget:self action:@selector(getSchedule) forControlEvents:UIControlEventTouchUpInside];
    [btnGetSchedule setTitle:[MCLocalization stringForKey:@"GET SCHEDULE"] forState:UIControlStateNormal];
    return cell;
}

-(void)addRow:(id)sender {
    
    UIButton* btn_Sender = (UIButton*)sender;
    NSInteger row = [objc_getAssociatedObject(btn_Sender, &selectedBtn) integerValue];
    
    NSMutableDictionary* dic = [[arrPlistData objectAtIndex:row-1] mutableCopy];
    
    NSLog(@"%@",dic);
    NSString* key = [NSString stringWithFormat:@"destination%d",destinationCount];
    [dic setValue:key forKey:@"DatabaseKey"];
    [dicFieldValueDictionary setValue:@"" forKey:key];
    NSLog(@"%@",dic);
    
    destinationCount++;
    [arrPlistData insertObject:dic atIndex:row];
    [tblListing reloadData];
    //    tblListing inser
    //    UITableViewCell* cell = [tblListing dequeueReusableCellWithIdentifier:@"a" forIndexPath:indexPath];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if (isInitialDataLoad)
        return;
    
    
//    NSString* check = [NSString stringWithFormat:@"&timestamp=%@%@",TIMESTAMP,API_KEY];
//    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                       TIMESTAMP,@"timestamp",
//                                       [check.MD5Hash lowercaseString],@"checksum",
//                                       nil];
    
//    [SERVICE_MODEL getStaticEntities:parameters completionBlock:^(NSObject *response) {
//        
//        NSLog(@"%@",response);
//        isInitialDataLoad = YES;
//        objStaticEntities = [StaticEntities modelObjectWithDictionary:(NSDictionary *)response];
//        
//        
//        
//        
//    } failureBlock:^(NSError *error) {
//        
//    }];
}
-(void)getCities {
    
    
    arrCity = [[NSMutableArray alloc]init];
    for (int index = 0; index<[objStaticEntities.city count];index++ ) {
        
        City* city = [objStaticEntities.city objectAtIndex:index];
        
        if(singleton.isEnglish) {
            
            [arrCity addObject:city.locationTitleEn];
        }
        else{
            [arrCity addObject:city.locationTitleAr];
        }
        
    }
}
-(void)getRegion {
    
    arrRegion = [[NSMutableArray alloc]init];
    for (int index = 0; index<[objStaticEntities.region count];index++ ) {
        Region* region = [objStaticEntities.region objectAtIndex:index];
        if (singleton.isEnglish) {
            [arrRegion addObject:region.locationTitleEn];
        }
        else{
            [arrRegion addObject:region.locationTitleAr];
        }
        
    }
    
}

-(void)getServiceType {
    
    arrServiceType = [[NSMutableArray alloc]init];
    for (int index = 0; index<[serviceDetail.serviceType count];index++ ) {
        ServiceServiceType* serviceType = [serviceDetail.serviceType objectAtIndex:index];
        if (singleton.isEnglish) {
            [arrServiceType addObject:serviceType.serviceTypeTitleEn];
        }
        else{
            [arrServiceType addObject:serviceType.serviceTypeTitleAr];
        }
        
        
    }
    
}


-(void)getServiceTypeFromServer {
    //checksum, timestamp, fkCompanyId
    
    //singleton.myAccountInfo.user.fkCompanyId
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@fkCompanyId=%@%@",TIMESTAMP,@"1",API_KEY];
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:@"1" forKey:@"fkCompanyId" atIndex:2];
    
    [SERVICE_MODEL getCompanyStaticEntities:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@",response);
        serviceDetail = [ServiceServiceList modelObjectWithDictionary:(NSDictionary *)response];
        [self getServiceType];
        
        
        [self setFieldsValueDictionary];
        
        
    } failureBlock:^(NSError *error) {
        
    }];
}

-(IBAction)selectRegion:(id)sender {
    
    NSLog(@"REGION");
    UIButton* btn_Sender = (UIButton*)sender;
    NSInteger tag = btn_Sender.tag;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblTitleText = (UILabel*)[cell viewWithTag:2];
    
    
    
    selectedString = [arrRegion objectAtIndex:0];
    [MMPickerView showPickerViewInView:self.view.window
                           withStrings:arrRegion
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                
                                NSLog(@"COMPLETE");
                                selectedString = selectedString1;
                                selectedRegionRow = [arrRegion indexOfObject:selectedString];
                                //lblRegion.text = selectedString;
                                [lblTitleText setText:selectedString];
                                [lblTitleText setTextColor:[UIColor blackColor]];
                                [dicFieldValueDictionary setValue:selectedString forKey:@"fkRegionId"];
                                //[lblRegion setTextColor:[UIColor blackColor]];
                            }];
    
}
-(IBAction)selectCity:(id)sender {
    
    UIButton* btn_Sender = (UIButton*)sender;
    NSInteger tag = btn_Sender.tag;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblSubTitle = (UILabel*)[cell viewWithTag:2];
    
    selectedString = [arrCity objectAtIndex:0];
    [MMPickerView showPickerViewInView:self.view.window
                           withStrings:arrCity
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                
                                NSLog(@"COMPLETE");
                                selectedString = selectedString1;
                                selectedCityRow = [arrCity indexOfObject:selectedString];
                                //                                lblCity.text = selectedString;
                                //                                [lblCity setTextColor:[UIColor blackColor]];
                                [lblSubTitle setText:selectedString];
                                [dicFieldValueDictionary setValue:selectedString forKey:@"fkCityId"];
                                [lblSubTitle setTextColor:[UIColor blackColor]];
                            }];
}
-(IBAction)selectServiceType:(id)sender {
    
    
    UIButton* btn_Sender = (UIButton*)sender;
    NSInteger tag = btn_Sender.tag;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblTitleText = (UILabel*)[cell viewWithTag:2];
    
    selectedString = [arrServiceType objectAtIndex:0];
    [MMPickerView showPickerViewInView:self.view.window
                           withStrings:arrServiceType
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                
                                NSLog(@"COMPLETE");
                                selectedString = selectedString1;
                                selectedServiceTypeRow = [arrServiceType indexOfObject:selectedString];
                                //                                lblServiceTime.text = selectedString;
                                //                                [lblServiceTime setTextColor:[UIColor blackColor]];
                                [dicFieldValueDictionary setValue:selectedString forKey:@"routeServiceTypeId"];
                                [lblTitleText setText:selectedString];
                                [lblTitleText setTextColor:[UIColor blackColor]];
                            }];
    
    
}
-(IBAction)selectArrivalDate:(id)sender {
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setLenient:YES];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = @"2100-12-31";
    NSDate* maxDate = [formatter1 dateFromString:dateString];
    
    lblTemp = nil;
    UIButton* btn_Sender = (UIButton*)sender;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblTitle = (UILabel*)[cell viewWithTag:2];
    lblTemp = lblTitle;
    // if (isShowPicker) {
    //tempButton=sender;
    eCurrentPickerType = ePickerTypeArrivalDate;
    [self.view endEditing:YES];
//    datePicker = [[FlatDatePicker alloc] initWithParentView:self.view.window];
//    datePicker.delegate = self;
//    datePicker.title = @"Arrival Date";
//    datePicker.datePickerMode = FlatDatePickerModeDate;
//    [datePicker show];

    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MyDatePicker" owner:self options:nil];
    myDataPicker= [nibObjects objectAtIndex:0];
    [myDataPicker setFrame:self.view.frame];
    [self.view.window addSubview:myDataPicker];
    myDataPicker.mydelegate=self;
    [myDataPicker setDatePickerMode:UIDatePickerModeDate];
    [myDataPicker InitializeDatePicker];
    [myDataPicker setMinimumDate:[NSDate date]];
    [myDataPicker setMaximumDate: maxDate];
}
-(void)SelectDate:(NSMutableDictionary*)data{
    [myDataPicker removeFromSuperview];
    if(data!=nil){
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        NSString* strDate = [dateFormat stringFromDate:[data valueForKey:@"date"]];
        
        [lblArrivalTime setText:strDate];
        [lblArrivalTime setTextColor:[UIColor blackColor]];
        arrivalDate = [data valueForKey:@"date"];
        [dicFieldValueDictionary setValue:strDate forKey:@"plannerArrivalDate"];
        
        [lblTemp setText:strDate];
        [lblTemp setTextColor:[UIColor blackColor]];
    }
}
-(IBAction)selectStartTime:(id)sender {
    
    lblTemp = nil;
    UIButton* btn_Sender = (UIButton*)sender;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblTitleText = (UILabel*)[cell viewWithTag:2];
    lblTemp = lblTitleText;
    
    eCurrentPickerType = ePickerTypeStartTime;
    [self.view endEditing:YES];
    datePicker = [[FlatDatePicker alloc] initWithParentView:self.view.window];
    datePicker.delegate = self;
    datePicker.title = @"Start Time";
    datePicker.datePickerMode = FlatDatePickerModeTime;
    [datePicker show];
}
-(IBAction)selectEndTime:(id)sender {
    
    lblTemp = nil;
    UIButton* btn_Sender = (UIButton*)sender;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &labelTitle);
    UILabel* lblTitleText = (UILabel*)[cell viewWithTag:2];
    lblTemp = lblTitleText;
    
    eCurrentPickerType = ePickerTypeEndTime;
    [self.view endEditing:YES];
    datePicker = [[FlatDatePicker alloc] initWithParentView:self.view.window];
    datePicker.delegate = self;
    datePicker.title = @"End Time";
    datePicker.datePickerMode = FlatDatePickerModeTime;
    [datePicker show];
}
- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    if (eCurrentPickerType == ePickerTypeArrivalDate){
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        [lblArrivalTime setText:[dateFormat stringFromDate:date]];
        [lblArrivalTime setTextColor:[UIColor blackColor]];
        arrivalDate = date;
        [dicFieldValueDictionary setValue:[dateFormat stringFromDate:date] forKey:@"plannerArrivalDate"];
    }
    else if (eCurrentPickerType == ePickerTypeStartTime){
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [lblStartTime setText:[dateFormat stringFromDate:date]];
        [lblStartTime setTextColor:[UIColor blackColor]];
        startTime = date;
        [dicFieldValueDictionary setValue:[dateFormat stringFromDate:date] forKey:@"plannerStartTime"];
    }
    else if (eCurrentPickerType == ePickerTypeEndTime){
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [lblEndTime setText:[dateFormat stringFromDate:date]];
        [lblEndTime setTextColor:[UIColor blackColor]];
        endTime = date;
        [dicFieldValueDictionary setValue:[dateFormat stringFromDate:date] forKey:@"plannerEndTime"];
    }
    
    [lblTemp setText:[dateFormat stringFromDate:date]];
    [lblTemp setTextColor:[UIColor blackColor]];
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    //isShowPicker = TRUE;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSString* key = objc_getAssociatedObject(textField, &myTextField) ;
   // if ([Validation ValidateStringLength:textField.text]){
        [dicFieldValueDictionary setValue:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:key];
    //}
    return YES;
    
}
-(IBAction)getSchedule {
    
//    ScheduleResultController *myVideoController = [self.storyboard instantiateViewControllerWithIdentifier:@"scheduleResultController"];
//    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:myVideoController];
//    navigationController.viewControllers = controllers;
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    return;
    
    
    dicData = nil;
    dicData = [OrderedDictionary dictionary];
    [dicData setObject:[singleton.dicJourneyPlanner valueForKey:@"plannerArrivalDateStamp"]
                forKey:@"plannerArrivalDate"];
    
    [dicData setObject:[singleton.dicJourneyPlanner valueForKey:@"plannerStartTimeStamp"]
                forKey:@"plannerStartTime"];
    
    
    [dicData setObject:[singleton.dicJourneyPlanner valueForKey:@"plannerEndTimeStamp"]
                forKey:@"plannerEndTime"];
    NSLog(@"%@",dicFieldValueDictionary);
    
    
    NSLog(@"%@",lblRegion.text);
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"fkRegionId"]]){
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Select Region"])
        return;
    }
    else {
        
        Region* region = [objStaticEntities.region objectAtIndex:selectedRegionRow];
        [dicData setValue:[NSString stringWithFormat:@"%.0f",region.fkRegionId] forKey:@"fkRegionId"];
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"fkCityId"]]){
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Select City"])
        return;
    }
    else {
        City* city = [objStaticEntities.city objectAtIndex:selectedCityRow];
        [dicData setValue:city.fkCityId forKey:@"fkCityId"];
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"routeTitle"]]){
        
        [dicData setValue:@"" forKey:@"routeTitle"];
        
        //        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Enter Route")
        //        return;
    }
    else {
        [dicData setValue:[dicFieldValueDictionary valueForKey:@"routeTitle"] forKey:@"routeTitle"];
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"origin"]]){
        
        [dicData setValue:@"" forKey:@"origin"];
        //        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Enter Origin")
        //        return;
    }
    else {
        [dicData setValue:[dicFieldValueDictionary valueForKey:@"origin"] forKey:@"origin"];
    }
    if (![dicFieldValueDictionary valueForKey:@"destination"] /*|| [arrDestination count] == 0*/){
        
        [dicData setValue:@"" forKey:@"destination"];
        
        //        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], @"Enter Destination")
        //        return;
    }
    else {
        [arrDestination removeAllObjects];
        
        for (NSString *key in dicFieldValueDictionary.allKeys) {
            if ([key rangeOfString:@"destination"].location == NSNotFound) {
                NSLog(@"string does not contain bla");
            }
            else{
                if ([Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:key]]) {
                    [arrDestination addObject:[dicFieldValueDictionary valueForKey:key]];
                }
                
            }
        }
        if (arrDestination.count>0){
            NSError* error = nil;
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arrDestination options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            NSLog(@"jsonData as string:\n%@", jsonString);
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [dicData setValue:jsonString forKey:@"destination"];
        }
        else{
            [dicData setValue:@"" forKey:@"destination"];
        }
//        NSError* error = nil;
//        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arrDestination options:0 error:&error];
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
//        NSLog(@"jsonData as string:\n%@", jsonString);
//        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        [dicData setValue:jsonString forKey:@"destination"];
        
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"routeServiceTypeId"]] ){
        
        [dicData setValue:@"" forKey:@"routeServiceTypeId"];

    }
    else {
        ServiceServiceType* serviceType  = [serviceDetail.serviceType objectAtIndex:selectedServiceTypeRow];
        [dicData setValue:serviceType.serviceTypeId forKey:@"routeServiceTypeId"];

    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"plannerArrivalDate"]]){
        
        [dicData setValue:@"" forKey:@"plannerArrivalDate"];
    }
    else {
        if(arrivalDate)
            [dicData setValue:[NSString stringWithFormat:@"%.0f",[arrivalDate timeIntervalSince1970]] forKey:@"plannerArrivalDate"];
        
        
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"plannerStartTime"]]){
        
        [dicData setValue:@"" forKey:@"plannerStartTime"];

    }
    else {
        
        [dicData setValue:[dicFieldValueDictionary valueForKey:@"plannerStartTime"] forKey:@"plannerStartTime"];
    }
    if (![Validation ValidateStringLength:[dicFieldValueDictionary valueForKey:@"plannerEndTime"]]){
        [dicData setValue:@"" forKey:@"plannerEndTime"];

    }
    else {
        [dicData setValue:[dicFieldValueDictionary valueForKey:@"plannerEndTime"] forKey:@"plannerEndTime"];
    }
    
    
    //NSLog(@"%@",dicData);
    [self gotoNextController];
}

-(void)gotoNextController {
    
    
    //
    //    checksum, userId, fkRegionId, fkCityId, routeTitle, origin, destination, routeServiceTypeId, plannerArrivalDate, plannerStartTime, plannerEndTime, timestamp
//    singleton.dicJourneyPlanner = nil;
    singleton.dicJourneyPlanner = [dicFieldValueDictionary mutableCopy];
    [singleton.dicJourneyPlanner setValue:[NSString stringWithFormat:@"%ld",(long)selectedRegionRow] forKey:@"fkRegionId"];
    [singleton.dicJourneyPlanner setValue:[NSString stringWithFormat:@"%ld",(long)selectedCityRow] forKey:@"fkCityId"];
    if([[dicData valueForKey:@"routeServiceTypeId"] length]>0){
        [singleton.dicJourneyPlanner setValue:[NSString stringWithFormat:@"%ld",(long)selectedServiceTypeRow] forKey:@"routeServiceTypeId"];
    }
    
    
    if ([dicData valueForKey:@"origin"]) {
        
        NSError* error = nil;
        if ([[dicData objectForKey:@"origin"] length] == 0) {
            
            [dicData setValue:@"" forKey:@"origin"];
        }
        else {
            
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:@[[dicData objectForKey:@"origin"]] options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            NSLog(@"jsonData as string:\n%@", jsonString);
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            [dicData setValue:jsonString forKey:@"origin"];
        }
    }
    if ([dicData valueForKey:@"routeTitle"]) {
        
        if ([[dicData objectForKey:@"routeTitle"] length] == 0) {
            
            [dicData setValue:@"" forKey:@"routeTitle"];
        }
        else {
            NSError* error = nil;
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:@[[dicData objectForKey:@"routeTitle"]] options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSLog(@"jsonData as string:\n%@", jsonString);
            
            [dicData setValue:jsonString forKey:@"routeTitle"];
        }
    }
    
    
    NSString* checkSum = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkRegionId=%@fkCityId=%@routeTitle=%@origin=%@destination=%@routeServiceTypeId=%@plannerArrivalDate=%@plannerStartTime=%@plannerEndTime=%@%@",
                          TIMESTAMP,singleton.myAccountInfo.user.userId,
                          [dicData valueForKey:@"fkRegionId"],
                          [dicData valueForKey:@"fkCityId"],
                          [dicData valueForKey:@"routeTitle"],
                          [dicData valueForKey:@"origin"],
                          [dicData valueForKey:@"destination"],
                          [dicData valueForKey:@"routeServiceTypeId"],
                          [dicData valueForKey:@"plannerArrivalDate"],
                          [dicData valueForKey:@"plannerStartTime"],
                          [dicData valueForKey:@"plannerEndTime"],
                          API_KEY];
    
    
    NSLog(@"singleton.dicJourneyPlanner: gotoNextController journeyPlanner \n%@", singleton.dicJourneyPlanner);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[checkSum.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    [parameters insertObject:[dicData valueForKey:@"fkRegionId"] forKey:@"fkRegionId" atIndex:3];
    [parameters insertObject:[dicData valueForKey:@"fkCityId"] forKey:@"fkCityId" atIndex:4];
    [parameters insertObject:[dicData valueForKey:@"routeTitle"] forKey:@"routeTitle" atIndex:5];
    [parameters insertObject:[dicData valueForKey:@"origin"] forKey:@"origin" atIndex:6];
    [parameters insertObject:[dicData valueForKey:@"destination"] forKey:@"destination" atIndex:7];
    [parameters insertObject:[dicData valueForKey:@"routeServiceTypeId"] forKey:@"routeServiceTypeId" atIndex:8];
    [parameters insertObject:[dicData valueForKey:@"plannerArrivalDate"] forKey:@"plannerArrivalDate" atIndex:9];
    [parameters insertObject:[dicData valueForKey:@"plannerStartTime"] forKey:@"plannerStartTime" atIndex:10];
    [parameters insertObject:[dicData valueForKey:@"plannerEndTime"] forKey:@"plannerEndTime" atIndex:11];
    //
    //
    
    UINavigationController *centerNavigation = [appDelegate->container centerViewController];
    [centerNavigation popViewControllerAnimated:NO];
    
    ScheduleResultController *myVideoController = [self.storyboard instantiateViewControllerWithIdentifier:@"scheduleResultController"];
    myVideoController.dicData = parameters;
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:myVideoController];
//    navigationController.viewControllers = controllers;
    [navigationController pushViewController:myVideoController animated:NO];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    //return;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //return (newLength >60) ? NO : YES;
    
    
    if(newLength <= 30) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    else {
        return (newLength >30) ? NO : YES;
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    
//    if ([segue.identifier isEqualToString:@"GetScedule"]) {
//        ScheduleResultController *controller = [segue destinationViewController];
//        //controller.dicData =
//    }
//    // Pass the selected object to the new view controller.
//}


@end


