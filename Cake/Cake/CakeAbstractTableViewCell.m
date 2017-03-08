//
//  CakeAbstractTableViewCell.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "CakeAbstractTableViewCell.h"

@implementation CakeAbstractTableViewCell

+ (NSString*)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)changeAccessoryType:(CakeAbstractTableViewCell *)cell withImage:(NSString *)image{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 30, 30);
    [addButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    cell.accessoryView = addButton;
}


#pragma mark - Helpers
+ (CGFloat)estimatedHeight {
    return 50.0f;
}

+ (CGFloat)height {
    return 50.0f;
}

@end
