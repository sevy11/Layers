//
//  User+CoreDataClass.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import "BaseAbstractModel+CoreDataClass.h"

static NSString *const kUsername = @"username";
static NSString *const kPassword = @"password";
static NSString *const kNewPassword = @"new_password";
static NSString *const kEmail = @"email";
static NSString *const kOldPassword = @"current_password";
static NSString *const kNewPasswordToken = @"token";

typedef NS_ENUM(NSInteger, ProfilePictureSize) {
    ProfilePictureSizeSmall,
    ProfilePictureSizeMedium,
    ProfilePictureSizeLarge,
    ProfilePictureSizeThumbDefault
} ;

typedef NS_ENUM(NSInteger, OrderMembersPriority) {
    OrderMembersPriorityCreator,
    OrderMembersPriorityCurrentUser,
    OrderMembersPriorityPaidUnpaid,
    OrderMembersPriorityWithItems,
    OrderMembersPriorityOther
};

typedef NS_ENUM(NSUInteger, Gender) {
    GenderMale = 1,
    GenderFemale = 2
};


NS_ASSUME_NONNULL_BEGIN


@interface User : BaseAbstractModel

+ (NSDictionary*)fieldMappings;
+ (User *)currentUser;
+ (void)setCurrentUser:(User * _Nullable)currentUser;
+ (UIImage*)getPlaceholderImage;
+ (NSDictionary*)fieldMappingsForUpdatingUser;
//- (NSURL*)getProfilePicUrlOfSize:(ProfilePictureSize)picSize;
- (BOOL)isAuthenticatedUser;
- (BOOL)isGuestUser;
- (NSString *)userName;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
