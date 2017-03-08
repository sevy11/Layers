//
//  User+CoreDataProperties.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic password;
@dynamic userId;
@dynamic username;
@dynamic phoneNumber;

@end
