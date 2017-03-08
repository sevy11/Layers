//
//  ConfigManager.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//
#import "ConfigManager.h"

static ConfigManager  *_sharedManager = nil;

// Files
static NSString *const kGlobalAppConfig     = @"GlobalAppConfig";
static NSString *const kTypeAppConfig       = @"TypeAppConfig";
static NSString *const kDefaultAppConfig    = @"DefaultAppConfig";
static NSString *const kAppConfig           = @"AppConfig";

// Config Keys ***********
// Generic Keys
static NSString *const kTestFlightToken         = @"TestFlightToken";
static NSString *const kCrashlyticsAPIKey       = @"CrashlyticsToken";
static NSString *const kGAKey                   = @"GAKey";
static NSString *const kApiUrl                  = @"ApiUrl";
static NSString *const kPushUrl                 = @"PushUrl";
static NSString *const kWebUrl                  = @"WebUrl";
static NSString *const kLocal                   = @"Local";
static NSString *const kStaging                 = @"Staging";
static NSString *const kStable                  = @"Stable";
static NSString *const kProduction              = @"Production";
static NSString *const kAllowFacebookLogin      = @"AllowFacebookLogin";
// Custom Keys
static NSString *const kAppType                 = @"AppType";
static NSString *const kBraintree               = @"Braintree";
static NSString *const kBraintreeURL            = @"BraintreeURL";
static NSString *const kFacebook                = @"Facebook";
static NSString *const kFacebookAppId           = @"AppId";
static NSString *const kFacebookSecret          = @"Secret";
static NSString *const kLinkedIn                = @"LinkedIn";
static NSString *const kLinkedInAppId           = @"LinkedInAppId";
static NSString *const kLinkedInSecret          = @"LinkedInSecret";

// Misc Keys

// Defaults Keys

// ***********************

@interface ConfigManager ()

@property (nonatomic, strong) NSArray *configFiles;
@property (nonatomic, strong) NSDictionary *configs;

- (void)loadConfigs;

@end

@implementation ConfigManager

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize singleton here
        // List all files from Generic to Specific
        self.configFiles = @[
                             kGlobalAppConfig,
                             kTypeAppConfig
                             ];

        [self loadConfigs];
    }

    return self;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ConfigManager alloc] init];
        // Do any other initialization stuff here
    });
    return _sharedManager;
}

- (void)loadConfigs {
    // load config components from file (if any)
    NSMutableDictionary *configs = [NSMutableDictionary dictionary];
    for (NSString* fileName in self.configFiles) {
        NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        if (localizedPath == nil) {
            continue;
        }
        [configs addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:localizedPath]];
    }
    self.configs = [configs copy];
}

- (id)configForKey:(NSString *)key {
    return [self.configs valueForKey:key];
}

- (NSString*)TestflightToken {
    return [self configForKey:kTestFlightToken];
}

- (NSString*)CrashlyticsAPIKey {
    return [self configForKey:kCrashlyticsAPIKey];
}

- (NSString*)GAKey {
    return [self configForKey:kGAKey];
}

- (id)getEnvironmentSpecificValueFromDictionary:(NSDictionary*)values {
    switch (self.environmentMode) {
            case EnvironmentModeLocal:
            return values[kLocal];
            case EnvironmentModeStaging:
            return values[kStaging];
            case EnvironmentModeStable:
            return values[kStable];
            case EnvironmentModeProduction:
        default:
            return values[kProduction];
    }
}

- (NSString*)apiUrl {
    NSDictionary *apiUrls = [self configForKey:kApiUrl];
    return [self getEnvironmentSpecificValueFromDictionary:apiUrls];
}

- (NSString*)pushUrl {
    NSDictionary *pushUrls = [self configForKey:kPushUrl];
    return [self getEnvironmentSpecificValueFromDictionary:pushUrls];
}

- (NSString*)webUrl {
    NSDictionary *webUrls = [self configForKey:kWebUrl];
    return [self getEnvironmentSpecificValueFromDictionary:webUrls];
}

- (NSString *)facebookAppId {
    NSDictionary *facebookInfo = [self configForKey:kFacebook];
    NSDictionary *environmentSpecificFacebookInfo = [self getEnvironmentSpecificValueFromDictionary:facebookInfo];
    NSString *facebookAppId = environmentSpecificFacebookInfo[kFacebookAppId];
    NSAssert(facebookAppId.length > 0, @"Facebook App Id Not Entered In Global Config!");
    return facebookAppId;
}

// not currently filled in but added in case later necessary
- (NSString *)facebookSecret {
    NSDictionary *facebookInfo = [self configForKey:kFacebook];
    NSDictionary *environmentSpecificFacebookInfo = [self getEnvironmentSpecificValueFromDictionary:facebookInfo];
    NSString *facebookSecret = environmentSpecificFacebookInfo[kFacebookSecret];
    NSAssert(facebookSecret.length > 0, @"Facebook Secret Not Entered In Global Config!");
    return facebookSecret;
}

- (NSString *)linkedinAppId {
    NSDictionary *linkedinInfo = [self configForKey:kLinkedIn];
    NSString *linkedinAppId = linkedinInfo[kLinkedInAppId];
    NSAssert(linkedinAppId.length > 0, @"Linkedin App Id Not Entered In Global Config!");
    return linkedinAppId;
}

- (NSString *)linkedinAppSecret {
    NSDictionary *linkedinInfo = [self configForKey:kLinkedIn];
    NSString *linkedinSecret = linkedinInfo[kLinkedInSecret];
    NSAssert(linkedinSecret.length > 0, @"Linkedin Secret Not Entered in Global Config!");
    return linkedinSecret;
}

- (BOOL)allowFacebookLogin {
    return [[self configForKey:kAllowFacebookLogin] boolValue];
}

// Custom Config
- (NSString*)appType {
    return [self configForKey:kAppType];
}

- (NSString *)braintree {
    return [self configForKey:kBraintree];
}

- (NSString *)braintreeURL {
    return [self configForKey:kBraintreeURL];
}

@end
