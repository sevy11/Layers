//
//  User+CoreDataClass.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//  This file was automatically generated and should not be edited.
//
/*
#import "User+CoreDataClass.h"
#import <Restkit/CoreData.h>

static UIImage *_placeholderImage = nil;
static User *_currentUser = nil;

@implementation User

+ (NSDictionary*)fieldMappings {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"userID": @"userId",
                                              @"username": @"username",
                                              @"email": @"email",
                                              @"first_name":@"firstName",
                                              @"last_name":@"lastName",
                                              @"password": @"password",
                                              @"token": @"token",
                                              @"avatar.full_size": @"imageUrl"
                                              }];
    return fieldMappings;
}

+ (NSDictionary*)fieldMappingsForUpdatingUser {
    NSMutableDictionary *fieldMappings = [NSMutableDictionary dictionaryWithDictionary:[super fieldMappings]];
    [fieldMappings addEntriesFromDictionary:@{
                                              @"id": @"userId",
                                              @"email": @"email",
                                              @"first_name":@"firstName",
                                              @"last_name":@"lastName",
                                              @"password": @"password",
                                              @"token": @"token",
                                              @"avatar.full_size": @"imageUrl"
                                              }];
    return fieldMappings;
}

#pragma mark - Setters
+ (User *)currentUser {
    if ([RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext) {
        if (!_currentUser) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
            fetchRequest.entity = entity;
            NSPredicate *predicate = [NSPredicate predicateWithFormat: @"userId == %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserId"]];
            [fetchRequest setPredicate:predicate];
            NSError *error = nil;
            NSArray *result = [[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (result.count) {
                _currentUser = (User *)result.firstObject;
            } else {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
                _currentUser = [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
            }
        }
    }
    return _currentUser;
}

+ (void)setCurrentUser:(User* _Nullable)currentUser {
    _currentUser = currentUser;
    [[NSUserDefaults standardUserDefaults] setValue:currentUser.userId forKey:@"currentUserId"];
    [[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext saveToPersistentStore:nil];
}

- (BOOL)isEqualToUser:(id)object {
    if (!object) {
        return NO;
    }
    return [self.userId isEqualToNumber:((User*)object).userId];
}


#pragma mark - Helpers
+ (UIImage*)getPlaceholderImage {
    if (_placeholderImage == nil) {
        _placeholderImage = [UIImage imageNamed:@"placeholder-user.png"];
    }
    return _placeholderImage;
}

//- (NSURL*)getProfilePicUrlOfSize:(ProfilePictureSize)picSize {
//    if (self.image) {
//        NSString *urlString = [NSString stringWithFormat:@"%@", self.imageUrl];
//        return [NSURL URLWithString:urlString];
//    }
//    return nil;
//}

//- (NSURL*)profilePicUrl {
//    return [self getProfilePicUrlOfSize:ProfilePictureSizeThumbDefault];
//}

- (BOOL)isAuthenticatedUser {
    if (self.email.length > 0 || self.firstName.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isGuestUser {
    if (!([User currentUser].email.length > 0) && [User currentUser].firstName.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)userName {
    NSString *fullname;
    if (self.firstName.length && self.lastName.length) {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, [[self.lastName substringToIndex:1] uppercaseString]];
    }
    if (self.firstName.length) {
        return self.firstName;
    }
    if (self.lastName.length) {
        return self.lastName;
    }
    return fullname;
}
*/
//@end
