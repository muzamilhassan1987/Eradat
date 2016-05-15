////
////  MyAnnotationView.m
////  MapIntegration
////
////  Created by salman lakhani on 11/30/12.
////  Copyright 2012 __MyCompanyName__. All rights reserved.
////
//
//#import "MyAnnotationView.h"
////#import "EGOImageView.h"
//@implementation MyAnnotationView
//
//
//- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
//    if (self != nil)
//    {
//        CGRect frame = self.frame;
//        frame.size = CGSizeMake(60.0, 85.0);
//        self.frame = frame;
//        self.backgroundColor = [UIColor clearColor];
//        self.centerOffset = CGPointMake(-5, -5);
//        bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 55)];
//        [bgimageview setImage:[UIImage imageNamed:@"nearbythumb"]];
//        
//
//        imageView = [[EGOImageView alloc] initWithFrame:CGRectMake(4.5, 4.0, 37, 38)];
//        
//        
//        [bgimageview addSubview:imageView];
//        [self addSubview:bgimageview];
//        
//        CALayer * l = [imageView layer];
//        [l setMasksToBounds:YES];
//        [l setCornerRadius:5.0];
//        
//    }
//    [imageView setContentMode:UIViewContentModeScaleAspectFill];
//   
//    return self;
//}
//
//-(void) drawRect:(CGRect)rect
//{
//    
//}
//-(void) setimageurl:(NSString*)imageurl
//{
//   // NSLog(@"image url: %@",imageurl);
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImagePath,imageurl]];
//}
//
//@end
