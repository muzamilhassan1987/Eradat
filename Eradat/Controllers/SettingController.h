//
//  SettingController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/29/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface SettingController : BaseController
{
    __weak IBOutlet UITableView* tblSetting;
    NSArray* arrLanguage;
    NSString* selectedString;
}
@end
