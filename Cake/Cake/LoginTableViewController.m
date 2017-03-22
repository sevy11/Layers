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
#import "User+CoreDataClass.h"
#import "NSObject+ProgressHUD.h"
#import "UIViewController+Alert.h"

typedef NS_ENUM(NSUInteger, LoginSelectedStaticCell){
    LoginSelectedStaticCellEmailEntry = 0,
    LoginSelectedStaticCellPasswordEntry,
    LoginSelectedStaticCellLogIn,
    LoginSelectedStaticCellForgotPassword,
    LoginSelectedStaticCellCreateAccount
};

@interface LoginTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *iconSuperView;
@property (weak, nonatomic) IBOutlet UIView *iconRoundedView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
//@property (weak, nonatomic) IBOutlet UILabel *forgotPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAccountLabel;

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleViews];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    UITapGestureRecognizer *tapTodismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.iconSuperView addGestureRecognizer:tapTodismissKeyboard];
    [self.iconImageView addGestureRecognizer:tapTodismissKeyboard];
    [self.iconSuperView addGestureRecognizer:tapTodismissKeyboard];
    


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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == LoginSelectedStaticCellLogIn) {
        if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
            [User currentUser].email = self.emailTextField.text;
            [User currentUser].password = self.passwordTextField.text;
            [self showProgressHudWithTitle:NSLocalizedString(@"CreateUser.LoggingIn", @"get string for log in message") message:nil];



            //setup service config
            AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:nil];
            //create a pool
            AWSCognitoIdentityUserPoolConfiguration *configuration = [[AWSCognitoIdentityUserPoolConfiguration alloc] initWithClientId:kAWSClientId clientSecret:kAWSClientSecret poolId:kUserPoolId];
            [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration userPoolConfiguration:configuration forKey:@"UserPool"];
            AWSCognitoIdentityUserPool *pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];


            NSMutableArray * attributes = [NSMutableArray array];

            //Set user attributes by retrieving them from your UI.  These values are hardcoded for this example
            AWSCognitoIdentityUserAttributeType *email = [AWSCognitoIdentityUserAttributeType new];
            AWSCognitoIdentityUserAttributeType *password = [AWSCognitoIdentityUserAttributeType new];

            //phone.name = @"phone_number";
            //All phone numbers require +country code as a prefix
            //phone.value = @"+15555555555";

            email.name = @"email";
            email.value = self.emailTextField.text;
            password.name = @"password";
            password.value = self.passwordTextField.text;

            [attributes addObject:email];
            [attributes addObject:password];

            //set username and password by retrieving them from your UI.  They are hardcoded in this example.
            AWSCognitoIdentityUser *user = [[pool signUp:self.emailTextField.text password:self.passwordTextField.text userAttributes:attributes validationData:nil] continueWithSuccessBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUser *> * _Nonnull task) {
                NSLog(@"Successfully registered user: %@",task.result.username);
                return nil;
            }];



        } else {
            [self hideAllHUDs];
            [self showMessage:NSLocalizedString(@"Login.NoCredentials", @"user has to fill out creds") withType:MessageTypeError];
        }
    } else if (indexPath.row == LoginSelectedStaticCellForgotPassword) {
        [self performSegueWithIdentifier:kForgotSegue sender:self];
    } else if (indexPath.row == LoginSelectedStaticCellCreateAccount) {
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(ColorValueMTDBackgroundRed);
        [self performSegueWithIdentifier:kCreateAccountSegue sender:self];
    }
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
- (void)setUpPool {
    
}
- (void)styleViews {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.iconRoundedView.layer.cornerRadius = self.iconRoundedView.frame.size.width / 2;
    self.iconRoundedView.layer.masksToBounds = YES;
    self.loginLabel.layer.cornerRadius = self.loginLabel.frame.size.height / 2;
    self.loginLabel.layer.masksToBounds = YES;
    if ([self.emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login.Email", @"get string for email placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.emailTextField.floatingLabelTextColor = [UIColor blackColor];
        self.emailTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
    }
    if ([self.passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login.Password", @"get string for password textfield placeholder") attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        self.passwordTextField.floatingLabelTextColor = [UIColor blackColor];
        self.passwordTextField.floatingLabelFont = [UIFont fontWithName:kDefaultFont size:15.0];
    }
}

- (void)hideKeyboard {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
