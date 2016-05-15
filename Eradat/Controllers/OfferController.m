//
//  OfferController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/1/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "OfferController.h"
#import "UIImageView+AFNetworking.h"
#import <objc/runtime.h>

@interface OfferController ()

@end

@implementation OfferController
static char selectedBtn;
- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerOffer;
    [tblListing setBackgroundColor:[UIColor clearColor]];
    [tblListing setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self getDataFromServer];
}

-(void)getDataFromServer {
    
    //checksum, userId, timestamp
    
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@userId=%@%@",TIMESTAMP,singleton.myAccountInfo.user.userId,API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    
    NSLog(@"%@",parameters);
    
    [SERVICE_MODEL getOffers:parameters completionBlock:^(NSObject *response) {
        
        
        arrOffersList = [OfferBase modelObjectWithDictionary:(NSDictionary *)response].offer;
        [tblListing reloadData];
        
    } failureBlock:^(NSError *error) {
        
         NSLog(@"%@",error);
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 288;
}
//
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  NSLog(@"COUNT IS %d",[arr_CardListing count]);
    return [arrOffersList count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Offer* currentOffer = [arrOffersList objectAtIndex:indexPath.row];
    
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"simpleCell" forIndexPath:indexPath];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setExclusiveTouch:YES];
    [cell.contentView setExclusiveTouch:YES];
    
    UILabel* lblTitle = (UILabel*)[cell viewWithTag:1];
    UILabel* lblTime = (UILabel*)[cell viewWithTag:2];
    UILabel* lblDescription = (UILabel*)[cell viewWithTag:3];
    UIImageView* imgOffer = (UIImageView*)[cell viewWithTag:4];
    
    // double timestampval =  [[updates objectForKey:@"timestamp"] doubleValue]/1000;
    NSTimeInterval timestamp = (NSTimeInterval)currentOffer.offerCreated;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"%@",updatetimestamp);
    
    NSString* strTime = [Utility prettyStringServerFromDate:updatetimestamp withServerDate:[NSDate date]];
   
    if(singleton.isEnglish){
        [lblTitle setText:currentOffer.offerTitleEn];
        [lblTime setText:strTime];
        [lblDescription setText:currentOffer.offerDescriptionEn];
    }
    else{
        [lblTitle setText:currentOffer.offerTitleAr];
        [lblTime setText:strTime];
        [lblDescription setText:currentOffer.offerDescriptionAr];
    }
    
  
   
    [self loadImageInCell:currentOffer.offerImage ImageView:imgOffer];
    
    
    UIButton* btnShare = (UIButton*)[cell viewWithTag:5];
    [btnShare addTarget:self action:@selector(socialShare:) forControlEvents:UIControlEventTouchUpInside];
    [btnShare setTitle:[MCLocalization stringForKey:@"Share"] forState:UIControlStateNormal];
    objc_setAssociatedObject(btnShare, &selectedBtn, cell, OBJC_ASSOCIATION_RETAIN);
    
//
//    lbl_Name.text = cardDetail.pName;
//    lbl_Date.text = cardDetail.pDate;
//    lbl_Time.text = cardDetail.pTime;
//    
//    UIButton* btn_CheckMark = (UIButton*)[cell viewWithTag:5];
//    UIButton* btn_Cross = (UIButton*)[cell viewWithTag:6];
//    [btn_CheckMark addTarget:self action:@selector(btnCkeckMark:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_Cross addTarget:self action:@selector(btnCross:) forControlEvents:UIControlEventTouchUpInside];
//    
//    objc_setAssociatedObject(btn_CheckMark, &myButton, cardDetail, OBJC_ASSOCIATION_ASSIGN);
//    objc_setAssociatedObject(btn_Cross, &myButton, cell, OBJC_ASSOCIATION_ASSIGN);
//    
//    if (cardDetail.is_Checked) {
//        [btn_CheckMark setImage:[UIImage imageNamed:@"mycard_checkicon"] forState:UIControlStateNormal];
//    }
//    else {
//        [btn_CheckMark setImage:[UIImage imageNamed:@"mycard_uncheckicon"] forState:UIControlStateNormal];
//    }
    
    return cell;
}
-(void)loadImageInCell:(NSString*)url ImageView:(UIImageView*)imgV {
    NSURL *urlPath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlPath];
    UIImage *placeholderImage = nil;
    
    //__weak UITableViewCell *weakCell = cell;
    
    __weak UIImageView* imageView = imgV;
    
    [imgV setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       [imageView setImage:image];
                                      // weakCell.imageView.image = image;
                                      // [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
}


-(void)socialShare:(id)sender {
    
    UIButton* btn_Sender = (UIButton*)sender;
    //NSInteger tag = btn_Sender.tag;
    UITableViewCell* cell = objc_getAssociatedObject(btn_Sender, &selectedBtn) ;
    NSIndexPath *indexPath = [tblListing indexPathForCell:cell];
    
    Offer* currentOffer = [arrOffersList objectAtIndex:indexPath.row];
    UIImageView* imgOffer = (UIImageView*)[cell viewWithTag:4];
    
    NSString *textToShare = currentOffer.offerDescriptionEn;
    UIImage *image = imgOffer.image;
    
    NSArray *objectsToShare = nil;
    if (image){
        objectsToShare = @[textToShare, image];
    }
    else{
        objectsToShare = @[textToShare];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSString*)dummyData {
    
    return nil;
}
@end
