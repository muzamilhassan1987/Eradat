//
//  UILabel+CustomFontLabel.m
//  Park Swift
//
//  Created by Muzamil Hassan on 18/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "UILabel+CustomFontLabel.h"

@implementation UILabel (CustomFontLabel)
- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}

//- (NSString *)localizationKey {
//    return self.localizationKey;
//}
//
//- (void)setLocalizationKey:(NSString *)localizationKey {
//    self.localizationKey = localizationKey;
//}

@end
