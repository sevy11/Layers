//
//  UserManager.h
//  Cake
//
//  Created by Michael Sevy on 4/2/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWSCognitoIdentityProvider.h"

@interface UserManager : NSObject

+ (instancetype)sharedManager;

- (AWSCognitoIdentityUserPool*)userPool;

@end
