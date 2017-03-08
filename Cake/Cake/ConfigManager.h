//
//  ConfigManager.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

typedef NS_ENUM(NSUInteger, EnvironmentMode) {
    EnvironmentModeLocal,
    EnvironmentModeStaging,
    EnvironmentModeStable,
    EnvironmentModeProduction
};

static NSString *const kAppTypeUserApp = @"user";
static NSString *const kAppTypeCustomerApp = @"customer";

@interface ConfigManager : NSObject

@property (nonatomic, assign) EnvironmentMode environmentMode;

/**
 Return the shared instance of the ConfigManager

 @return The shared api instance.
 */
+ (instancetype)sharedManager;

- (id)configForKey:(NSString*)key;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *TestflightToken;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *CrashlyticsAPIKey;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *GAKey;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *apiUrl;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *pushUrl;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *webUrl;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *facebookAppId;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *facebookSecret;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *linkedinAppId;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *linkedinAppSecret;
@property (NS_NONATOMIC_IOSONLY, readonly, assign) BOOL allowFacebookLogin;

// Custom Configs
- (NSString *)appType;
- (NSString *)braintree;
- (NSString *)braintreeURL;

@end
