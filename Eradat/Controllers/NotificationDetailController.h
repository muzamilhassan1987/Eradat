//
//  NotificationDetailController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/3/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface NotificationDetailController : BaseController
{
    __weak IBOutlet UITextView* txtVDetail;
    __weak IBOutlet UILabel* lblTitle;
    __weak IBOutlet UILabel* lblDate;
}
@property(nonatomic,strong)Notification* notificationDetail;
@end
