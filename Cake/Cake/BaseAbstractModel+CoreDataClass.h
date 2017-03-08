//
//  BaseAbstractModel+CoreDataClass.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Config.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAbstractModel : NSManagedObject

+ (NSString*)entityName;
+ (NSDictionary*)fieldMappings;
+ (NSDictionary*)daysMap;
+ (NSDictionary*)shortDaysMap;
+ (NSDictionary*)gendersMap;
+ (UIImage*)placeholderImage;
+ (NSString*)stringFromDate:(NSDate*)date;
+ (NSNumber*)numberFromString:(NSString*)string;
+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;
+ (NSString*)formattedCurrencyStringForAmount:(double)amount;
+ (void)downloadImageInBackgroundFromUrl:(NSURL*)imageUrl success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
+ (double)roundUpAmount:(double)amount toDecimalPlaces:(int)decimalPlaces;
+ (double)roundDownAmount:(double)amount toDecimalPlaces:(int)decimalPlaces;

@end

NS_ASSUME_NONNULL_END

#import "BaseAbstractModel+CoreDataProperties.h"
