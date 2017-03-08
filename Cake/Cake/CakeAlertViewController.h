//
//  CakeAlertViewController.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <NYAlertViewController/NYAlertViewController.h>
#import <NYAlertViewController/NYAlertView.h>

@interface CakeAlertViewController : NYAlertViewController

- (instancetype)initWithAlertTitle:(NSString *)alertTitle message:(NSString *)alertMessage;
- (void)addAlertAction:(NYAlertAction *)alertAction;

@end
