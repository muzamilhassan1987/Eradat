//
//  MyDatePicker.m
//  PrayerTiming
//
//  Created by Muzamil Hassan on 24/06/2013.
//  Copyright (c) 2013 Muzamil Hassan. All rights reserved.
//

#import "MyDatePicker.h"

@implementation MyDatePicker
@synthesize mydelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
  //  NSLog(@"%@",NSStringFromCGRect(frame));
    if (self) {
        pickerViewDate = [[UIActionSheet alloc] initWithTitle:@"How many?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:nil];
        
        theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
        theDatePicker.datePickerMode = UIDatePickerModeTime;
        pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        pickerToolbar.barStyle=UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
        [barItems addObject:flexSpace];
        
        
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                   target:nil
                                   action:nil];
        [barItems addObject:spacer];
        
        UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                   target:nil
                                   action:nil];
        [barItems addObject:spacer1];
        
        
        
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DatePickerCancelClick)];
        [barItems addObject:cancelBtn];
        
        
        [pickerToolbar setItems:barItems animated:YES];
        [pickerViewDate addSubview:pickerToolbar];
        [pickerViewDate addSubview:theDatePicker];
        [pickerViewDate  showInView:self];
        [pickerViewDate setBounds:CGRectMake(0,0,320, 464)];
        //[pickerViewDate setBounds:CGRectMake(0,0,300, 480)];
       

    }
    return self;
}
-(void)setDatePickerMode:(UIDatePickerMode)mode {
    theDatePicker.datePickerMode = mode;
}
-(void)setDifferenceInMinute:(NSInteger)interval {
    theDatePicker.minuteInterval = interval;
}
-(void)setDatePickerMinimumDate:(NSDate*)date {
    theDatePicker.minimumDate = date;
}

-(UIDatePickerMode) getDatePickerMode {
    
   return  theDatePicker.datePickerMode;
}
-(void)awakeFromNib{
    //[self slideIn];
}
-(void)dateChanged
{
	NSDateFormatter* currentdateformate = [[NSDateFormatter alloc] init];
	[currentdateformate setDateFormat:@"dd-MM-YYYY"];
    //[currentdateformate stringFromDate:[theDatePicker date]
}

-(IBAction)DatePickerCancelClick
{
	//[pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    [mydelegate SelectDate:nil];
	
}
-(IBAction)DatePickerDoneClick
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    //NSLog(@"%@",[outputFormatter stringFromDate:theDatePicker.date]);
    //NSLog(@"%@", [outputFormatter stringFromDate:[self getRoundedDate:theDatePicker.date]]);
    [outputFormatter setDateFormat:@"HH"];
    //NSLog(@"%@",[outputFormatter stringFromDate:theDatePicker.date]);
    [outputFormatter setDateFormat:@"h:mm a"];
    NSDate* time = [self getRoundedDate:[self getRoundedDate:theDatePicker.date]];
    //NSLog(@"%@",[outputFormatter stringFromDate:time]);
    //[pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    NSDate *pickerDate=[theDatePicker date];
    NSDateFormatter* currentdateformate = [[NSDateFormatter alloc] init];
    [currentdateformate setDateFormat:@"dd-MMM hh:mm a"];
    //[currentdateformate setDateFormat:@"dd-MM-YYYY hh:mm a"];
    //[currentdateformate setDateFormat:@"hh:mm a"];
   NSString* dateToString=[NSString stringWithFormat:@"%@",[currentdateformate stringFromDate:pickerDate]];
   [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:[theDatePicker date] forKey:@"date"];
    [data setValue:dateToString forKey:@"datestring"];
    
    NSTimeInterval timeFloor = floor([time timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    time =  [NSDate dateWithTimeIntervalSinceReferenceDate:timeFloor];
    
    
    [data setValue:time forKey:@"time"];
    [mydelegate SelectDate:data];
}

-(NSDate *)getRoundedDate:(NSDate *)inDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    NSLog(@"%@",[outputFormatter stringFromDate:inDate]);
    
    NSInteger minuteInterval = 30;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:inDate];
    NSInteger minutes = [dateComponents minute];
    
    float minutesF = [[NSNumber numberWithInteger:minutes] floatValue];
    float minuteIntervalF = [[NSNumber numberWithInteger:minuteInterval] floatValue];
    
    // Determine whether to add 0 or the minuteInterval to time found by rounding down
    NSInteger roundingAmount = (fmodf(minutesF, minuteIntervalF)) > minuteIntervalF/2.0 ? minuteInterval : 0;
    NSInteger minutesRounded = ( (NSInteger)(minutes / minuteInterval) ) * minuteInterval;
    //NSDate *roundedDate = [[NSDate alloc] initWithTimeInterval:60.0 * (minutesRounded + roundingAmount - minutes) sinceDate:inDate];
    CGFloat test = 0.0;
    if (minutesF >0 && minutesF < 30) {
        test = 0 - minutesF;
    }
    else if (minutesF > 30 && minutesF < 60) {
        test = 30 - minutesF;
    }
    else {
        test = 0;
    }
    NSDate *roundedDate = [[NSDate alloc] initWithTimeInterval:60.0 * test sinceDate:inDate];
    NSLog(@"%@",[outputFormatter stringFromDate:roundedDate]);
    NSLog(@"%@",[outputFormatter stringFromDate:inDate]);
    
    return roundedDate;
}

-(void)InitializeDatePicker{

        [smallView setHidden:NO];
        [pickerViewDate addSubview:smallView];
        [smallView setFrame:pickerViewDate.frame];
        [smallView setBackgroundColor:[UIColor whiteColor]];
        [self setFrame:CGRectMake(0, 0,SCREEN_SIZE.width , SCREEN_SIZE.height)];
        [bg setFrame:self.frame];
        
//    if(IS_IPHONE_5) {
//        if (IS_OS_7_OR_LATER) {
//            [smallView setHidden:NO];
//            [pickerViewDate addSubview:smallView];
//            [smallView setFrame:pickerViewDate.frame];
//            [smallView setBackgroundColor:[UIColor whiteColor]];
//            [self setFrame:CGRectMake(0, 0, 320, 568)];
//            [bg setFrame:self.frame];
//        }
//        else {
//            [smallView setHidden:YES];
//            [self setFrame:CGRectMake(0, 0, 320, 568)];
//            [bg setFrame:self.frame];
//        }
//        
//    }
//    else {//416-4,6
//        if (IS_OS_7_OR_LATER) {
//            [smallView setHidden:NO];
//            [pickerViewDate addSubview:smallView];
//            [smallView setFrame:pickerViewDate.frame];
//            [smallView setBackgroundColor:[UIColor whiteColor]];
//            [self setFrame:CGRectMake(0, 0, 320, 480)];
//            [bg setFrame:self.frame];
//        }
//        else {
//            [smallView setHidden:YES];
//            [self setFrame:CGRectMake(0, 0, 320, 480)];
//            [bg setFrame:self.frame];
//        }
//    }
    [self slideIn];
}
- (void)slideIn {
    CGRect framePicker = theDatePicker.frame;
    CGRect frameToolbar = pickerToolbar.frame;
   // CGRect frameViewYear ;
//    if(viewYear)
//         frameViewYear = viewYear.frame;
//    if (IS_IPHONE_5) {
//        framePicker.origin = CGPointMake(0.0, 568);
//        frameToolbar.origin = CGPointMake(0.0, 568);
//        //frameViewYear.origin =  CGPointMake(0.0, 568);
//    }
//    else {
//        
//        framePicker.origin = CGPointMake(0.0, 480);
//        frameToolbar.origin = CGPointMake(0.0, 480);
//        //frameViewYear.origin =  CGPointMake(0.0, 480);
//    }
    framePicker.origin = CGPointMake(0.0, SCREEN_SIZE.height);
    frameToolbar.origin = CGPointMake(0.0, SCREEN_SIZE.height);
    //framePicker.origin = CGPointMake(0.0, theDatePicker.superview.bounds.size.height);
    //frameToolbar.origin = CGPointMake(0.0, pickerToolbar.superview.bounds.size.height);
    theDatePicker.frame = framePicker;
    pickerToolbar.frame = frameToolbar;
    //viewYear.frame = framePicker;
    smallView.frame = theDatePicker.frame;
    [UIView beginAnimations:@"presentWithSuperview" context:nil];
    framePicker.origin = CGPointMake(0.0,SCREEN_SIZE.height - theDatePicker.bounds.size.height);
    frameToolbar.origin = CGPointMake(0.0,SCREEN_SIZE.height - pickerToolbar.bounds.size.height-theDatePicker.bounds.size.height);

    [UIView setAnimationDuration:0.5];
    theDatePicker.frame = framePicker;
    smallView.frame = theDatePicker.frame;
    pickerToolbar.frame = frameToolbar;
    [UIView commitAnimations];
}

- (void) slideOut{
    [UIView beginAnimations:@"removeFromSuperviewWithAnimation" context:nil];
    
    // Set delegate and selector to remove from superview when animation completes
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Move this view to bottom of superview
    CGRect frame = self.frame;
    frame.origin = CGPointMake(0.0, self.superview.bounds.size.height);
    self.frame = frame;
    
    [UIView commitAnimations];
}


-(void) setYearButton {
    
    viewYear = [[UIView alloc] initWithFrame:CGRectMake(PX(pickerToolbar), PY(pickerToolbar), WDT(pickerToolbar), HGT(pickerToolbar))];
    [self addSubview:viewYear];
    [viewYear setBackgroundColor:[UIColor yellowColor]];
    [pickerToolbar setCenter:CGPointMake(pickerToolbar.center.x, pickerToolbar.center.y+HGT(pickerToolbar))];
    
    
}

-(void)setDatePickeMode:(UIDatePickerMode)mode {
    [theDatePicker setDatePickerMode:mode];
}

-(void)setMinimumDate:(NSDate*)date {
    [theDatePicker setMinimumDate:date];
}
-(void)setMaximumDate:(NSDate*)date {
    [theDatePicker setMaximumDate:date];
}

-(void)dealloc {
    
    mydelegate = nil;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
