//
//  UIViewController+CoreData.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "UIViewController+CoreData.h"
#import <CoreData/CoreData.h>

@implementation UIViewController (CoreData)


#pragma mark - Core Data
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) context = [delegate managedObjectContext];
    return context;
}

- (NSMutableArray*)retrieveObjects:(NSString*)entityName withPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
    if (sortDescriptor) {
        fetchRequest.sortDescriptors = @[sortDescriptor];
    }
    fetchRequest.predicate = predicate;
    return [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (NSMutableArray*)retrieveObjects:(NSString*)entityName withPredicate:(NSPredicate*)predicate {
    return [self retrieveObjects:entityName withPredicate:predicate sortDescriptor:nil];
}

- (void)saveContext {
    NSError *error;
    if (![[self managedObjectContext] save:&error]) {
    }
}

@end
