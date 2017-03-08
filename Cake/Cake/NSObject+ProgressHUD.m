//
//  NSObject+ProgressHUD.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "NSObject+ProgressHUD.h"

@implementation NSObject (ProgressHUD)

- (void)hideAllHUDs {
    [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
}

- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor *)color withOffset:(float)offset inMode:(MBProgressHUDMode)mode inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    hud.detailsLabelText = message;
    hud.mode = mode;
    hud.color = color;
    hud.yOffset = offset;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        usleep((unsigned int)duration);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideAllHUDs];
        });
    });
    if (dismissable) {
        [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAllHUDs)]];
    }
}

- (void)showHudWithTitle:(NSString *)title message:(NSString *)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor *)color inMode:(MBProgressHUDMode)mode {
    [self showHudWithTitle:title message:message forDuration:duration isDismissable:dismissable withColor:color withOffset:0.0 inMode:mode inView:[[[UIApplication sharedApplication] windows] lastObject]];
}

- (void)showHudWithTitle:(NSString *)title message:(NSString *)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor *)color {
    [self showHudWithTitle:title message:message forDuration:duration isDismissable:dismissable withColor:color inMode:MBProgressHUDModeText];
}

- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable {
    [self showHudWithTitle:title message:message forDuration:duration isDismissable:dismissable withColor:nil];
}

- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration {
    [self showHudWithTitle:title message:message forDuration:duration isDismissable:YES];
}

- (void)showHudWithTitleTop:(NSString*)title forDuration:(NSUInteger)duration withOffset:(float)offset {
    [self showHudWithTitle:title message:nil forDuration:duration isDismissable:YES withColor:nil withOffset:offset inMode:MBProgressHUDModeText inView:[[[UIApplication sharedApplication] windows] lastObject]];
}

- (void)showHudWithTitle:(NSString*)title message:(NSString*)message {
    [self showHudWithTitle:title message:message forDuration:1000000];
}

- (void)showHudWithTitle:(NSString*)title {
    [self showHudWithTitle:title message:nil forDuration:1000000];
}

- (void)showHudLoading {
    [self showHudWithTitle:NSLocalizedString(@"Hud.Loading", nil) message:nil forDuration:1000000];
}

- (void)showHud {
    [self showHudWithTitle:nil message:nil forDuration:1000000];
}

- (MBProgressHUD*)showProgressHudWithTitle:(NSString*)title message:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    hud.labelText = title;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}

- (void)hideProgressHud:(MBProgressHUD*)hud afterSuccess:(BOOL)success withTitle:(NSString *)title message:(NSString *)message {
    if (success) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud-checkmark"]];
    } else {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud-failed"]];
    }
    if (hud) {
        hud.labelText = title;
        hud.detailsLabelText = message;
        hud.mode = MBProgressHUDModeCustomView;
        [hud hide:YES afterDelay:1.5];
    } else {
        [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    }
}

- (void)hideProgressHud:(MBProgressHUD*)hud afterSuccess:(BOOL)success {
    [self hideProgressHud:hud afterSuccess:success withTitle:(success ? NSLocalizedString(@"Hud.Success.Title", nil) : NSLocalizedString(@"Hud.Failre.Title", nil)) message:(success ? NSLocalizedString(@"Hud.Success.Message", nil) : NSLocalizedString(@"Hud.Failre.Message", nil))];
}

@end
