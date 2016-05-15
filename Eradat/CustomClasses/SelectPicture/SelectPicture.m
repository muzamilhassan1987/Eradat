//
//  SelectPicture.m
//  Umemeet
//
//  Created by Muzamil on 11/29/12.
//  Copyright (c) 2012 Umair. All rights reserved.
//

#import "SelectPicture.h"
#import "Validation.h"
#import <MobileCoreServices/UTCoreTypes.h>
@implementation SelectPicture
@synthesize buttonTag,cameraController,picDelegate;
/*---------------------------------------------------------------------------------------------
 CAMERA & LIBRARY
 ---------------------------------------------------------------------------------------------*/
-(id)initWithController:(UIViewController*)signUpController{
    if(self = [super init]){
        self.cameraController=signUpController;
    }
    return self;
}
#pragma mark - Camera & library
-(void)getCameraPicture:(id)sender
{
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
       
        [Validation ShowAlert:@"Camera" Message:@"Camera not supported for this device" AndTag:0];
    }
    else{
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=(id)self;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = YES;
        picker.allowsEditing = YES;
        
        [self.cameraController presentViewController:picker animated:YES completion:nil];
        
    }
}
-(IBAction)selectExistingPicture:(id)sender
{
    
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=(id)self;
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //picker.showsCameraControls = NO;
        picker.allowsEditing = YES;
        [self.cameraController presentViewController:picker animated:YES completion:nil];
    }
	else
    {
        [Validation ShowAlert:@"error accessing photo library" Message:@"device not support"AndTag:0];
	}
}

-(void)DismisPicker:(UIViewController*)view{
    //[view dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - DELEGATES
#pragma mark - image picker
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (CGSize) size
{
    float oldHeight = sourceImage.size.height;
    float scaleFactor = size.height / oldHeight;
    
    float newHeight = oldHeight * scaleFactor;
    float newWidth = sourceImage.size.width * scaleFactor;
    /*float oldWidth = sourceImage.size.width;
     float scaleFactor = size.width / oldWidth;
     
     float newHeight = sourceImage.size.height * scaleFactor;
     float newWidth = oldWidth * scaleFactor;*/
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   
    
        //UIImage *img=(UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *pickedImageEdited = [info objectForKey:UIImagePickerControllerEditedImage];
        //Muzamil1picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        //[picDelegate SelectedImage:[SelectPicture imageWithImage:pickedImageEdited scaledToWidth:CGSizeMake(500, 160)]];
        [picDelegate SelectedImage:pickedImageEdited];
    if ([info objectForKey:@"UIImagePickerControllerOriginalImage"]  != nil)
    {
    }
    
}
/*---------------------------------------------------------------------------------------------
 (END) CAMERA & LIBRARY
 ---------------------------------------------------------------------------------------------*/
@end
