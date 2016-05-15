//
//  UITextField+CustomFontTextField.m
//  Park Swift
//
//  Created by Muzamil Hassan on 18/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "UITextField+CustomFontTextField.h"

@implementation UITextField (CustomFontTextField)
- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
    //[self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)setPlaceHolderColor {
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
