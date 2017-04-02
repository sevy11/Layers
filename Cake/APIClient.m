//
//  APIClient.m
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

#import "APIClient.h"
#import "RKCLLocationValueTransformer.h"
#import "ISO8601DateFormatterValueTransformer.h"
#import "BPXLUUIDHandler.h"
#import "RKPathMatcher.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "ExtendedError.h"
#import "ConfigManager.h"

// Endpoints

//////////////////////////////////
// Shared Instance
static APIClient  *_sharedClient = nil;
static void (^_defaultFailureBlock)(RKObjectRequestOperation *operation, NSError *error) = nil;
//static APIMode _apiMode = APIModeLive;

typedef NS_ENUM(NSUInteger, PageSize) {
    PageSizeDefault  = 20,
    PageSizeSmall    = 10,
    PageSizeMedium   = 300,
    PageSizeLarge    = 1000
};

@interface APIClient ()

@property (strong, nonatomic) RKPaginator *friendsPaginator;
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSMutableArray *friendCompletionBlocks;
@property (strong, nonatomic) RKPaginator *contactsPaginator;
@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) NSMutableArray *contactCompletionBlocks;
@property (strong, nonatomic) RKPaginator *organizationPaginator;
@property (strong, nonatomic) NSMutableArray *organizations;
@property (strong, nonatomic) NSMutableArray *organizationCompletionBlocks;
@property (strong, nonatomic, readonly) NSError *noNetworkError;

@end

@implementation APIClient

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize stuff here
        [self initRestKit];
        [AFRKNetworkActivityIndicatorManager sharedManager].enabled = YES;

        // Add an ISO8601DateFormatter to the transformation stack to overwrite compatibility one
        // TODO: check why no effect...
        RKISO8601DateFormatter *dateFormatter = [RKISO8601DateFormatter defaultISO8601DateFormatter];
        dateFormatter.timeZone = [NSTimeZone localTimeZone];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [RKObjectMapping setPreferredDateFormatter:dateFormatter];
#pragma clang diagnostic pop
        _defaultFailureBlock = ^(RKObjectRequestOperation *operation, NSError *error) {
            // Transport error or server error handled by errorDescriptor
            //LayerAlertViewController *alertController = [[LayerAlertViewController alloc]initWithAlertTitle:NSLocalizedString(@"Alert.Error.Title", @"get string for error title") message:NSLocalizedString(@"Alert.Error.Body", @"get string for message body")];
            //[self presentViewController:alertController animated:YES completion:nil];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Title.Error", @"Alert Error title") message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"Alert.OK", @"Alert OK button title") otherButtonTitles:nil] show];
        };
    }

    return self;
}

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] init];
        _sharedClient.friends = [NSMutableArray array];
        _sharedClient.friendCompletionBlocks = [NSMutableArray array];
        _sharedClient.contacts = [NSMutableArray array];
        _sharedClient.contactCompletionBlocks = [NSMutableArray array];
        _sharedClient.organizations = [NSMutableArray array];
        _sharedClient.organizationCompletionBlocks = [NSMutableArray array];
    });
    return _sharedClient;
}


#pragma mark - API Endpoints
//+ (void)createUser:(User *)user success:(void (^)(User *user))success failure:(void (^)(NSError *error))failure {
//    [[RKObjectManager sharedManager] postObject:user path:kKumulosCreateUserEndpoint parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        User *user = mappingResult.firstObject;
//        if (success) {
//            success(user);
//        }
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@", error.localizedDescription);
//    }];
//}

- (BOOL)isNetworkReachable {
    if ([[RKObjectManager sharedManager] HTTPClient].networkReachabilityStatus == AFRKNetworkReachabilityStatusNotReachable
        || [[RKObjectManager sharedManager] HTTPClient].networkReachabilityStatus == AFRKNetworkReachabilityStatusUnknown) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark RestKit initialization
- (void)initRestKit {
#ifdef DEBUG
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    // RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
#endif

    // Initialize RestKit
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:[[ConfigManager sharedManager] apiUrl]]];
   // RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kKumulosBase]];
    //objectManager.requestSerializationMIMEType = RKMIMETypeJSON;

    // Initialize managed object model from bundle
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Cake" withExtension:@"momd"];

//    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    //objectManager.managedObjectStore = managedObjectStore;
    //[objectManager.HTTPClient setAuthorizationHeaderWithUsername:kKumulosKey password:nil];

    // Complete Core Data stack initialization
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"WardrobeDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:options error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);

    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];

    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    NSIndexSet *error400StatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError); // Anything in 4xx
    NSIndexSet *error500StatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassServerError); // Anything in 5xx

    /* ********************************************* */
    /* ********* MAPPINGS ************************** */
    /* ERROR */
    //RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[ExtendedError class]];
    //The entire value at the source key path containing the errors maps to the message
    //[errorMapping addAttributeMappingsFromDictionary:[ExtendedError fieldMappings]];

    //Any response in the 4xx status code range with an "errors" key path uses
    //RKResponseDescriptor *error400Descriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:error400StatusCodes];
    //    RKResponseDescriptor *error500Descriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:error500StatusCodes];

    /* EMPTY */
    //RKObjectMapping *emptyResponseMapping = [RKObjectMapping mappingForClass:[NSDictionary class]];

    /* USER */
  //  RKEntityMapping *userResponseMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:objectManager.managedObjectStore];
//
//    [userResponseMapping addAttributeMappingsFromDictionary:[User fieldMappings]];
//    RKEntityMapping *userUpdateResponseMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:objectManager.managedObjectStore];
    //[userUpdateResponseMapping addAttributeMappingsFromDictionary:[User fieldMappingsForUpdatingUser]];

    /* ADDRESS */
    //    RKEntityMapping *addressMapping = [RKEntityMapping mappingForEntityForName:@"Address" inManagedObjectStore:manager.managedObjectStore];
    //    addressMapping.assignsDefaultValueForMissingAttributes = NO;
    //    [addressMapping addAttributeMappingsFromDictionary:[Address fieldMappings]];

    /* ********************************************* */
    /* ********* RESPONSE DESCRIPTORS ************** */
    /* SIGNUP */
    //    RKResponseDescriptor *signupResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kSignupEndpoint keyPath:nil statusCodes:successStatusCodes];
    //
    //    /* LOGIN */
    //    RKResponseDescriptor *loginResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kLoginEndpoint keyPath:nil statusCodes:successStatusCodes];

    /* USERS */
    //RKResponseDescriptor *getUserResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodGET pathPattern:kGetUserEndpoint keyPath:nil statusCodes:successStatusCodes];
    //RKResponseDescriptor *createUserResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPATCH pathPattern:kCreateUserEndpoint keyPath:nil statusCodes:successStatusCodes];
    //RKResponseDescriptor *createUserResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kKumulosCreateUserEndpoint keyPath:nil statusCodes:successStatusCodes];
    // RKResponseDescriptor *updateEmailAddressDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userResponseMapping method:RKRequestMethodPOST pathPattern:kChangeEmail keyPath:nil statusCodes:successStatusCodes];

    /* ********************************************* */
    /* ********** REQUEST DESCRIPTORS ************** */
    /* SIGNUP */
    //RKObjectMapping *createUserRequestMapping = [userResponseMapping inverseMapping];
    //[createUserRequestMapping removePropertyMapping:((RKPropertyMapping *) [createUserRequestMapping mappingForSourceKeyPath:@"imageUrl"])];
    //RKRequestDescriptor *signUpRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:signUpRequestMapping objectClass:[User class] rootKeyPath:nil method:RKRequestMethodAny];
    //    signUpRequestMapping.assignsDefaultValueForMissingAttributes = NO;
    //createUserRequestMapping.assignsDefaultValueForMissingAttributes = NO;

    /* USER */
//    RKObjectMapping *createUserResponseMapping = [userUpdateResponseMapping inverseMapping];
  //  createUserResponseMapping.assignsDefaultValueForMissingAttributes = NO;
    //RKRequestDescriptor *createUserRequestDesciptor = [RKRequestDescriptor requestDescriptorWithMapping:createUserRequestMapping objectClass:[User class] rootKeyPath:nil method:RKRequestMethodPOST];

    // Add our descriptors to the manager
//    [objectManager addRequestDescriptorsFromArray:@[
  //                                                  createUserRequestDesciptor

   //                                                 ]];
    //[objectManager addResponseDescriptorsFromArray:@[
      //                                               createUserResponseDescriptor
                                                     //error400Descriptor, error500Descriptor
     //                                                ]];

    // Pagination mapping
    //    RKObjectMapping *paginationMapping = [RKObjectMapping mappingForClass:[RKPaginator class]];
    //    [paginationMapping addAttributeMappingsFromDictionary:@{
    //                                                            @"page_size": @"perPage",
    //                                                            @"total_pages": @"pageCount",
    //                                                            @"count": @"objectCount",
    //                                                            }];
    //    [manager setPaginationMapping:paginationMapping];
    //
    //    [self coreDataCleanupForManager:manager];
    
}


@end
