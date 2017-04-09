//
//  LoginTableViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/21/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "LoginTableViewController.h"
#import "AWSCognitoIdentityProvider.h"
#import "Config.h"
#import "JVFloatLabeledTextField.h"
#import "UserManager.h"
#import "SVProgressHUD.h"
#import "UIViewController+Alert.h"
#import "CakeAlertViewController.h"
#import "VerificationCodeTableViewController.h"

typedef NS_ENUM(NSUInteger, LoginSelectedStaticCell){
    LoginSelectedStaticCellEmailEntry = 0,
    LoginSelectedStaticCellPasswordEntry,
    LoginSelectedStaticCellLogIn,
    LoginSelectedStaticCellCreateAccount
};

@interface LoginTableViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *iconSuperView;
@property (weak, nonatomic) IBOutlet UIView *iconRoundedView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAccountLabel;
@property (strong, nonatomic) AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails*>* passwordAuthenticationCompletion;
@property (nullable, nonatomic) AWSCognitoIdentityUser *user;

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleViews];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [UserManager sharedManager].userPool.delegate = self;
    UITapGestureRecognizer *tapTodismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.iconSuperView addGestureRecognizer:tapTodismissKeyboard];
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[VerificationCodeTableViewController class]]) {
        VerificationCodeTableViewController *controller = segue.destinationViewController;
        controller.user = self.user;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (LoginSelectedStaticCellCreateAccount + 1);
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.row == LoginSelectedStaticCellLogIn) {
        if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length < 6) {
            CakeAlertViewController *passwordAlert = [[CakeAlertViewController alloc] initWithAlertTitle:NSLocalizedString(@"Login.Password.Title", @"get string for passowrd length") message:NSLocalizedString(@"Login.Password.Body", @"get string for password body")];
            NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Alert.Ok", @"get string for ok") style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                [passwordAlert dismissViewControllerAnimated:YES completion:nil];
            }];
            [passwordAlert addAlertAction:cancelAction];
            [self presentViewController:passwordAlert animated:YES completion:nil];
            return;
        }
        if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
            [SVProgressHUD show];
            [self authenticateUser];
        } else {
            [SVProgressHUD dismiss];
            [self showMessage:NSLocalizedString(@"Login.NoCredentials", @"user has to fill out creds") withType:MessageTypeError];
        }
    } else if (indexPath.row == LoginSelectedStaticCellCreateAccount) {
        [self performSegueWithIdentifier:kCreateAccountSegue sender:self];
    }
}

- (void)authenticateUser {

    self.passwordAuthenticationCompletion.result = [[AWSCognitoIdentityPasswordAuthenticationDetails alloc] initWithUsername:self.emailTextField.text password:self.passwordTextField.text];

    [SVProgressHUD dismiss];
}


#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideKeyboard];
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
        return YES;
    }
    if (textField == self.passwordTextField) {
        if (self.passwordTextField.text.length) {
            [self.passwordTextField resignFirstResponder];
            return YES;
        }
    }
    return NO;
}


#pragma mark - IBActions
- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Helpers
- (void)didCompletePasswordAuthenticationStepWithError:(NSError*) error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];

        if(error){
            CakeAlertViewController *errorAlert = [[CakeAlertViewController alloc] initWithAlertTitle:error.userInfo[@"__type"] message:error.userInfo[@"message"]];
            NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                [errorAlert dismissViewControllerAnimated:YES completion:nil];
            }];
            [errorAlert addAction:cancelAction];
            [self presentViewController:errorAlert animated:YES completion:nil];
            return;
        } else {
            //dismiss view controller
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD dismiss];
        }
    });
}

//-(id<AWSCognitoIdentityPasswordAuthentication>) startPasswordAuthentication{
//    //implement code to instantiate and display login UI here
//    //return something that implements the AWSCognitoIdentityPasswordAuthentication protocol
//    return loginUI;
//}

- (void)getSession {
    [[self.user getSession:self.emailTextField.text password:self.passwordTextField.text validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
        if (task.error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                if ([task.error.userInfo[@"message"] isEqualToString:@"User is not confirmed."]) {
                    CakeAlertViewController *verifyAlert = [[CakeAlertViewController alloc] initWithAlertTitle:@"Please verify user" message:@"You will be sent a verifcation code"];
                    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Alert.Cancel", @"get string for ok") style:UIAlertActionStyleDefault handler:^(NYAlertAction *action) {
                        [verifyAlert dismissViewControllerAnimated:YES completion:nil];
                    }];
                    NYAlertAction *sendAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Login.Alert.Resend", @"get string for resend code") style:UIAlertActionStyleDefault handler:^(NYAlertAction *action) {
                        [verifyAlert dismissViewControllerAnimated:YES completion:nil];
                        [SVProgressHUD show];

                        [[self.user resendConfirmationCode] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserResendConfirmationCodeResponse *> * _Nonnull task) {

                            if (task.error) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [SVProgressHUD dismiss];
                                    NSLog(@"error: %@", task.error.localizedDescription);
                                });
                            } else {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [SVProgressHUD dismiss];
                                    [self performSegueWithIdentifier:kVerifySegue sender:self];
                                });
                            }
                            return nil;
                        }];
                    }];
                    [verifyAlert addAction:sendAction];
                    [verifyAlert addAction:cancelAction];
                    [self presentViewController:verifyAlert animated:YES completion:nil];
                } else {
                    CakeAlertViewController *errorAlert = [[CakeAlertViewController alloc] initWithAlertTitle:task.error.userInfo[@"__type"] message:task.error.userInfo[@"message"]];
                    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                        [errorAlert dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [errorAlert addAction:cancelAction];
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
                // NSError *error;
                //self.passwordAuthenticationCompletion.result = [[AWSCognitoIdentityPasswordAuthenticationDetails alloc] initWithUsername:self.emailTextField.text password:self.passwordTextField.text];
                // [self didCompletePasswordAuthenticationStepWithError:error];
            });

        }
        return nil;
    }];
}

- (void)styleViews {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.iconRoundedView.layer.cornerRadius = self.iconRoundedView.frame.size.width / 2;
    self.iconRoundedView.layer.masksToBounds = YES;
    self.loginLabel.layer.cornerRadius = self.loginLabel.frame.size.height / 2;
    self.loginLabel.layer.masksToBounds = YES;
    if ([self.emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login.Username", @"get string for email placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.emailTextField.floatingLabelTextColor = [UIColor blackColor];
        self.emailTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.emailTextField.floatingLabelActiveTextColor = [UIColor blackColor];
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    }
    if ([self.passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login.Password", @"get string for password textfield placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.passwordTextField.floatingLabelTextColor = [UIColor blackColor];
        self.passwordTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.passwordTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
}

- (void)hideKeyboard {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void) getPasswordAuthenticationDetails: (AWSCognitoIdentityPasswordAuthenticationInput *) authenticationInput  passwordAuthenticationCompletionSource: (AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails *> *) passwordAuthenticationCompletionSource {
    self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.emailTextField.text)
            self.emailTextField.text = authenticationInput.lastKnownUsername;
    });

}


@end
