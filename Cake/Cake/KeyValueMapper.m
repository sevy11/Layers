//
//  KeyValueMapper.m
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "KeyValueMapper.h"

@implementation KeyValueMapper

- (NSArray*)keysForItems:(NSArray*)items {
    NSMutableArray *keys = [NSMutableArray array];
    for (id item in items) {
        for (id key in [self.keyValueMap allKeys]) {
            if ([self.keyValueMap[key] isEqual:item]) {
                [keys addObject:key];
            }
        }
    }
    return keys;
}

- (NSArray*)itemsForKeys:(NSArray *)keys {
    NSMutableArray *items = [NSMutableArray array];
    for (id key in keys) {
        [items addObject:self.keyValueMap[key]];
    }
    return items;
}

- (NSArray*)keysForMap {
    NSArray *keys = [self.keyValueMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    return keys;
}

- (NSArray*)valuesForMap {
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *key in self.keysForMap) {
        [values addObject:self.keyValueMap[key]];
    }
    return values;
}

@end
