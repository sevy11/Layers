//
//  Kumulos.m
//  Kumulos
//
//  Created by Kumulos Bindings Compiler on Mar  6, 2017
//

#import <objc/runtime.h>
#import "Kumulos.h"

@interface KumulosDelegateHolder : NSObject

@property (weak,nonatomic) id <KumulosDelegate> delegate;

@end

@implementation KumulosDelegateHolder

+ (instancetype) createWithDelegate:(id <KumulosDelegate>)delegate {
    KumulosDelegateHolder* holder = [[KumulosDelegateHolder alloc] init];
    holder.delegate = delegate;
    return holder;
}

@end

@implementation Kumulos (Bindings)

- (instancetype) init {
    if (self = [self initWithAPIKey:@"ed302643-c5b3-4e00-b0c0-b5f0a65bd5b8" andSecretKey:@"tTogaY2ja91XGILNIUBizRixfCYMaQ2dYz6W"]) {

    }

    return self;
}

- (void) setDelegate:(id<KumulosDelegate>)delegate {
    KumulosDelegateHolder* holder = [KumulosDelegateHolder createWithDelegate:delegate];
    objc_setAssociatedObject(self, @selector(delegate), holder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <KumulosDelegate>) delegate {
    KumulosDelegateHolder* holder = objc_getAssociatedObject(self, @selector(delegate));

    if (nil == holder) {
        return nil;
    }

    return holder.delegate;
}

- (void) invokeDelegateSelector:(SEL)selector withArg:(id)arg andOperation:(KSAPIOperation*)operation {
    id <KumulosDelegate> delegate = self.delegate;

    if (!delegate || ![delegate respondsToSelector:selector]) {
        return;
    }

    NSMethodSignature* signature = [[delegate class] instanceMethodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:delegate];
    [invocation setSelector:selector];

    Kumulos* k = self;
    [invocation setArgument:&k atIndex:2];
    [invocation setArgument:&operation atIndex:3];
    [invocation setArgument:&arg atIndex:4];

    [invocation invoke];
}


- (KSAPIOperation*) createUserWithEmail:(NSString*)email andPassword:(NSString*)password andDeleted_on:(NSDate*)deleted_on andUsername:(NSString*)username andFirst_name:(NSString*)first_name andLast_name:(NSString*)last_name {
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithCapacity:6];
    params[@"email"] = email;
    params[@"password"] = password;
    params[@"deleted_on"] = deleted_on;
    params[@"username"] = username;
    params[@"first_name"] = first_name;
    params[@"last_name"] = last_name;

    SEL selector = @selector(kumulosAPI: apiOperation: createUserDidCompleteWithResult:);

    KSAPIOperation* op = [self callMethod:@"createUser" withParams:params success:^(KSAPIResponse* response, KSAPIOperation* operation) {
        [self invokeDelegateSelector:selector withArg:response.payload andOperation:operation];
    } andFailure:^(NSError* error, KSAPIOperation* operation) {
        SEL selector = @selector(kumulosAPI:apiOperation:didFailWithError:);
        [self invokeDelegateSelector:selector withArg:[error description] andOperation:operation];
    }];

    return op;
}

@end