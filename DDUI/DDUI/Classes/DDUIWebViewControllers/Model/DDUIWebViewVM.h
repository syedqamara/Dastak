//
//  DDUIWebViewVM.h
//  DDUI
//
//  Created by M.Jabbar on 16/01/2020.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>

#define DD_WEB_IS_OPEN_SAFARI @"is_open_safari"
#define DD_WEB_OPEN_SAFARI @"open_safari"
#define DD_WEB_OPEN_SUCCESS @"is_success"
#define DD_WEB_OPEN_PRODUCT_MERCHANTS @"open_all_merchants"
#define DD_WEB_OPEN_DEEPLINK @"deep_link"
#define DD_WEB_OPEN_LOGIN @"login"
#define DD_WEB_CLOSE_VIEW @"close_view"
#define DD_WEB_IS_ANALYTICS @"is_analytics"


typedef NS_ENUM(NSUInteger, DDTravelWebViewNavType) {
    DDTRNavWithCorporateBG,
    DDTRNavWithWhiteBG,
    DDTRNavWithTransparentBG,
};

typedef NS_ENUM(NSUInteger, DDUIWebViewType) {
    DDUIWebViewTypeGeneral,
    DDUIWebViewTypeCashlessCart,
    DDUIWebViewTypeProductCart,
    DDUIWebViewTypeBookATable,
    DDUIWebViewTypeCinema,
};

typedef NS_ENUM(NSUInteger, DDUIWebActionType) {
    DDUIWebActionTypeOpenSafari,
    DDUIWebActionTypeComplete,
    DDUIWebActionTypeProductList,
    DDUIWebActionTypeDeeplink,
    DDUIWebActionTypeLogin,
    DDUIWebActionTypeBack,
    DDUIWebActionTypeAnalytics,
    DDUIWebActionTypeForceStop,
    DDUIWebActionTypeUnknown,
};
@class DDUIWebActions;

typedef BOOL(^WebControllerURLChange)(DDUIWebActions * _Nullable action, UIViewController * _Nullable controller);
typedef void(^WebControllerClose)(UIViewController * _Nonnull controller);
typedef void(^WebControllerCompletion)(NSMutableDictionary * _Nullable params, UIViewController * _Nullable controller);

NS_ASSUME_NONNULL_BEGIN

@interface DDUIWebActions: NSObject
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSMutableDictionary <NSString *, NSString *>*parameters;
-(DDUIWebActionType)type;
-(instancetype)initWithURL:(NSString *)url;
-(BOOL)hasAction:(NSString *)key;
@end


@interface DDUIWebViewVM : NSObject
@property (assign, nonatomic) BOOL is_animated;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) NSMutableDictionary *params_decrypted;
@property (nonatomic) DDTravelWebViewNavType webNavType;
@property (nonatomic) DDUIWebViewType webType;
@property (nonatomic, copy) WebControllerCompletion webCompletion;
@property (nonatomic, copy) WebControllerURLChange urlChange;
@property (nonatomic, copy) WebControllerClose webViewCloseCompletion;
@end

NS_ASSUME_NONNULL_END
