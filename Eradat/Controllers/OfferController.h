//
//  OfferController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/1/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface OfferController : BaseController
{
    __weak IBOutlet UITableView* tblListing;
    NSArray* arrOffersList;
}
@end