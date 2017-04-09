//
//  CakeAbstractTableViewCell.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import "Config.h"
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>
#import <YYWebImage/YYWebImage.h>

@interface CakeAbstractTableViewCell : MGSwipeTableCell

+ (NSString*)reuseIdentifier;

+ (CGFloat)estimatedHeight;
+ (CGFloat)height;
- (void)changeAccessoryType:(CakeAbstractTableViewCell *)cell withImage:(NSString *)image;

@end
