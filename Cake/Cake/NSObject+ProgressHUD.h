//
//  NSObject+ProgressHUD.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

static const NSUInteger HUDDuration1Second = 1000000;
static const NSUInteger HUDDuration3Seconds = HUDDuration1Second * 3;
static const NSUInteger HUDDuration5Seconds = HUDDuration1Second * 5;
static const NSUInteger HUDDuration10Seconds = HUDDuration1Second * 10;

@interface NSObject (ProgressHUD)

- (void)hideAllHUDs;

- (void)showHud;
- (void)showHudLoading;
- (void)showHudWithTitle:(NSString*)title;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration;
- (void)showHudWithTitleTop:(NSString*)title forDuration:(NSUInteger)duration withOffset:(float)offset;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor*)color;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor*)color inMode:(MBProgressHUDMode)mode;
- (void)showHudWithTitle:(NSString*)title message:(NSString*)message forDuration:(NSUInteger)duration isDismissable:(BOOL)dismissable withColor:(UIColor*)color withOffset:(float)offset inMode:(MBProgressHUDMode)mode inView:(UIView*)view;
- (MBProgressHUD*)showProgressHudWithTitle:(NSString*)title message:(NSString*)message;
- (void)hideProgressHud:(MBProgressHUD*)hud afterSuccess:(BOOL)success;
- (void)hideProgressHud:(MBProgressHUD*)hud afterSuccess:(BOOL)success withTitle:(NSString*)title message:(NSString*)message;

@end
