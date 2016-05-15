//
//  UITextView+CustomFontTextView.m
//  Park Swift
//
//  Created by Muzamil Hassan on 19/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "UITextView+CustomFontTextView.h"

@implementation UITextView (CustomFontTextView)
- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}
@end
