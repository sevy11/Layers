//
//  UserManager.m
//  Cake
//
//  Created by Michael Sevy on 4/2/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "UserManager.h"
#import "Config.h"

static UserManager  *_sharedManager = nil;

@implementation UserManager

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize singleton here
    }

    return self;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[UserManager alloc] init];
        // Do any other initialization stuff here
    });
    return _sharedManager;
}

- (AWSCognitoIdentityUserPool*)userPool {
    //setup service config
    AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:nil];
    //create a pool
    AWSCognitoIdentityUserPoolConfiguration *configuration = [[AWSCognitoIdentityUserPoolConfiguration alloc] initWithClientId:kAWSClientId clientSecret:kAWSClientSecret poolId:kUserPoolId];
    [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration userPoolConfiguration:configuration forKey:@"UserPool"];
    return [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
}

@end
