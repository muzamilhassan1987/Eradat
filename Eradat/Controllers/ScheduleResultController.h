//
//  ScheduleResultController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/26/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface ScheduleResultController : BaseController
{
    __weak IBOutlet UITableView* tblListing;
    JourneyBase* objAllJourneyDetail;
    NSDateFormatter *formatter;
    __weak IBOutlet UILabel* lblResult;
}
@property(nonatomic,strong)OrderedDictionary* dicData;
@end
