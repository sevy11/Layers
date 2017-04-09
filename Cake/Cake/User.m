//
//  User.m
//  Cake
//
//  Created by Michael Sevy on 3/22/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "User.h"
#import <CoreData/CoreData.h>

static User *_currentUser = nil;

@implementation User


#pragma mark - Setters
//+ (User *)currentUser {
  //      if (!_currentUser) {

            //Initialize the core data object here
 //           NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:]];
   //         User *user = nsentit



            //User *user = [User new];
//            user.firstName = _firstName;

            //UNRESTKITTED
            //NSFetchRequest *fetch = [NSFetchRequest new];
            //NSManagedObjectContext *managedContext =
            //NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:];

            /* RESTKIT
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
             */

 //   return _currentUser;
//}

+ (void)setCurrentUser:(User* _Nullable)currentUser {
    _currentUser = currentUser;
    //[[NSUserDefaults standardUserDefaults] setValue:currentUser.userId forKey:@"currentUserId"];
    //[[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext saveToPersistentStore:nil];
}

- (BOOL)isEqualToUser:(id)object {
    if (!object) {
        return NO;
    }
    return [self.userId isEqualToNumber:((User*)object).userId];
}


#pragma mark - Helpers
- (BOOL)isAuthenticatedUser {
    if (self.email.length > 0 || self.firstName.length > 0) {
        return YES;
    } else {
        return NO;
    }
}
//
//- (BOOL)isGuestUser {
//    if (!([User currentUser].email.length > 0) && [User currentUser].firstName.length > 0) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

- (NSString *)userName {
    if (self.firstName.length && self.lastName.length) {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, [[self.lastName substringToIndex:1] uppercaseString]];
    }
    if (self.firstName.length) {
        return self.firstName;
    }
    if (self.lastName.length) {
        return self.lastName;
    }
    return self.name;
}

@end
