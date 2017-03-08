//
//  ViewController.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "Kumulos.h"
#import "Config.h"
#import "APIClient.h"
#import "User+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Kumulos *kumulos = [[Kumulos alloc] initWithAPIKey:kKumulosAPIKey andSecretKey:kKumulosKeySecret];
    
    //first API call
    //Kumulos helper
    //    NSDictionary *params = @{@"firstName" : @"Michael", @"lastName" : @"Sevy", @"userId" : @"1", @"timeCreated" : [NSDate date] };
    //    [kumulos callMethod:@"createUser" withParams:params success:^(KSAPIResponse *response, KSAPIOperation *operation) {
    //        NSArray *userInfo = response.payload;
    //        NSLog(@"success: %@", userInfo);
    //    } andFailure:^(NSError *error, KSAPIOperation *operation) {
    //        NSLog(@"error: %@", error.localizedDescription);
    //    }];


    //    Merchant *merchant;
    //    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Merchant" inManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
    //    merchant = [[Merchant alloc] initWithEntity:entity insertIntoManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];

    
    User *user;
    //NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
    //user = [[User alloc] initWithEntity:entity insertIntoManagedObjectContext:[RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext];
    user.firstName = @"Michael";
    user.lastName = @"Sevy";
    user.email = @"michaelSevy@gmail.com";

    [APIClient createUser:user success:^(User *user) {
        NSLog(@"user*********: %@", user);

    } failure:^(NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    
}


@end
