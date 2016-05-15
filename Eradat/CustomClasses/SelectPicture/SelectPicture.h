//
//  SelectPicture.h
//  Umemeet
//
//  Created by Muzamil on 11/29/12.
//  Copyright (c) 2012 Umair. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectPictureDelegate <NSObject>

-(void)SelectedImage:(UIImage*)img;

@end

@interface SelectPicture : NSObject<UIImagePickerControllerDelegate>
{
    UIViewController *cameraController;
    NSInteger buttonTag;
    id<SelectPictureDelegate> picDelegate;
}
@property(nonatomic,strong)id<SelectPictureDelegate> picDelegate;
@property(nonatomic,strong) UIViewController *cameraController;
@property(nonatomic,assign) NSInteger buttonTag;
-(id)initWithController:(UIViewController*)signUpController;
-(void)getCameraPicture:(id)sender;
-(IBAction)selectExistingPicture:(id)sender;
@end
