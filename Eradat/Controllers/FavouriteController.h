//
//  FavouriteController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/2/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface FavouriteController : BaseController
{
    __weak IBOutlet UITableView* tblListing;
    NSDateFormatter *formatter;
    BaseFavourite* favouriteDetail;
    NSMutableArray* arrListing;
}
@end
