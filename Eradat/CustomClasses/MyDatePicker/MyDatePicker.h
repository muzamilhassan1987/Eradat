//
//  MyDatePicker.h
//  PrayerTiming
//
//  Created by Muzamil Hassan on 24/06/2013.
//  Copyright (c) 2013 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol datePickerDelegate <NSObject>

@optional
-(void)SelectDate:(NSMutableDictionary*)data;


@end
@interface MyDatePicker : UIView<UIActionSheetDelegate>
{
    UIView* viewYear;
    UILabel* lblYear;
    IBOutlet UIView* smallView;
    IBOutlet UIImageView* bg;
    IBOutlet UIView* view_Picker;
    IBOutlet UIToolbar *pickerToolbar;
    IBOutlet UIDatePicker *theDatePicker;
    UIActionSheet *pickerViewDate;//property define
    id<datePickerDelegate> mydelegate;
}

@property(nonatomic,strong)id<datePickerDelegate> mydelegate;

-(void)setDatePickerMode:(UIDatePickerMode)mode;
-(void)InitializeDatePicker;
-(void)setDifferenceInMinute:(NSInteger)interval;
-(void)setDatePickerMinimumDate:(NSDate*)date;
-(void) setYearButton;
-(UIDatePickerMode) getDatePickerMode;
-(void)setDatePickeMode:(UIDatePickerMode)mode;
-(void)setMinimumDate:(NSDate*)date;
-(void)setMaximumDate:(NSDate*)date;
@end
