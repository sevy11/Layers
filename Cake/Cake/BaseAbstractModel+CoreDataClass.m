//
//  BaseAbstractModel+CoreDataClass.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "BaseAbstractModel+CoreDataClass.h"
#import <objc/runtime.h>

@implementation BaseAbstractModel

+ (NSDictionary*)fieldMappings {
    return @{ @"userID": @"userId",
              @"timeCreated": @"timeCreated",
              @"timeUpdated": @"timeUpdated"
              };
}

+ (NSDictionary*)daysMap {
    return @{ @(WeekDayMonday): @"Monday",
              @(WeekDayTuesday): @"Tuesday",
              @(WeekDayWednesday): @"Wednesday",
              @(WeekDayThursday): @"Thursday",
              @(WeekDayFriday): @"Friday",
              @(WeekDaySaturday): @"Saturday",
              @(WeekDaySunday): @"Sunday"
              };
}

+ (NSDictionary*)shortDaysMap {
    return @{ @(WeekDayMonday): @"Mo",
              @(WeekDayTuesday): @"Tu",
              @(WeekDayWednesday): @"We",
              @(WeekDayThursday): @"Th",
              @(WeekDayFriday): @"Fr",
              @(WeekDaySaturday): @"Sa",
              @(WeekDaySunday): @"Su"
              };
}

+ (NSDictionary*)gendersMap {
    return @{ @(GenderTypeMale): @"Male",
              @(GenderTypeFemale): @"Female"
              };
}

+ (NSString*)entityName {
    return NSStringFromClass([self class]);
}

+ (UIImage*)placeholderImage {
    static UIImage *_placeholderImage;
    _placeholderImage = [UIImage imageNamed:@"placeholder"];
    return _placeholderImage;
}

+ (NSString*)stringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    return [dateFormatter stringFromDate:date];
}

+ (NSNumber*)numberFromString:(NSString*)string {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

+ (void)downloadImageInBackgroundFromUrl:(NSURL*)imageUrl success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure {
    //
    //    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    //
    //    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
    //        if (success) {
    //            success(image);
    //        }
    //    }];
    //    [operation start];
}

- (void)setNilValueForKey:(NSString *)key {
    // subclassing silences exception
    //    [self setValue:[NSNull null] forKeyPath:key];
}

#pragma mark - Helpers
+ (NSString *)formattedCurrencyStringForAmount:(double)amount {
    if (amount == 0.00) {
        return @"$0.00";
    } else {
        NSString *formattedString = [NSString stringWithFormat:@"$%.02f", amount];
        return formattedString;
    }
}

+ (double)roundUpAmount:(double)amount toDecimalPlaces:(int)decimalPlaces {
    return ceil(amount * pow(10, decimalPlaces)) / pow(10, decimalPlaces);
}

+ (double)roundDownAmount:(double)amount toDecimalPlaces:(int)decimalPlaces {
    return ((int)(amount * pow(10, decimalPlaces))) / pow(10, decimalPlaces);
}

@end
