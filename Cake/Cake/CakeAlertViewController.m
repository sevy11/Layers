//
//  CakeAlertViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "CakeAlertViewController.h"
#import "Config.h"

@implementation CakeAlertViewController

- (instancetype)initWithAlertTitle:(NSString *)title message:(NSString *)message {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = title;
        self.message = message;
        self.buttonCornerRadius = 3.0;
        self.titleFont = [UIFont fontWithName:kDefaultFont size:15.0];
        self.messageFont = [UIFont fontWithName:kDefaultFont size:13.0];
        self.buttonTitleFont = [UIFont fontWithName:kDefaultFont size:13.0];
        self.cancelButtonTitleFont = [UIFont fontWithName:kDefaultFont size:13.0];
        self.swipeDismissalGestureEnabled = YES;
        self.backgroundTapDismissalGestureEnabled = YES;
        self.alertViewBackgroundColor = UIColorFromRGB(ColorValueUCLABlue);
        self.titleColor = [UIColor blackColor];
        self.messageColor = [UIColor blackColor];
        self.buttonColor = [UIColor whiteColor];
        self.buttonTitleColor = [UIColor blackColor];
        self.cancelButtonColor = [UIColor whiteColor];
        self.cancelButtonTitleColor = [UIColor blackColor];
    }
    return self;
}

- (void)addAlertAction:(NYAlertAction *)alertAction {
    [self addAction:alertAction];
}

@end
