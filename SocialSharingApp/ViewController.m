//
//  ViewController.m
//  SocialSharingApp
//
//  Created by Ricardo Ruiz on 6/10/14.
//  Copyright (c) 2014 iOS Apps Development. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController (){
    
    UIImage *selectedImage;
}
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

- (IBAction)postToFacebook:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)activityView:(id)sender;

@end

@implementation ViewController
@synthesize myTextView,myImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    myTextView.text = @"Standard Text";
}

- (IBAction)postToFacebook:(id)sender {
    
    // Check to see if ServiceType is Available
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:myTextView.text];
        [controller addImage:selectedImage];
        [self presentViewController:controller animated:YES completion:^{NSLog(@"Present View Controller Called");}];
        
    } else {
    	
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Facebook not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)postToTwitter:(id)sender {

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [ tweetSheet setInitialText:myTextView.text];
        [self presentViewController:tweetSheet animated:YES completion:^{NSLog(@"Present View Controller Called.");}];
        
    } else {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Twitter not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
     

}

- (IBAction)selectPhoto:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // Select PhotoLibrary
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender {
	
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    	
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Camera not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)activityView:(id)sender {
    
   UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:@[selectedImage]applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];

    selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    myImageView.image = selectedImage;
}
@end
