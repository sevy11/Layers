//
//  APIClient.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "User+CoreDataClass.h"

//@class User;

typedef NS_ENUM(NSInteger, StatusCode) {
    StatusCodeCreated = 201,
    StatusCodeUnauthorized = 401,
    StatusCodeConflict = 409
};

typedef void (^CompletionBlock) (NSArray *objects, NSUInteger page);

@interface APIClient : NSObject

///----------------------------------------------
/// @name Configuring the Shared API Client Instance
///----------------------------------------------
/**
 Return the shared instance of the API Client

 @return The shared API client instance.
 */
+ (instancetype)sharedClient;

- (BOOL)isNetworkReachable;

//+ (void)createUser:(User *)user success:(void (^)(User *user))success failure:(void (^)(NSError *error))failure;

@end
