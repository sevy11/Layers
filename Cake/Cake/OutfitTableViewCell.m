//
//  OutfitTableViewCell.m
//  Cake
//
//  Created by Michael Sevy on 3/22/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "OutfitTableViewCell.h"

@interface OutfitTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *outfitNameLabel;

@end

@implementation OutfitTableViewCell


#pragma mark - Lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    for (UIView *subView in self.swipeContentView.subviews) {
        if (subView.tag == 15) {
            [subView removeFromSuperview];
        }
    }
}


#pragma mark - Setters
- (void)setCell {
    self.outfitNameLabel.text = @"asdfasdf";
}


#pragma mark - Class methods
+ (CGFloat)height {
    return 100;
}

@end
