//
//  Kumulos.h
//  Kumulos
//
//  Created by Kumulos Bindings Compiler on Mar  6, 2017
//

#import <Foundation/Foundation.h>
@import KumulosSDK;

typedef Kumulos kumulosProxy;

@protocol KumulosDelegate <NSObject>
@optional

- (void) kumulosAPI:(kumulosProxy*)kumulos apiOperation:(KSAPIOperation*)operation didFailWithError:(NSString*)theError;

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation createUserDidCompleteWithResult:(NSArray*)theResults;

@end

@interface Kumulos (Bindings)

@property (nonatomic,weak) id <KumulosDelegate> delegate;

- (instancetype) init;

- (KSAPIOperation*) createUserWithEmail:(NSString*)email andPassword:(NSString*)password andDeleted_on:(NSDate*)deleted_on andUsername:(NSString*)username andFirst_name:(NSString*)first_name andLast_name:(NSString*)last_name;

@end