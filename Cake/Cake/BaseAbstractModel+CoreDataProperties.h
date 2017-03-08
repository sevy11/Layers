//
//  BaseAbstractModel+CoreDataProperties.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "BaseAbstractModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaseAbstractModel (CoreDataProperties)

+ (NSFetchRequest<BaseAbstractModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *timeCreated;
@property (nullable, nonatomic, copy) NSDate *timeDeleted;
@property (nullable, nonatomic, copy) NSDate *timeUpdated;
@property (nullable, nonatomic, copy) NSNumber *baseId;

@end

NS_ASSUME_NONNULL_END
