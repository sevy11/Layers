//
//  VerificationCodeTableViewController.m
//  Cake
//
//  Created by Michael Sevy on 4/1/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "VerificationCodeTableViewController.h"
#import "CakeAlertViewController.h"
#import "NSObject+ProgressHUD.h"

@interface VerificationCodeTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation VerificationCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeTextField.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.text.length == 6) {
        [[self.user confirmSignUp:textField.text] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserConfirmSignUpResponse *> * _Nonnull task) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideAllHUDs];
                if(task.error){
                    CakeAlertViewController *errorAlert = [[CakeAlertViewController alloc] initWithAlertTitle:task.error.userInfo[@"__type"] message:task.error.userInfo[@"message"]];
                    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                        [errorAlert dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [errorAlert addAction:cancelAction];
                    [self presentViewController:errorAlert animated:YES completion:nil];
                } else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }});
                return nil;
        }];
    };
}
@end
