//
//  VerificationCodeTableViewController.h
//  Cake
//
//  Created by Michael Sevy on 4/1/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWSCognitoIdentityProvider.h"

@interface VerificationCodeTableViewController : UITableViewController

@property (nonatomic, nullable) AWSCognitoIdentityUser *user;

@end
