//
//  Validation.m
//  Umemeet
//
//  Created by Muzamil on 11/28/12.
//  Copyright (c) 2012 Umair. All rights reserved.
//

#import "Validation.h"
#define ALERT_FIELD_EMPTY                   @"%@ field can't be left empty"
#define ALERT_ALPHABETS_ALLOWED             @"Only alphabets are allowed"
#define ALERT_INVALID_EMAIL                 @"Invalid email address"
#define ALERT_INVLALID_CONTACT              @"Contact field is not valid"
#define ALERT_PASSWORD_MINIMUM_CHARACTERS   @"There Must be minimum %d characters"
#define ALERT_PASSWORD_MISMATCH             @"Password and confirm password mismatch"
@implementation Validation


+(BOOL)ValidateNumber:(NSString*)myStr{
    
    NSString *strMatchstring=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *textpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchstring];
    return [textpredicate evaluateWithObject:myStr];
}
+(void)ShowAlert:(NSString*)title Message:(NSString*)msg AndTag:(NSInteger)tag{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:[MCLocalization stringForKey:@"Ok"], nil];
    [alert show];
}
+(BOOL)ValidateEmail:(NSString*)myStr{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:myStr];
    
}
+(BOOL)ValidateEmailAtEdu:(NSString*)myStr{
    // myStr=@"m@edu.com";
    //NSString *trimmedString=[string substringFromIndex:[string length]-4];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //return [emailTest evaluateWithObject:myStr];
    if([emailTest evaluateWithObject:myStr]){
        NSString *trimmedString=[myStr substringFromIndex:[myStr length]-4];
        
        if ([trimmedString isEqualToString:@".edu"])
        {
            return TRUE;
            
        }
    }
    //return FALSE;
    return TRUE;
}
/*
+(BOOL)ValidateEmailAtEdu:(NSString*)myStr{
   // myStr=@"m@edu.com";
    //NSString *trimmedString=[string substringFromIndex:[string length]-4];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //return [emailTest evaluateWithObject:myStr];
    if([emailTest evaluateWithObject:myStr]){
        NSRange range = [myStr rangeOfString:@".edu"];
        if (range.location != NSNotFound)
        {
            return TRUE;
            
        }
    }
    
    return FALSE;
}
 */

+(BOOL)ValidatePasswordLength:(NSString*)myStr {
    
    if([myStr length] < 7 || [myStr length] > 16 || ![[myStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        NSLog(@"return");
        return FALSE;
    }
    
    return TRUE;
}

+(BOOL)ValidateStringLength:(NSString*)myStr{
    if(myStr==(id) [NSNull null] || [myStr length]==0 || [myStr isEqual:@""] || ![[myStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        NSLog(@"return");
        return FALSE;
    }
    
    return TRUE;
}
+(BOOL)ValidateOnlyAlphabets:(NSString*)myStr{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    s = [s invertedSet];
    NSRange r = [myStr rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
          NSLog(@"invalid");
        return FALSE;
    }
        return TRUE;
}

+(BOOL)ValidateOnlyAlphaNumeric:(NSString*)myStr{
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
    NSUInteger matches = [regex numberOfMatchesInString:myStr options:0 range:NSMakeRange(0, [myStr length])];
    if (matches > 0) {
        if ([myStr rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) {
            
            NSString *specialCharacterString = @"!~`@#$%^&*-+();:={}[],.<>?\\/\"\'";
            NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacterString];
            if ([myStr.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length) {
                return TRUE;
            }
        }
    }
    return FALSE;
  
}


+(BOOL) isEmpty:(NSString *)string fieldName:(NSString*)fieldName
{
	if(string == nil || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Field",fieldName] message:[NSString stringWithFormat:ALERT_FIELD_EMPTY,fieldName] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
		return TRUE;
    }
	else{
        return FALSE;
    }
	
}

+ (BOOL) isValidEmailAddress:(NSString *)emailAddress{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:emailAddress];
    if(!result){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Email Field" message:ALERT_INVALID_EMAIL delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    return result;
}
+(BOOL)isPasswordLength:(NSString*)password minCharacters:(int)minCharacters{
    BOOL result= ([password length]>=minCharacters);
    if(!result){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Password Field" message:[NSString stringWithFormat:ALERT_PASSWORD_MINIMUM_CHARACTERS,minCharacters] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    return result;
}

+(BOOL)containsAlphabetOnly:(NSString*)str fieldName:(NSString*)fieldName{
    NSString *regex = @"[a-zA-Z ]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [test evaluateWithObject:str];
    if(!result){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Field",fieldName] message:[NSString stringWithFormat:ALERT_ALPHABETS_ALLOWED] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    return result;
}

+(BOOL)isValidPassword:(NSString*)password confirmPassword:(NSString*)confirmPassword{
    
    if(![password isEqualToString:confirmPassword]){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[MCLocalization stringForKey:@"Alert"] message:[NSString stringWithFormat:ALERT_PASSWORD_MISMATCH] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

+ (BOOL)textFieldEmptyValidation:(NSArray *)fieldsArr{
    
    for (UITextField* mytextfield in fieldsArr){
        
        NSString *rawString = [mytextfield text];
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
        if ([trimmed length] == 0 || [rawString isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

+(BOOL)ValidateNumber:(NSString*)myStr fieldName:(NSString*)fieldName{
    
    NSString *strMatchstring=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *textpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchstring];
    BOOL result = [textpredicate evaluateWithObject:myStr];
    if(!result){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Field",fieldName] message:ALERT_INVLALID_CONTACT delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    return result;
}

+(int) getWidthOfLabelName:(NSString*)fname Size:(CGFloat)fsize Text:(NSString*)ftext LabelWidth:(CGFloat)fwidth {
    
    UIFont* font = [UIFont fontWithName:fname size:fsize];
    CGSize stringSize = [ftext sizeWithFont:font];
    CGFloat width = stringSize.width;
    CGFloat lines = width/fwidth;
    int lineNum = width/fwidth;
    if(lines>lineNum) {
        return lineNum+1;
    }
    else
        return lineNum;
}


/*
+(BOOL)ValidateOnlyAlphaNumeric:(NSString*)myStr{
    
    
    
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
   
    
    
    BOOL isAlphaNumericOnly= [[myStr stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[myStr stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    if(isAlphaNumericOnly){
        return TRUE;
    }
    else{
        return FALSE;
    }
}
 */
@end
