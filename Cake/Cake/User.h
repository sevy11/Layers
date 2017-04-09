//
//  User.h
//  Cake
//
//  Created by Michael Sevy on 3/22/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kUsername = @"username";
static NSString *const kPassword = @"password";
static NSString *const kNewPassword = @"new_password";
static NSString *const kEmail = @"email";
static NSString *const kOldPassword = @"current_password";
static NSString *const kNewPasswordToken = @"token";


NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nullable, nonatomic, retain) NSDate *birthDate;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSURL *imageUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *website;
@property (nullable, nonatomic, retain) NSString *referralCode;

//+ (User *)currentUser;
+ (void)setCurrentUser:(User * _Nullable)currentUser;
//+ (NSDictionary*)fieldMappingsForUpdatingUser;
//- (NSURL*)getProfilePicUrlOfSize:(ProfilePictureSize)picSize;
- (BOOL)isAuthenticatedUser;
//- (BOOL)isGuestUser;
- (NSString *)userName;

@end

NS_ASSUME_NONNULL_END
