//
//  AppDelegate.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UserManager.h"

@interface AppDelegate ()

@property (nonatomic,strong) AWSTaskCompletionSource<NSNumber*> *rememberDeviceCompletionSource;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [AWSLogger defaultLogger].logLevel = AWSLogLevelVerbose;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];

    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    [UserManager sharedManager].userPool.delegate = self;
    return YES;
}


//set up password authentication ui to retrieve username and password from the user
-(id<AWSCognitoIdentityPasswordAuthentication>) startPasswordAuthentication {

    if(!self.navigationController){
        self.navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    }
    if(!self.logInViewController){
        self.logInViewController = self.navigationController.viewControllers[0];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        //rewind to login screen
        [self.navigationController popToRootViewControllerAnimated:NO];

        //display login screen if it isn't already visibile
        if(!(self.navigationController.isViewLoaded && self.navigationController.view.window))
        {
            [self.window.rootViewController presentViewController:self.navigationController animated:YES completion:nil];
        }
    });
    return self.logInViewController;
}

//set up mfa ui to retrieve mfa code from end user
-(id<AWSCognitoIdentityMultiFactorAuthentication>) startMultiFactorAuthentication {
    if(!self.verifyTableViewController){
        self.verifyTableViewController = [VerificationCodeTableViewController new];
        self.verifyTableViewController.modalPresentationStyle = UIModalPresentationPopover;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //if mfa view isn't already visible, display it
        if (!(self.verifyTableViewController.isViewLoaded && self.verifyTableViewController.view.window)) {
            //display mfa as popover on current view controller
            UIViewController *vc = self.window.rootViewController;
            [vc presentViewController:self.verifyTableViewController animated: YES completion: nil];

            //configure popover vc
            UIPopoverPresentationController *presentationController =
            [self.verifyTableViewController popoverPresentationController];
            presentationController.permittedArrowDirections =
            UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
            presentationController.sourceView = vc.view;
            presentationController.sourceRect = vc.view.bounds;
        }
    });
    return self.verifyTableViewController;
}

//set up remember device ui
-(id<AWSCognitoIdentityRememberDevice>) startRememberDevice {
    return self;
}

-(void) getRememberDevice: (AWSTaskCompletionSource<NSNumber *> *) rememberDeviceCompletionSource {
    self.rememberDeviceCompletionSource = rememberDeviceCompletionSource;

    //Don't do anything fancy here, just display a popup.
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"Remember Device"
                                    message:@"Do you want to remember this device?"
                                   delegate:self
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@"Yes", nil] show];
    });
}

-(void) didCompleteRememberDeviceStepWithError:(NSError* _Nullable) error {
    [self errorPopup:error];
}

-(void) errorPopup:(NSError *_Nullable) error {
    //Don't do anything fancy here, just display a popup.
    if(error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:error.userInfo[@"__type"]
                                        message:error.userInfo[@"message"]
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"Ok", nil] show];
        });
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            self.rememberDeviceCompletionSource.result = @(NO);
            break;
        case 1:
            self.rememberDeviceCompletionSource.result = @(YES);
            break;
        default:
            break;
    }

    self.rememberDeviceCompletionSource = nil;
}

#pragma mark - passwordRequired
//-(id<AWSCognitoIdentityNewPasswordRequired>) startNewPasswordRequired {
//    if(!self.passwordRequiredViewController){
//        self.passwordRequiredViewController = [NewPasswordRequiredViewController new];
//        self.passwordRequiredViewController.modalPresentationStyle = UIModalPresentationPopover;
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //if new password required view isn't already visible, display it
//        if (!(self.passwordRequiredViewController.isViewLoaded && self.passwordRequiredViewController.view.window)) {
//            //display mfa as popover on current view controller
//            UIViewController *vc = self.window.rootViewController;
//            [vc presentViewController:self.passwordRequiredViewController animated: YES completion: nil];
//
//            //configure popover vc
//            UIPopoverPresentationController *presentationController =
//            [self.passwordRequiredViewController popoverPresentationController];
//            presentationController.permittedArrowDirections =
//            UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
//            presentationController.sourceView = vc.view;
//            presentationController.sourceRect = vc.view.bounds;
//        }
//    });
//    return self.passwordRequiredViewController;
//
//}

@end
