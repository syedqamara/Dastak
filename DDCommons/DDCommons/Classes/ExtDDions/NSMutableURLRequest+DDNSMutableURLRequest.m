//
//  NSMutableRequest+DDSENSMutableRequest.m
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/29/18.
//

#import "NSMutableURLRequest+DDNSMutableURLRequest.h"
#import "NSDictionary+DDNSDictionary.h"
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif


#pragma GCC diagnostic ignored "-Wgnu"
#pragma GCC diagnostic ignored "-Wundef"
#pragma GCC diagnostic ignored "-Wselector"


@implementation NSData (RequestUtils)

- (NSString *)RequestUtils_UTF8String
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end


@implementation NSString (RequestUtils)

#pragma mark URLEncoding

- (NSString *)URLEncodedString
{
    static NSString *const unsafeChars = @"!*'\"();:@&=+$,/?%#[]% ";
    
#if !(__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9) && !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0)
    
    if (![self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)])
    {
        CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                      (__bridge CFStringRef)self,
                                                                      NULL,
                                                                      (__bridge CFStringRef)unsafeChars,
                                                                      kCFStringEncodingUTF8);
        return (__bridge_transfer NSString *)encoded;
    }
    
#endif
    
    static NSCharacterSet *allowedChars;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSCharacterSet *disallowedChars = [NSCharacterSet characterSetWithCharactersInString:unsafeChars];
        allowedChars = [disallowedChars invertedSet];
    });
    
    return (NSString *)[self stringByAddingPercentEncodingWithAllowedCharacters:allowedChars];
}

- (NSString *)URLDecodedString
{
    return [self URLDecodedString:NO];
}

- (NSString *)URLDecodedString:(BOOL)decodePlusAsSpace
{
    NSString *string = self;
    if (decodePlusAsSpace)
    {
        string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    
#if !(__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9) && !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0)
    
    if (![self respondsToSelector:@selector(stringByRemovingPercentEncoding)])
    {
        return (NSString *)[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
#endif
    
    return (NSString *)[string stringByRemovingPercentEncoding];
}

#pragma mark URL path extension

- (NSString *)stringByAppendingURLPathExtension:(NSString *)extension
{
    NSString *lastPathComponent = [self.lastURLPathComponent stringByAppendingPathExtension:extension];
    return [self.stringByDeletingLastURLPathComponent stringByAppendingURLPathComponent:lastPathComponent];
}

- (NSString *)stringByDeletingURLPathExtension
{
    NSString *lastPathComponent = [self.lastURLPathComponent stringByDeletingPathExtension];
    return [self.stringByDeletingLastURLPathComponent stringByAppendingURLPathComponent:lastPathComponent];
}

- (NSString *)URLPathExtension
{
    return self.lastURLPathComponent.pathExtension;
}

#pragma mark URL paths

- (NSString *)stringByAppendingURLPathComponent:(NSString *)str
{
    NSString *url = self;
    
    //remove fragment
    NSString *fragment = url.URLFragment;
    url = url.stringByDeletingURLFragment;
    
    //remove query
    NSString *query = url.URLQuery;
    url = url.stringByDeletingURLQuery;
    
    //strip leading slash on path
    if ([str hasPrefix:@"/"])
    {
        str = [str substringFromIndex:1];
    }
    
    //add trailing slash
    if (url.length && ![url hasSuffix:@"/"])
    {
        url = [url stringByAppendingString:@"/"];
    }
    
    //reassemble url
    url = [url stringByAppendingString:str];
    url = [url stringByAppendingURLQuery:query];
    url = [url stringByAppendingURLFragment:fragment];
    
    return url;
}

- (NSString *)stringByDeletingLastURLPathComponent
{
    NSString *url = self;
    
    //remove fragment
    NSString *fragment = url.URLFragment;
    url = url.stringByDeletingURLFragment;
    
    //remove query
    NSString *query = url.URLQuery;
    url = url.stringByDeletingURLQuery;
    
    //trim path
    NSRange range = [url rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) url = [url substringToIndex:range.location + 1];
    
    //reassemble url
    url = [url stringByAppendingURLQuery:query];
    url = [url stringByAppendingURLFragment:fragment];
    
    return url;
}

- (NSString *)lastURLPathComponent
{
    NSString *url = self;
    
    //remove fragment
    url = url.stringByDeletingURLFragment;
    
    //remove query
    url = url.stringByDeletingURLQuery;
    
    //get last path component
    NSRange range = [url rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) url = [url substringFromIndex:range.location + 1];
    
    return url;
}

#pragma mark Query strings

+ (NSString *)URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters
{
    return [self URLQueryWithParameters:parameters options:URLQueryOptionDefault];
}

+ (NSString *)DD_URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    options = options ?: URLQueryOptionUseArrays;
    
    BOOL sortKeys = !!(options & URLQueryOptionSortKeys);
    if (sortKeys)
    {
        options -= URLQueryOptionSortKeys;
    }
    
    BOOL useArraySyntax = !!(options & URLQueryOptionUseArraySyntax);
    if (useArraySyntax)
    {
        options -= URLQueryOptionUseArraySyntax;
        NSAssert(options == URLQueryOptionUseArrays || options == URLQueryOptionAlwaysUseArrays,
                 @"URLQueryOptionUseArraySyntax has no effect unless combined with URLQueryOptionUseArrays or URLQueryOptionAlwaysUseArrays option");
    }
    
    NSMutableString *result = [NSMutableString string];
    NSArray<NSString *> *keys = parameters.allKeys;
    if (sortKeys) keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys)
    {
        id value = parameters[key];
        NSString *encodedKey = key.description.URLEncodedString;
        if ([value isKindOfClass:[NSArray class]])
        {
            if (options == URLQueryOptionKeepFirstValue && [value count])
            {
                if (result.length)
                {
                    [result appendString:@"&"];
                }
                [result appendFormat:@"%@=%@", encodedKey, [[value firstObject] description].URLEncodedString];
            }
            else if (options == URLQueryOptionKeepLastValue && [value count])
            {
                if (result.length)
                {
                    [result appendString:@"&"];
                }
                [result appendFormat:@"%@=%@", encodedKey, [[value lastObject] description].URLEncodedString];
            }
            else
            {
                for (NSString *element in value)
                {
                    if (result.length)
                    {
                        [result appendString:@"&"];
                    }
                    [result appendFormat:@"%@[]=%@", encodedKey, element.description.URLEncodedString];
                }
            }
        }
        else
        {
            if (result.length)
            {
                [result appendString:@"&"];
            }
            if (useArraySyntax && options == URLQueryOptionAlwaysUseArrays)
            {
                [result appendFormat:@"%@[]=%@", encodedKey, [value description].URLEncodedString];
            }
            else
            {
                [result appendFormat:@"%@=%@", encodedKey, [value description].URLEncodedString];
            }
        }
    }
    
    return result;
}

+ (NSString *)URLQueryWithParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    options = options ?: URLQueryOptionUseArrays;
    
    BOOL sortKeys = !!(options & URLQueryOptionSortKeys);
    if (sortKeys)
    {
        options -= URLQueryOptionSortKeys;
    }
    
    BOOL useArraySyntax = !!(options & URLQueryOptionUseArraySyntax);
    if (useArraySyntax)
    {
        options -= URLQueryOptionUseArraySyntax;
        NSAssert(options == URLQueryOptionUseArrays || options == URLQueryOptionAlwaysUseArrays,
                 @"URLQueryOptionUseArraySyntax has no effect unless combined with URLQueryOptionUseArrays or URLQueryOptionAlwaysUseArrays option");
    }
    
    NSMutableString *result = [NSMutableString string];
    NSArray<NSString *> *keys = parameters.allKeys;
    if (sortKeys) keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keys)
    {
        id value = parameters[key];
        NSString *encodedKey = key.description.URLEncodedString;
        if ([value isKindOfClass:[NSArray class]])
        {
            if (options == URLQueryOptionKeepFirstValue && [value count])
            {
                if (result.length)
                {
                    [result appendString:@"&"];
                }
                [result appendFormat:@"%@=%@", encodedKey, [[value firstObject] description].URLEncodedString];
            }
            else if (options == URLQueryOptionKeepLastValue && [value count])
            {
                if (result.length)
                {
                    [result appendString:@"&"];
                }
                [result appendFormat:@"%@=%@", encodedKey, [[value lastObject] description].URLEncodedString];
            }
            else
            {
                for (NSString *element in value)
                {
                    if (result.length)
                    {
                        [result appendString:@"&"];
                    }
                    if (useArraySyntax)
                    {
                        [result appendFormat:@"%@[]=%@", encodedKey, element.description.URLEncodedString];
                    }
                    else
                    {
                        [result appendFormat:@"%@=%@", encodedKey, element.description.URLEncodedString];
                    }
                }
            }
        }
        else
        {
            if (result.length)
            {
                [result appendString:@"&"];
            }
            if (useArraySyntax && options == URLQueryOptionAlwaysUseArrays)
            {
                [result appendFormat:@"%@[]=%@", encodedKey, [value description].URLEncodedString];
            }
            else
            {
                [result appendFormat:@"%@=%@", encodedKey, [value description].URLEncodedString];
            }
        }
    }
    
    return result;
}

- (NSRange)rangeOfURLQuery
{
    NSRange queryRange = NSMakeRange(0, self.length);
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.length)
    {
        queryRange.length -= (queryRange.length - fragmentStart.location);
    }
    NSRange queryStart = [self rangeOfString:@"?"];
    if (queryStart.length)
    {
        queryRange.location = queryStart.location;
        queryRange.length -= queryRange.location;
    }
    NSString *queryString = [self substringWithRange:queryRange];
    if (queryStart.length || [queryString rangeOfString:@"="].length)
    {
        return queryRange;
    }
    return NSMakeRange(NSNotFound, 0);
}

- (NSString *)URLQuery
{
    NSRange queryRange = [self rangeOfURLQuery];
    if (queryRange.location == NSNotFound)
    {
        return nil;
    }
    NSString *queryString = [self substringWithRange:queryRange];
    if ([queryString hasPrefix:@"?"])
    {
        queryString = [queryString substringFromIndex:1];
    }
    return queryString;
}

- (NSString *)stringByDeletingURLQuery
{
    NSRange queryRange = [self rangeOfURLQuery];
    if (queryRange.location != NSNotFound)
    {
        NSString *prefix = [self substringToIndex:queryRange.location];
        NSString *suffix = [self substringFromIndex:queryRange.location + queryRange.length];
        return [prefix stringByAppendingString:suffix];
    }
    return self;
}

- (NSString *)stringByReplacingURLQueryWithQuery:(NSString *)query
{
    return [self.stringByDeletingURLQuery stringByAppendingURLQuery:query];
}

- (NSString *)stringByAppendingURLQuery:(NSString *)query
{
    //check for empty input
    query = query.URLQuery;
    if ([query length] == 0)
    {
        return self;
    }
    
    NSString *result = self;
    NSString *fragment = result.URLFragment;
    result = self.stringByDeletingURLFragment;
    NSString *existingQuery = result.URLQuery;
    if (existingQuery.length)
    {
        result = [result stringByAppendingFormat:@"&%@", query];
    }
    else
    {
        result = [result.stringByDeletingURLQuery stringByAppendingFormat:@"?%@", query];
    }
    if (fragment.length)
    {
        result = [result stringByAppendingFormat:@"#%@", fragment];
    }
    return result;
}

- (NSString *)stringByMergingURLQuery:(NSString *)query
{
    return [self stringByMergingURLQuery:query options:URLQueryOptionDefault];
}

- (NSString *)stringByMergingURLQuery:(NSString *)query options:(DDURLQueryOptions)options
{
    NSParameterAssert(options <= URLQueryOptionAlwaysUseArrays);
    options = options ?: URLQueryOptionKeepLastValue;
    
    //check for empty input
    query = query.URLQuery;
    if (query.length == 0)
    {
        return self;
    }
    
    //check for nil query string
    NSString *queryString = self.URLQuery;
    if (queryString.length == 0)
    {
        return [self stringByAppendingURLQuery:query];
    }
    
    NSMutableDictionary *parameters = (NSMutableDictionary *)[queryString URLQueryParametersWithOptions:options];
    NSDictionary *newParameters = [query URLQueryParametersWithOptions:options];
    for (NSString *key in newParameters)
    {
        id value = newParameters[key];
        id oldValue = parameters[key];
        if ([oldValue isKindOfClass:[NSArray class]])
        {
            if ([value isKindOfClass:[NSArray class]])
            {
                value = [oldValue arrayByAddingObjectsFromArray:value];
            }
            else
            {
                value = [oldValue arrayByAddingObject:value];
            }
        }
        else if (oldValue)
        {
            if ([value isKindOfClass:[NSArray class]])
            {
                value = [@[oldValue] arrayByAddingObjectsFromArray:value];
            }
            else if (options == URLQueryOptionKeepFirstValue)
            {
                value = oldValue;
            }
            else if (options == URLQueryOptionUseArrays ||
                     options == URLQueryOptionAlwaysUseArrays)
            {
                value = @[oldValue, value];
            }
        }
        else if (options == URLQueryOptionAlwaysUseArrays)
        {
            value = @[value];
        }
        parameters[key] = value;
    }
    
    return [self stringByReplacingURLQueryWithQuery:[NSString URLQueryWithParameters:parameters options:options]];
}

- (NSDictionary<NSString *, NSString *> *)URLQueryParameters
{
    return [self URLQueryParametersWithOptions:URLQueryOptionDefault];
}

- (NSDictionary<NSString *, NSString *> *)URLQueryParametersWithOptions:(DDURLQueryOptions)options
{
    NSParameterAssert(options <= URLQueryOptionAlwaysUseArrays);
    options = options ?: URLQueryOptionKeepLastValue;
    
    NSString *queryString = self.URLQuery;
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *parameters = [queryString componentsSeparatedByString:@"&"];
    for (NSString *parameter in parameters)
    {
        NSArray<NSString *> *parts = [parameter componentsSeparatedByString:@"="];
        NSString *key = [parts[0] URLDecodedString:YES];
        if (parts.count > 1)
        {
            id value = [parts[1] URLDecodedString:YES];
            BOOL arrayValue = [key hasSuffix:@"[]"];
            if (arrayValue)
            {
                key = [key substringToIndex:[key length] - 2];
            }
            id existingValue = result[key];
            if ([existingValue isKindOfClass:[NSArray class]])
            {
                value = [existingValue arrayByAddingObject:value];
            }
            else if (existingValue)
            {
                if (options == URLQueryOptionKeepFirstValue)
                {
                    value = existingValue;
                }
                else if (options != URLQueryOptionKeepLastValue)
                {
                    value = @[existingValue, value];
                }
            }
            else if ((arrayValue && options == URLQueryOptionUseArrays) || options == URLQueryOptionAlwaysUseArrays)
            {
                value = @[value];
            }
            result[key] = value;
        }
    }
    return result;
}

#pragma mark URL fragment ID

- (NSString *)URLFragment
{
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound)
    {
        return [self substringFromIndex:fragmentStart.location + 1];
    }
    return nil;
}

- (NSString *)stringByDeletingURLFragment
{
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound)
    {
        return [self substringToIndex:fragmentStart.location];
    }
    return self;
}

- (NSString *)stringByAppendingURLFragment:(NSString *)fragment
{
    if (fragment)
    {
        NSRange fragmentStart = [self rangeOfString:@"#"];
        if (fragmentStart.location != NSNotFound)
        {
            return [self stringByAppendingString:fragment];
        }
        return [self stringByAppendingFormat:@"#%@", fragment];
    }
    return self;
}

#pragma mark URL conversion

- (nullable NSURL *)URLValue
{
    if (self.absolutePath)
    {
        return [NSURL fileURLWithPath:self];
    }
    return [NSURL URLWithString:self];
}

- (nullable NSURL *)URLValueRelativeToURL:(nullable NSURL *)baseURL
{
    return [NSURL URLWithString:self relativeToURL:baseURL];
}

#pragma mark base 64

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
#if !(__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9) && !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0)
    
    if (![self respondsToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        return data.base64Encoding;
    }
    
#endif
    
    return [data base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

- (NSString *)base64DecodedString
{
    NSData *data;
    
#if !(__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9) && !(__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0)
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        data = [[NSData alloc] initWithBase64Encoding:self];
    }
    else
        
#endif
        
    {
        data = [[NSData alloc] initWithBase64EncodedString:self options:(NSDataBase64DecodingOptions)0];
    }
    
    return [data RequestUtils_UTF8String];
}

@end


@implementation NSURL (RequestUtils)

+ (NSURL *)URLWithComponents:(NSDictionary<NSString *, NSString *> *)components
{
    NSString *URL = @"";
    NSString *fragment = components[DDSEURLFragmentComponent];
    if ([fragment hasPrefix:@"#"])
    {
        fragment = [fragment substringFromIndex:1];
    }
    if (fragment)
    {
        URL = [NSString stringWithFormat:@"#%@", fragment];
    }
    NSString *query = components[DDSEURLQueryComponent];
    if (query)
    {
        if ([query isKindOfClass:[NSDictionary class]])
        {
            query = [NSString URLQueryWithParameters:(NSDictionary *)query];
        }
        if ([query hasPrefix:@"?"] || [query hasPrefix:@"&"])
        {
            query = [query substringFromIndex:1];
        }
        URL = [NSString stringWithFormat:@"?%@%@", query, URL];
    }
    NSString *parameterString = components[DDSEURLParameterStringComponent];
    if (parameterString)
    {
        URL = [NSString stringWithFormat:@";%@%@", parameterString, URL];
    }
    NSString *path = components[DDSEURLPathComponent];
    if (path)
    {
        URL = [path stringByAppendingString:URL];
    }
    NSString *port = components[DDSEURLPortComponent];
    if (port)
    {
        URL = [NSString stringWithFormat:@":%@%@", port, URL];
    }
    NSString *host = components[DDSEURLHostComponent];
    if (host)
    {
        URL = [host stringByAppendingString:URL];
    }
    NSString *user = components[DDSEURLUserComponent];
    if (user)
    {
        NSString *password = components[DDSEURLPasswordComponent];
        if (password)
        {
            user = [user stringByAppendingFormat:@":%@", password];
        }
        URL = [user stringByAppendingFormat:@"@%@", URL];
    }
    NSString *scheme = components[DDSEURLSchemeComponent];
    if (scheme)
    {
        URL = [scheme stringByAppendingFormat:@"://%@", URL];
    }
    return [NSURL URLWithString:URL];
}

- (NSDictionary<NSString *, NSString *> *)components
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *key in @[DDSEURLSchemeComponent, DDSEURLHostComponent,
                            DDSEURLPortComponent, DDSEURLUserComponent,
                            DDSEURLPasswordComponent, DDSEURLPortComponent,
                            DDSEURLPathComponent, DDSEURLParameterStringComponent,
                            DDSEURLQueryComponent, DDSEURLFragmentComponent])
    {
        id value = [self valueForKey:key];
        if (value)
        {
            result[key] = value;
        }
    }
    return result;
}

- (NSURL *)URLWithValue:(NSString *)value forComponent:(NSString *)component
{
    NSMutableDictionary *components = (NSMutableDictionary *)self.components;
    if (value)
    {
        components[component] = value;
    }
    else
    {
        [components removeObjectForKey:component];
    }
    return [NSURL URLWithComponents:components];
}

- (NSURL *)URLWithScheme:(NSString *)scheme
{
    NSString *URLString = self.absoluteString;
    URLString = [URLString substringFromIndex:self.scheme.length];
    return (NSURL *)[NSURL URLWithString:[scheme stringByAppendingString:URLString]];
}

- (NSURL *)URLWithHost:(NSString *)host
{
    return [self URLWithValue:host forComponent:DDSEURLHostComponent];
}

- (NSURL *)URLWithPort:(NSString *)port
{
    return [self URLWithValue:port forComponent:DDSEURLPortComponent];
}

- (NSURL *)URLWithUser:(NSString *)user
{
    return [self URLWithValue:user forComponent:DDSEURLUserComponent];
}

- (NSURL *)URLWithPassword:(NSString *)password
{
    return [self URLWithValue:password forComponent:DDSEURLPasswordComponent];
}

- (NSURL *)URLWithPath:(NSString *)path
{
    return [self URLWithValue:path forComponent:DDSEURLPathComponent];
}

- (NSURL *)URLWithParameterString:(NSString *)parameterString
{
    return [self URLWithValue:parameterString forComponent:DDSEURLParameterStringComponent];
}

- (NSURL *)URLWithQuery:(NSString *)query
{
    return [self URLWithValue:query forComponent:DDSEURLQueryComponent];
}

- (NSURL *)URLWithFragment:(NSString *)fragment
{
    return [self URLWithValue:fragment forComponent:DDSEURLFragmentComponent];
}

@end

@implementation NSMutableURLRequest(DDNSMutableURLRequest)


- (void)setGETParameters:(NSDictionary<NSString *, id> *)parameters
{
    [self setGETParameters:parameters options:URLQueryOptionDefault];
}

- (void)setGETParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    self.URL = [self.URL URLWithQuery:[NSString URLQueryWithParameters:parameters options:options]];
}

- (void)addGETParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    NSString *query = [NSString URLQueryWithParameters:parameters options:options];
    NSString *existingQuery = self.URL.query;
    if (existingQuery.length)
    {
        query = [existingQuery stringByMergingURLQuery:query options:options];
    }
    self.URL = [self.URL URLWithQuery:query];
}

- (void)setPOSTParameters:(NSDictionary<NSString *, id> *)parameters
{
    [self setPOSTParameters:parameters options:URLQueryOptionDefault];
}

- (void)entSetPOSTParameters:(NSDictionary<NSString *, id> *)parameters
{
    [self entSetPOSTParameters:parameters options:URLQueryOptionDefault];
}


- (void)setPOSTParameterString:(NSString *)parameterString
{
    NSData *data = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
    [self addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    [self addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self addValue:[NSString stringWithFormat:@"%tu", data.length] forHTTPHeaderField:@"Content-Length"];
    [self setHTTPBody:data];
}

- (void)setPOSTParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    NSString *content = [NSString URLQueryWithParameters:parameters options:options];
    [self setPOSTParameterString:content];
}

- (void)entSetPOSTParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    NSString *content = [NSString DD_URLQueryWithParameters:parameters options:options];
    [self setPOSTParameterString:content];
}

- (void)addPOSTParameters:(NSDictionary<NSString *, id> *)parameters options:(DDURLQueryOptions)options
{
    NSString *query = [NSString URLQueryWithParameters:parameters options:options];
    NSString *content = [[self.HTTPBody RequestUtils_UTF8String] ?: @"" stringByMergingURLQuery:query options:options];
    [self setPOSTParameterString:content];
}

- (void)setHTTPBasicAuthUser:(NSString *)user password:(nullable NSString *)password
{
    NSString *authHeader = [NSString stringWithFormat:@"%@:%@", user ?: @"", password ?: @""];
    authHeader = [NSString stringWithFormat:@"Basic %@", authHeader.base64EncodedString];
    [self addValue:authHeader forHTTPHeaderField:@"Authorization"];
}
- (void)setJWTToken:(NSString *)token
{
    [self addValue:token forHTTPHeaderField:@"Authorization"];
}

- (void)setBearerToken:(NSString *)token withPrefix:(NSString *)str withKey:(NSString *)key
{
    if (key.length == 0) {
        [self addValue:[NSString stringWithFormat:@"%@%@",str,token] forHTTPHeaderField:@"Authorization"];
    }else {
        [self addValue:[NSString stringWithFormat:@"%@%@",str,token] forHTTPHeaderField:key];
    }
}
-(void)setMultipartHeadersWithBoundary:(NSString *)boundary {
    [self setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    if (self.HTTPBody.length > 0) {
        [self setValue:[NSString stringWithFormat:@"%ld",self.HTTPBody.length] forHTTPHeaderField:@"content-length"];
    }
    [self setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [self setValue:@"en;q=1, ur-US;q=0.9" forHTTPHeaderField:@"Accept-Language"];
    [self setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [self setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [self setValue:@"The dynamicdelivery/2008 (iPhone; iOS 13.3; Scale/3.00)" forHTTPHeaderField:@"User-Agent"];
}
@end
