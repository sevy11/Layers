//
//  BaseAbstractModel+CoreDataProperties.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "BaseAbstractModel+CoreDataProperties.h"

@implementation BaseAbstractModel (CoreDataProperties)

+ (NSFetchRequest<BaseAbstractModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BaseAbstractModel"];
}

@dynamic timeCreated;
@dynamic timeDeleted;
@dynamic timeUpdated;
@dynamic baseId;

@end
