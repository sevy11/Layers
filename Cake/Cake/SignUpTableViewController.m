//
//  SignUpTableViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/22/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "ConfigManager.h"
#import "Config.h"
#import "JVFloatLabeledTextField.h"
#import "CakeAlertViewController.h"
#import "AWSCognitoIdentityProvider.h"
#import "SVProgressHUD.h"
#import "VerificationCodeTableViewController.h"
#import "UserManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

typedef NS_ENUM(NSUInteger, SelectedSignUpCell) {
    SelectedSignUpCellFirstName = 0,
    SelectedSignUpCellEmail,
    SelectedSignUpCellPassword,
    SelectedSignUpCellConfirmPassword,
    SelectedSignUpCellSignUp,
    SelectedSignUpCellDisclaimer,
    SelectedSignUpCellLogIn,
    SelectedSignUpCellPhone
};

@interface SignUpTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *iconSuperView;
@property (weak, nonatomic) IBOutlet UIView *iconRoundedView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UILabel *submitLabel;
@property (weak, nonatomic) IBOutlet UITextView *disclaimerTextView;
@property (weak, nonatomic) IBOutlet UILabel *alreadyAUserLabel;
@property (nullable, nonatomic) AWSCognitoIdentityUser *user;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneNumberTextField;

@end

@implementation SignUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleButtons];
    [self setupTextFields];
    [self setupTermsTextView];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    self.user = [AWSCognitoIdentityUser new];
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmTextField.delegate = self;
    self.phoneNumberTextField.delegate = self;
    self.iconRoundedView.layer.cornerRadius = self.iconRoundedView.frame.size.height / 2;
    self.iconRoundedView.clipsToBounds = YES;
    self.navigationItem.title = NSLocalizedString(@"SignUp.Title", @"get string for title");
    [self setupTapGestures];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
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
    return (SelectedSignUpCellPhone + 1);
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.row == SelectedSignUpCellSignUp) {
        if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length < 6) {
            CakeAlertViewController *passwordAlert = [[CakeAlertViewController alloc] initWithAlertTitle:NSLocalizedString(@"Login.Password.Title", @"get string for passowrd length") message:NSLocalizedString(@"Login.Password.Body", @"get string for password body")];
            NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Alert.Ok", @"get string for ok") style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                [passwordAlert dismissViewControllerAnimated:YES completion:nil];
            }];
            [passwordAlert addAlertAction:cancelAction];
            [self presentViewController:passwordAlert animated:YES completion:nil];
            return;
        }
        if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
            [self mismatchedPasswordsAlert];
            return;
        }
        if (![self isEntryValid]) {
            CakeAlertViewController *alertViewController = [[CakeAlertViewController alloc] initWithAlertTitle:self.errorMessage message:nil];
            NYAlertAction *cancelAlertAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Alert.Ok", @"get string for alert action") style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                [alertViewController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertViewController addAlertAction:cancelAlertAction];
            [self presentViewController:alertViewController animated:YES completion:nil];
            return;
        }
        [SVProgressHUD show];
        [self signupUser];
    } else if (indexPath.row == SelectedSignUpCellLogIn) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)signupUser {
    //        AWSCognitoIdentityUserAttributeType *phone = [AWSCognitoIdentityUserAttributeType new];
    //        phone.name = @"phone_number";
    //        phone.value = self.phoneNumberTextField.text;
    AWSCognitoIdentityUserAttributeType * email = [AWSCognitoIdentityUserAttributeType new];
    email.name = @"email";
    email.value = self.emailTextField.text;
    //register the user
    [[[UserManager sharedManager].userPool signUp:self.nameTextField.text password:self.passwordTextField.text userAttributes:@[ email] validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserPoolSignUpResponse *> * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if(task.error) {
                CakeAlertViewController *errorAlert = [[CakeAlertViewController alloc] initWithAlertTitle:task.error.userInfo[@"__type"] message:task.error.userInfo[@"message"]];
                NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
                    [errorAlert dismissViewControllerAnimated:YES completion:nil];
                }];
                [errorAlert addAction:cancelAction];
                [self presentViewController:errorAlert animated:YES completion:nil];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //AWSCognitoIdentityUserPoolSignUpResponse *response = task.result;
                    self.user = task.result.user;
                    [self performSegueWithIdentifier:kVerifySegue sender:self];
                });
            }});
        return nil;
    }];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [self hideKeyboard];
    }
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
        return YES;
    }
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
        return YES;
    }
    if (textField == self.passwordTextField) {
        [self.confirmTextField becomeFirstResponder];
        return YES;
    }
    if (textField == self.confirmTextField) {
        if (self.confirmTextField.text == self.passwordTextField.text) {
            [self.confirmTextField resignFirstResponder];
            return YES;
        } else {
            [self mismatchedPasswordsAlert];
            return NO;
        }
    }
    return NO;
}


#pragma mark - Helpers
- (void)styleButtons {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.iconRoundedView.layer.cornerRadius = self.iconRoundedView.frame.size.height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.submitLabel.layer.cornerRadius = self.submitLabel.frame.size.height / 2;
    self.submitLabel.layer.masksToBounds = YES;
}

- (void)setupTermsTextView {
    NSString *disclaimerString = NSLocalizedString(NSLocalizedString(@"SignUp.Disclaimer", @"get string for disclaimer"), @"get string for disclaimer");
    NSMutableAttributedString *disclaimerAttributed = [[NSMutableAttributedString alloc] initWithString:disclaimerString attributes:nil];
    [disclaimerAttributed addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:16.0] range:NSMakeRange(0, disclaimerAttributed.length)];
    [disclaimerAttributed addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, disclaimerAttributed.length)];
    [disclaimerAttributed addAttribute:NSUnderlineStyleAttributeName value:@"http://mytown.shop/terms" range:NSMakeRange(42, 12)];
    [disclaimerAttributed addAttribute:NSUnderlineStyleAttributeName value:@"http://mytown.shop/privacy" range:NSMakeRange(60, 14)];
    [disclaimerAttributed addAttribute:NSLinkAttributeName value:@"http://mytown.shop/terms" range:NSMakeRange(42, 12)];
    [disclaimerAttributed addAttribute:NSLinkAttributeName value:@"http://mytown.shop/privacy" range:NSMakeRange(60, 14)];
    self.disclaimerTextView.attributedText = disclaimerAttributed;
    self.disclaimerTextView.textAlignment = NSTextAlignmentCenter;
}

- (void)setupTextFields {
    if ([self.nameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SignUp.Name", @"get string for first name placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.nameTextField.floatingLabelTextColor = [UIColor blackColor];
        self.nameTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.nameTextField.floatingLabelActiveTextColor = [UIColor blackColor];
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    }
    if ([self.emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SignUp.Email", @"get string for Email placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.emailTextField.floatingLabelTextColor = [UIColor blackColor];
        self.emailTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.emailTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
    if ([self.passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SignUp.Password", @"get string for password placeholder ") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.passwordTextField.floatingLabelTextColor = [UIColor blackColor];
        self.passwordTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.passwordTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
    if ([self.confirmTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.confirmTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SignUp.Confirm", @"get string for confirm password placeholder ") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.confirmTextField.floatingLabelTextColor = [UIColor blackColor];
        self.confirmTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.confirmTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
    if ([self.phoneNumberTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"SignUp.PhoneNumber", @"get string for confirm password placeholder ") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.phoneNumberTextField.floatingLabelTextColor = [UIColor blackColor];
        self.phoneNumberTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.phoneNumberTextField.floatingLabelActiveTextColor = [UIColor blackColor];
    }
    self.submitLabel.text = NSLocalizedString(@"SignUp.Title", @"get string for sign up");
    self.alreadyAUserLabel.text = NSLocalizedString(@"SignUp.Already", @"get string for already a member");
}

- (void)setupTapGestures {
    UITapGestureRecognizer *tapToDismissConfirmKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideConfirmKeyboard)];
    [self.iconSuperView addGestureRecognizer:tapToDismissConfirmKeyboard];
}

- (BOOL)isEntryValid {
    return self.nameTextField.text.length && self.emailTextField.text.length && self.passwordTextField.text.length && [self isPasswordContainsUpperAndNumber:self.passwordTextField.text];
}

- (NSString *)errorMessage {
    NSMutableArray *messages = [NSMutableArray array];
    if (!self.nameTextField.text.length) {
        [messages addObject:NSLocalizedString(@"SignUp.NoName", @"info missing for create user")];
    }
    if (!self.emailTextField.text.length) {
        [messages addObject:NSLocalizedString(@"SignUp.NoEmail", @"info missing for create user")];
    }
    if (!self.passwordTextField.text.length) {
        [messages addObject:NSLocalizedString(@"SignUp.NoPassword", @"info missing for create user")];
    }
    if (![self isPasswordContainsUpperAndNumber:self.passwordTextField.text]) {
        [messages addObject:NSLocalizedString(@"SignUp.PasswordCase", @"info missing for create user")];
    }
    NSString *message = [messages componentsJoinedByString:@"\n"];
    return message;
}

- (BOOL)isPasswordContainsUpperAndNumber:(NSString*)password {//^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z]).*$
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$" options:0 error:nil];
    return [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])] > 0;
}

- (void)hideKeyboard {
    [self.nameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)hideConfirmKeyboard {
    [self.nameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
}

- (void)mismatchedPasswordsAlert {
    CakeAlertViewController *alertController = [[CakeAlertViewController alloc] initWithAlertTitle:NSLocalizedString(@"SignUp.PasswordMismatch", @"get string for password mismatch") message:nil];
    NYAlertAction *cancelAlertAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Alert.Ok", @"get string for alert action") style:UIAlertActionStyleCancel handler:^(NYAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAlertAction:cancelAlertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    return;
}

@end
