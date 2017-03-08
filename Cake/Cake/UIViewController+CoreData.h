//
//  UIViewController+CoreData.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CoreData)

- (NSManagedObjectContext *)managedObjectContext;
- (NSMutableArray*)retrieveObjects:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
- (NSMutableArray*)retrieveObjects:(NSString*)entityName withPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (void)saveContext;

@end
