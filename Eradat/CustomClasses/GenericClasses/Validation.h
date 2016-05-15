//
//  Validation.h
//  ;
//
//  Created by Muzamil on 11/28/12.
//  Copyright (c) 2012 Umair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject
+(NSDictionary*)CallServer:(NSDictionary*)dic Path:(NSString*)path;
+(BOOL)ValidateNumber:(NSString*)myStr;
+(BOOL)ValidateEmail:(NSString*)myStr;
+(void)ShowAlert:(NSString*)title Message:(NSString*)msg AndTag:(NSInteger)tag;
+(BOOL)ValidateEmailAtEdu:(NSString*)myStr;
+(BOOL)ValidatePasswordLength:(NSString*)myStr;
+(BOOL)ValidateStringLength:(NSString*)myStr;
+(BOOL)ValidateOnlyAlphabets:(NSString*)myStr;
+(BOOL)ValidateOnlyAlphaNumeric:(NSString*)myStr;
+(BOOL) isEmpty:(NSString *)string fieldName:(NSString*)fieldName;
+ (BOOL) isValidEmailAddress:(NSString *)emailAddress;
+(BOOL)isPasswordLength:(NSString*)password minCharacters:(int)minCharacters;
+(BOOL)containsAlphabetOnly:(NSString*)str fieldName:(NSString*)fieldName;
+(BOOL)isValidPassword:(NSString*)password confirmPassword:(NSString*)confirmPassword;
+ (BOOL)textFieldEmptyValidation:(NSArray *)fieldsArr;
+(BOOL)ValidateNumber:(NSString*)myStr fieldName:(NSString*)fieldName;
+(int)getWidthOfLabelName:(NSString*)fname Size:(CGFloat)fsize Text:(NSString*)ftext LabelWidth:(CGFloat)fwidth;
@end
