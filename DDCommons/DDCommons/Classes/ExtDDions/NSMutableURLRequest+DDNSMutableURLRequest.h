//
//  NSMutableRequest+DDSENSMutableRequest.h
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/29/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const DDSEURLSchemeComponent = @"scheme";
static NSString *const DDSEURLHostComponent = @"host";
static NSString *const DDSEURLPortComponent = @"port";
static NSString *const DDSEURLUserComponent = @"user";
static NSString *const DDSEURLPasswordComponent = @"password";
static NSString *const DDSEURLPathComponent = @"path";
static NSString *const DDSEURLParameterStringComponent = @"parameterString";
static NSString *const DDSEURLQueryComponent = @"query";
static NSString *const DDSEURLFragmentComponent = @"fragment";




typedef NS_ENUM(NSUInteger, DDURLQueryOptions)
{
    //mutually exclusive
    URLQueryOptionDefault = 0,
    URLQueryOptionKeepLastValue,
    URLQueryOptionKeepFirstValue,
    URLQueryOptionUseArrays,
    URLQueryOptionAlwaysUseArrays,
    
    //can be |ed with other values
    URLQueryOptionUseArraySyntax = 8,
    URLQueryOptionSortKeys = 16
};


@interface NSString (RequestUtils)

#pragma mark URLEncoding

@property (nonatomic, readonly) NSString *URLEncodedString;
@property (nonatomic, readonly) NSString *URLDecodedString;

- (NSString *)URLDecodedString:(BOOL)decodePlusAsSpace;

#pragma mark URL path extension

@property (nonatomic, readonly) NSString *stringByDeletingURLPathExtension;
@property (nonatomic, readonly) NSString *URLPathExtension;

- (NSString *)stringByAppendingURLPathExtension:(NSString *)extension;

#pragma mark URL paths

@property (nonatomic, readonly) NSString *stringByDeletingLastURLPathComponent;
@property (nonatomic, readonly) NSString *lastURLPathComponent;

- (NSString *)stringByAppendingURLPathComponent:(NSString *)str;

#pragma mark URL query

+ (NSString *)URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters;
+ (NSString *)URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;
+ (NSString *)DD_URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;

@property (nonatomic, readonly) NSString *URLQuery;
@property (nonatomic, readonly) NSString *stringByDeletingURLQuery;

- (NSString *)stringByReplacingURLQueryWithQuery:(NSString *)query;
- (NSString *)stringByAppendingURLQuery:(NSString *)query;
- (NSString *)stringByMergingURLQuery:(NSString *)query;
- (NSString *)stringByMergingURLQuery:(NSString *)query options:(DDURLQueryOptions)options;
- (NSDictionary<NSString *, NSString *> *)URLQueryParameters;
- (NSDictionary<NSString *, NSString *> *)URLQueryParametersWithOptions:(DDURLQueryOptions)options;

#pragma mark URL fragment ID

@property (nonatomic, readonly) NSString *URLFragment;
@property (nonatomic, readonly) NSString *stringByDeletingURLFragment;

- (NSString *)stringByAppendingURLFragment:(NSString *)fragment;

#pragma mark URL conversion

@property (nonatomic, readonly, nullable) NSURL *URLValue;

- (nullable NSURL *)URLValueRelativeToURL:(nullable NSURL *)baseURL;

#pragma mark base 64

@property (nonatomic, readonly) NSString *base64EncodedString;
@property (nonatomic, readonly) NSString *base64DecodedString;

@end


@interface NSURL (RequestUtils)

+ (instancetype)URLWithComponents:(NSDictionary<NSString *, NSString *> *)components;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *components;

- (NSURL *)URLWithScheme:(NSString *)scheme;
- (NSURL *)URLWithHost:(NSString *)host;
- (NSURL *)URLWithPort:(NSString *)port;
- (NSURL *)URLWithUser:(NSString *)user;
- (NSURL *)URLWithPassword:(NSString *)password;
- (NSURL *)URLWithPath:(NSString *)path;
- (NSURL *)URLWithParameterString:(NSString *)parameterString;
- (NSURL *)URLWithQuery:(NSString *)query;
- (NSURL *)URLWithFragment:(NSString *)fragment;

@end


@interface NSMutableURLRequest (DDNSMutableURLRequest)

@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSString *> *GETParameters;
@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSString *> *POSTParameters;

- (void)setGETParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;
- (void)addGETParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;
- (void)setPOSTParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;
- (void)entSetPOSTParameters:(NSDictionary<NSString *, id> *)parameters;
- (void)addPOSTParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options;
- (void)setHTTPBasicAuthUser:(NSString *)user password:(nullable NSString *)password;
- (void)setJWTToken:(NSString *)token;
- (void)setBearerToken:(NSString *)token withPrefix:(NSString *)str withKey:(NSString *)key;
-(void)setMultipartHeadersWithBoundary:(NSString *)boundary;
@end

NS_ASSUME_NONNULL_END
