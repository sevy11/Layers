//
//  ExtendedError.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "RKErrorMessage.h"

@interface ExtendedError : RKErrorMessage

@property (nonatomic, strong) NSArray *username;
@property (nonatomic, strong) NSArray *firstName;
@property (nonatomic, strong) NSArray *lastName;
@property (nonatomic, strong) NSArray *email;
@property (nonatomic, strong) NSArray *token;
@property (nonatomic, strong) NSArray *password;
@property (nonatomic, strong) NSArray *oldPassword;
@property (nonatomic, strong) NSArray *phone;
@property (nonatomic, strong) NSArray *role;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSArray *activeDays;
@property (nonatomic, strong) NSArray *genders;
@property (nonatomic, strong) NSArray *ageGroups;
@property (nonatomic, strong) NSArray *uuid;
@property (nonatomic, strong) NSArray *deviceToken;
@property (nonatomic, strong) NSArray *deliveryAddress;
@property (nonatomic, strong) NSArray *guestEmail;
@property (nonatomic, strong) NSArray *basket;
@property (nonatomic, strong) NSArray *phoneNumber;
@property (nonatomic, strong) NSArray *specialInstructions;
@property (nonatomic, strong) NSArray *referralCode;
@property (nonatomic, strong) NSArray *changedEmail;

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *error;
@property (nonatomic, assign) NSUInteger responseCode;
@property (nonatomic, strong) NSArray *nonFieldErrors;
@property (nonatomic, strong) NSDictionary *validationErrorsDict;

+ (NSDictionary*)fieldMappings;

@end
