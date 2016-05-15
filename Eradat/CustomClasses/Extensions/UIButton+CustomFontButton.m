//
//  UIButton+CustomFontButton.m
//  Park Swift
//
//  Created by Muzamil Hassan on 18/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "UIButton+CustomFontButton.h"

@implementation UIButton (CustomFontButton)
- (NSString *)fontName {
    return self.titleLabel.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.titleLabel.font = [UIFont fontWithName:fontName size:self.titleLabel.font.pointSize];
}
@end
