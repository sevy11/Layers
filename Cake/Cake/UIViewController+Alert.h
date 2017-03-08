//
//  UIViewController+Alert.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeError,
    MessageTypeSuccess,
    MessageTypeWarning
};

@interface UIViewController (Alert)

- (void)showMessage:(NSString *)message withTitle:(NSString*)title;
- (void)showMessage:(NSString *)message withType:(MessageType)messageType;

@end
