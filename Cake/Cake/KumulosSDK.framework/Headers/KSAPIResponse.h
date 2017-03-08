//
//  KSResponse.h
//  KumulosSDK
//
//  Created by cgwyllie on 16/09/2016.
//  Copyright © 2016 kumulos. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Holds the results of an RPC API method call
 */
@interface KSAPIResponse : NSObject

/// The result data of the Kumulos API method
@property (nonatomic,readonly) id payload;
@property (nonatomic,readonly) NSNumber* requestProcessingTime;
@property (nonatomic,readonly) NSNumber* requestReceivedTime;
@property (nonatomic,readonly) NSNumber* responseCode;
@property (nonatomic,readonly) NSString* responseMessage;
@property (nonatomic,readonly) NSNumber* timestamp;
@property (nonatomic,readonly) NSNumber* maxProcessingTime;

@end
