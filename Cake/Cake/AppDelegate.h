//
//  AppDelegate.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWSCognitoIdentityProvider.h"
#import "LoginTableViewController.h"
#import "VerificationCodeTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, AWSCognitoIdentityInteractiveAuthenticationDelegate, AWSCognitoIdentityRememberDevice, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIStoryboard *storyboard;
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,strong) LoginTableViewController *logInViewController;
@property(nonatomic,strong) VerificationCodeTableViewController *verifyTableViewController;
//@property(nonatomic,strong) NewPasswordRequiredViewController* passwordRequiredViewController;

@end

