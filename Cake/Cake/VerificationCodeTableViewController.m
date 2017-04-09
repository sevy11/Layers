//
//  VerificationCodeTableViewController.m
//  Cake
//
//  Created by Michael Sevy on 4/1/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "VerificationCodeTableViewController.h"
#import "CakeAlertViewController.h"
#import "JVFloatLabeledTextField.h"
#import "Config.h"
#import "UserManager.h"
#import "SVProgressHUD.h"

typedef NS_ENUM(NSUInteger, VerifyStaticCell){
    VerifyStaticCellEntry = 0,
    VerifyStaticCellVerify
};

@interface VerificationCodeTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *codeTextField;

@end

@implementation VerificationCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeTextField.delegate = self;
    if ([self.codeTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Verification.Code", @"get string for code textfield placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.codeTextField.floatingLabelTextColor = [UIColor blackColor];
        self.codeTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.codeTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == VerifyStaticCellVerify) {
        if (self.codeTextField.text.length == 6) {
            [SVProgressHUD show];
            [[self.user confirmSignUp:self.codeTextField.text forceAliasCreation:YES] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserConfirmSignUpResponse *> * _Nonnull task) {
                if (task.error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        CakeAlertViewController *errorAlert = [[CakeAlertViewController alloc] initWithAlertTitle:task.error.userInfo[@"__type"] message:task.error.userInfo[@"message"]];
                        NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                            [errorAlert dismissViewControllerAnimated:YES completion:nil];
                        }];
                        [errorAlert addAction:cancelAction];
                        [self presentViewController:errorAlert animated:YES completion:nil];
                        return;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        return;
                    });
                };
                [SVProgressHUD dismiss];
                return nil;
            }];
        } else {
            //show not six digit alert
        }
        [SVProgressHUD dismiss];
    }
}

@end
