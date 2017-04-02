//
//  Config.h
//  Cake
//
//  Created by Michael Sevy on 3/5/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//
#ifndef Config_h
#define Config_h

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
const static NSUInteger ddLogLevel = DDLogLevelAll;
//#define NSLog(__FORMAT__, ...) DDLogVerbose((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

/* MACROS */
#define isRetina ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBa(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define isMiniOS(iOSVersion) ([[UIDevice currentDevice].systemVersion floatValue] >= iOSVersion)
#define isiOS7 isMiniOS(7)
#define isiOS8 isMiniOS(8)

/* AWS CONSTANTS */
static NSString * const kAWSClientId        = @"j3ja9aj00dsi9e60orniu0tfc";
static NSString * const kAWSClientSecret    = @"1suu92kllhvqgllih82th6d416tipaiahkue7vkj3evn4mueab9b";
static NSString * const kUserPoolId         = @"layers_userpoolapp_MOBILEHUB_917269795";

/* FONT CONSTANTS */
static NSString *const kDefaultFont = @"Avenir-Roman";
static NSString *const kDefaultRegularFont = @"Avenir-Heavy";
static NSString *const kDefaultBoldFont = @"Avenir-Black";
static NSString *const kDefaultBookFont = @"Avenir-Book";
static double const kLarge = 24.0;
static double const kMedium = 15.0;
static double const kSmall = 10.0;
static double const kPadding = 8.0;
static double const kTipButton = 15.0;
static double const kAddressButton = 15.0;
static double const kShippingButton = 12.0;
static const CGFloat collapsedCellHeight = 0.01f;
static const NSUInteger kQuickHUDFadeDuration = 800000;
static const NSUInteger kHUDFadeDuration = 1300000;
static double const kTenPercent = 0.10;
static double const kFifteenPercent = 0.15;
static double const kTwentyPercent = 0.20;

/* SEGUE CONSTANTS */
static NSString *const kLoginSegue = @"LoginSegue";
static NSString *const kCreateAccountSegue = @"CreateAccountSegue";
static NSString *const kForgotSegue = @"ForgotSegue";
static NSString *const kVerifySegue = @"VerifySegue";

/* STORYBOARD NAME CONSTANTS */
static NSString *const kOrderViewController = @"MyOrdersViewController";
static NSString *const kOrderCheckoutViewController = @"OrderCheckoutViewController";
static NSString *const kSettingsViewController = @"SettingsViewController";
static NSString *const kResetPasswordViewController = @"ResetPasswordViewController";
static NSString *const kDiscoverViewController = @"DiscoverViewController";

/* NOTIFICATION NAME CONSTANTS */
static NSString *const kUserLoggedInNotification = @"userLoggedInNotification";
static NSString *const kUserLoggedOutNotification = @"userLoggedOutNotification";
static NSString *const kMerchantsWillNeedUpdateAfterItemAdded = @"merchantsWillNeedUpdateAfterItemAdded";

/* DEEP LINK CONSTANTS */
static NSString *const kLinkScheme = @"mytown";
static NSString *const kLinkPath = @"invitations";
static NSString *const KUserId = @"userId";
static NSString *const KUsername = @"username";
static NSString *const KreferralCode = @"referralCode";

/* MENU ITEM BUSINESS LOGIC CONSTANTS */
static NSString *const kNoSpecialInstructions = @"None";

/* PICKUP METHOD BUSINESS LOGIC CONSTANTS */
static NSString *const kPickup = @"pickup";
static NSString *const kDelivery = @"delivery";
static NSString *const kShipping = @"shipping";
static NSString *const kShippingTypeStandard = @"standard";
static NSString *const kShippingTypeExpedited = @"expedited";
static NSString *const kShippingTypeTwoDay = @"two_day";
static NSString *const kShippingTypeOneDay = @"one_day";
static NSString *const kShippingTypeSameDay = @"same_day";
static NSString *const kShippingTypeThreeDay = @"three_day";

/* MERCHANT OPEN STATUS BUSINESS LOGIC CONSTANTS */
static NSString *const kOpen = @"open";
static NSString *const kClosingSoon = @"closing_soon";
static NSString *const kClosed = @"closed";

/* TYPE OF PAYMENT BUSINESS LOGIC CONSTANTS */
static NSString *const kCashPaymentMethod = @"cash";
static NSString *const kCreditPaymentMethod = @"braintree";

/* PAYMENT SPLIT METHOD STATE LOGIC CONSTANTS */
static NSString *const kSplitCreatorPays = @"creator";
static NSString *const kSplitSelectedPays = @"payer";
static NSString *const kSplitEven = @"even";
static NSString *const kSplitEachPaysTheirOwn = @"own";

/*PURCHASE STATUS */
static NSString *const kSent = @"sent";
static NSString *const kPending = @"pending";
static NSString *const kCanceled = @"canceled";
static NSString *const kConfirmed = @"confirmed";

/* LOCATION BUSINESS LOGIC CONSTANTS */
static const int defaultValueForDistanceRadius = 15;
static NSString *const kdefaultValueForCountry = @"US";

/* LOGIN CONSTANTS */
static NSString *const kFacebookButton = @"facebookButton";

/* VIEW CONTROLLERS FOR DEEP LINKS LANDING */
static NSString *const kDiscoverDeepLinkLanding = @"discoverViewController";
static NSString *const kMenuDeepLinkLanding = @"menuViewController";

/* TABBAR ENUM */
typedef NS_ENUM(NSUInteger, TabbarIndex) {
    TabbarIndexDiscover,
    TabbarIndexOrders,
    TabbarIndexFriends,
    TabbarIndexSettings
};

/* TABBAR INDEX CONSTANT */
static const TabbarIndex kDefaultTabbarIndex = TabbarIndexDiscover;

/* WEEKDAY ENUM */
typedef NS_ENUM(NSUInteger, WeekDay) {
    WeekDayMonday       = 0,
    WeekDayTuesday      = 1,
    WeekDayWednesday    = 2,
    WeekDayThursday     = 3,
    WeekDayFriday       = 4,
    WeekDaySaturday     = 5,
    WeekDaySunday       = 6,
    WeekDayCount		= 7
};

/* GENDER ENUM */
typedef NS_ENUM(NSUInteger, GenderType) {
    GenderTypeMale      = 1,
    GenderTypeFemale    = 2
};

/* TIME FORMAT */
static NSString *const kBasketCreationTimeFormat = @"h:mm a MM/dd";

/* PUSH NOTIFICATION TYPES */
typedef NS_ENUM(NSUInteger, PushNotificationType) {
    PushNotificationTypeUnknown = 0,
    PushNotificationTypeAlertCreatorMemberLeft,
    PushNotificationTypeALertMembersSplitEven,
    PushNotificationTypeAlertMembersBasketReady,
    PushNotificationTypeUserInvitedToBasket,
    PushNotificationTypeRemindParticipantsToPay,
    PushNotificationTypeCreatorSelectsPayer,
    PushNotificationTypeBaksetPayerApproved,
    PushNotificationTypeBaksetPayerRefused,
    PushNotificationTypeAlertPayerBasketIsReady,
    PushNotificationTypeRemindEvenSplitMember,
    PushNotificationTypeAlertCreatorPayerHasPaid,
    PushNotificationTypeAlertCreatorMemberHasPaid,
    PushNotificationTypeAlertCreatorOrderSubmitted,
    PushNotificationTypeAlertCreatorOrderConfirmed,
    PushNotificationTypeAlertCreatorOrderCanceled,
    PushNotificationTypeAlertUserAddedAsFriend,
    PushNotificationTypeAlertUserPaymentChanged,
    PushNotificationTypeSilentNotification
};

typedef NS_ENUM(NSUInteger, ViewControllerId) {
    ViewControllerIdDiscover,
    ViewControllerIdMenu,
    ViewControllerIdCheckout
};

/* COLOR VALUE ENUM */
typedef NS_ENUM(NSUInteger, ColorValue) {
    ColorValueUCLABlue          = 0x3284BF,
    ColorValueUCLAYellow        = 0xffb300,
    ColorValueDefaultTabbar     = 0x212121,
    ColorValueDefaultTabbarTint = 0xffffff,
    ColorValueDefaultBackground = 0xeeeeee,
    ColorValueDefaultNavbar     = 0xbbbbbb,
    ColorValueDefaultNavbarTint = 0xffffff,
    ColorValueDefaultNavbarText = 0xffffff,
    ColorValueDefaultFont       = 0xf1f1f1,
    ColorValueDefaultLabel      = 0xf1f1f1,
    ColorValueDefaultAction     = 0x7F0205,
    ColorValueSecondaryAction   = 0x212121,
    ColorValueAdBackground		= 0xFFFFFF,
    ColorValueAnnotationTitle   = 0x005981,
    ColorValueAnnotationGeneralText = 0x717171,
    ColorValueGraphFill         = 0xbbdfe8,
    ColorValueGraphBackground   = 0xffffff,
    ColorValueActionButtonLike  = 0xee3233,
    ColorValueActionButtonInfo  = 0x0166af,
    ColorValueActionButtonMap   = 0x41924b,
    ColorValueActionButtonAction= 0xfe8402,
    ColorValueMTDBackgroundRed  = 0x6a1d1d,
    ColorValueMTDMemberGreen    = 0x73b873,
    ColorValueMTDMemberRed      = 0x6c191c,
    ColorValueMTDFontColorRed   = 0x6a1d1d,
    ColorValueMTDBackgroundWhite= 0xffffff,
    ColorValueMTDBackgroundSearchRed = 0x3E1112,
    ColorValueMTDBackgroundDarkBlue = 0x1D242E,
    ColorValueMTDFontColorWhite = 0xffffff,
    ColorValueMTDBackgroundRowWhite = 0xffffff,
    ColorValueMTDBackgroundRowGrey  = 0xf2f2f2,
    ColorValueMTDSliderPopUpBackroundRed = 0x6a1d1d,
    ColorValueMTDOpeningStatusColorGreen = 0x79b76e,
    ColorValueMTDFontColorGrey = 0x878787,
    ColorValueMTDSecondaryRed = 0xA70201,
    ColorValueMTDFacebookButton = 0x3B5998
};

#endif /* Config_h */
