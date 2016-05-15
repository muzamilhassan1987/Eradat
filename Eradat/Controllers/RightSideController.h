//
//  RightSideController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/4/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import "MyDatePicker.h"
@interface RightSideController : BaseController<FlatDatePickerDelegate,UITextFieldDelegate,datePickerDelegate>
{
    __weak IBOutlet UILabel* lblTitle;
    BOOL isInitialDataLoad;
    __weak IBOutlet UILabel* lblRegion;
    __weak IBOutlet UILabel* lblCity;
    __weak IBOutlet UITextField* txtRoute;
    __weak IBOutlet UITextField* txtOrigin;
    __weak IBOutlet UITextField* txtDestination;
    __weak IBOutlet UILabel* lblServiceTime;
    __weak IBOutlet UILabel* lblArrivalTime;
    __weak IBOutlet UILabel* lblStartTime;
    __weak IBOutlet UILabel* lblEndTime;
    
    MyDatePicker* myDataPicker;
    
    __weak IBOutlet UITableView* tblListing;
    NSMutableDictionary* dicFieldValueDictionary;
    NSMutableArray* arrPlistData;
    NSMutableArray *arrDestination;
    UILabel* lblTemp;
    
    NSMutableArray* arrRegion;
    NSMutableArray* arrCity;
    NSMutableArray* arrServiceType;
    StaticEntities* objStaticEntities;
    NSString * selectedString;
    NSInteger selectedRegionRow;
    NSInteger selectedCityRow;
    NSInteger selectedServiceTypeRow;
    
    FlatDatePicker* datePicker;
    ServiceServiceList* serviceDetail;
    OrderedDictionary* dicData;
    
    NSDate* arrivalDate;
    NSDate* startTime;
    NSDate* endTime;
    
    int destinationCount;
}

@end
