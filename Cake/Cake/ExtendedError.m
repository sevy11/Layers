//
//  ExtendedError.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "ExtendedError.h"

@implementation ExtendedError

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionary];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"username": @"username",
                                              @"id": @"userId",
                                              @"first_name": @"firstName",
                                              @"last_name": @"lastName",
                                              @"phone": @"phone",
                                              @"birth_date": @"birthDate",
                                              @"email": @"email",
                                              @"gender": @"gender",
                                              @"token": @"token",
                                              @"password": @"password",
                                              @"phone": @"phone",
                                              @"photo": @"profileImageUrl",
                                              @"non_field_errors": @"nonFieldErrors",
                                              @"detail": @"detail",
                                              @"image": @"image",
                                              @"active_days": @"activeDays",
                                              @"genders": @"genders",
                                              @"age_groups": @"ageGroups",
                                              @"old_password": @"oldPassword",
                                              @"uuid": @"uuid",
                                              @"push_token": @"deviceToken",
                                              @"delivery_address": @"deliveryAddress",
                                              @"guest_email": @"guestEmail",
                                              @"basket": @"basket",
                                              @"phone_number": @"phoneNumber",
                                              @"special_instructions": @"specialInstructions",
                                              @"referral_code": @"referralCode",
                                              @"new_email": @"newEmail"
                                              }];
    return fieldMappings;
}

- (void)setUsername:(NSArray *)username {
    _username = username;
    [self appendErrors:username forKey:@"Username"];
}
- (void)setFirstName:(NSArray *)firstName {
    _firstName = firstName;
    [self appendErrors:firstName forKey:@"Firstname"];
}
- (void)setLastName:(NSArray *)lastName {
    _lastName = lastName;
    [self appendErrors:lastName forKey:@"Lastname"];
}
- (void)setEmail:(NSArray *)email {
    _email = email;
    [self appendErrors:email forKey:@"Email"];
}
- (void)setToken:(NSArray *)token {
    _token = token;
    [self appendErrors:token forKey:@"Token"];
}
- (void)setPassword:(NSArray *)password {
    _password = password;
    [self appendErrors:password forKey:@"Password"];
}
- (void)setOldPassword:(NSArray *)oldPassword {
    _oldPassword = oldPassword;
    [self appendErrors:oldPassword forKey:@"Old Password"];
}
- (void)setPhone:(NSArray *)phone {
    _phone = phone;
    [self appendErrors:phone forKey:@"Phone"];
}

- (void)setRole:(NSArray *)role {
    _role = role;
    [self appendErrors:role forKey:@"User Role"];
}

- (void)setImage:(NSArray *)image {
    _image = image;
    [self appendErrors:image forKey:@"Image"];
}

- (void)setActiveDays:(NSArray *)activeDays {
    _activeDays = activeDays;
    [self appendErrors:activeDays forKey:@"Active Days"];
}

- (void)setGenders:(NSArray *)genders {
    _genders = genders;
    [self appendErrors:genders forKey:@"Gender"];
}

- (void)setAgeGroups:(NSArray *)ageGroups {
    _ageGroups = ageGroups;
    [self appendErrors:ageGroups forKey:@"Age Groups"];
}

- (void)setUuid:(NSArray *)uuid {
    _uuid = uuid;
    [self appendErrors:uuid forKey:@"UUID"];
}

- (void)setDeviceToken:(NSArray *)deviceToken {
    _deviceToken = deviceToken;
    [self appendErrors:deviceToken forKey:@"Device Token"];
}

- (void)setDeliveryAddress:(NSArray *)deliveryAddress {
    _deliveryAddress = deliveryAddress;
    [self appendErrors:deliveryAddress forKey:@"Delivery Address"];
}

- (void)setGuestEmail:(NSArray *)guestEmail {
    _guestEmail = guestEmail;
    [self appendErrors:guestEmail forKey:@"Guest Email"];
}

- (void)setBasket:(NSArray *)basket {
    _basket = basket;
    [self appendErrors:basket forKey:@"Basket"];
}

- (void)setPhoneNumber:(NSArray *)phoneNumber {
    _phoneNumber = phoneNumber;
    [self appendErrors:phoneNumber forKey:@"Phone Number"];
}

- (void)setSpecialInstructions:(NSArray *)specialInstructions {
    _specialInstructions = specialInstructions;
    [self appendErrors:specialInstructions forKey:@"Special Instructions"];
}

- (void)setReferralCode:(NSArray *)referralCode {
    _referralCode = referralCode;
    [self appendErrors:referralCode forKey:@"Referral Code"];
}

- (void)setNewEmail:(NSArray *)changedEmail {
    _changedEmail = changedEmail;
    [self appendErrors:changedEmail forKey:@"newEmail"];
}

- (void)setValidationErrorsDict:(NSDictionary *)validationErrorsDict {
    _validationErrorsDict = validationErrorsDict;

    if (!self.errorMessage) {
        self.errorMessage = @"";
    }

    for (NSDictionary *errorField in validationErrorsDict) {
        self.errorMessage = [self.errorMessage stringByAppendingFormat:@"%@.\n", [validationErrorsDict objectForKey:errorField]];
    }
}

- (void)setNonFieldErrors:(NSArray *)nonFieldErrors {
    _nonFieldErrors = nonFieldErrors;

    [self appendErrors:nonFieldErrors forKey:nil];
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;

    if (!self.errorMessage) {
        self.errorMessage = @"";
    }
    self.errorMessage = [self.errorMessage stringByAppendingFormat:@"Attention: %@\n", detail];
}
- (void)setError:(NSString *)error {
    _error = error;

    if (!self.errorMessage) {
        self.errorMessage = @"";
    }
    self.errorMessage = [self.errorMessage stringByAppendingFormat:@"Error: %@\n", error];
}

#pragma mark - Helpers
- (void)appendErrors:(NSArray*)errors forKey:(NSString*)key {
    if (!self.errorMessage) {
        self.errorMessage = @"";
    }

    for (NSString *errorMessage in errors) {
        self.errorMessage = (key ? [self.errorMessage stringByAppendingFormat:@"%@. 🤔\n", errorMessage] : [self.errorMessage stringByAppendingFormat:@"%@\n", errorMessage]);
    }
}

@end
