//
//  KeyValueMapper.h
//  Cake
//
//  Created by Michael Sevy on 3/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueMapper : NSObject

@property (nonatomic, strong) NSDictionary *keyValueMap;

- (NSArray*)keysForItems:(NSArray*)items;
- (NSArray*)itemsForKeys:(NSArray*)keys;
- (NSArray*)keysForMap;
- (NSArray*)valuesForMap;

@end
