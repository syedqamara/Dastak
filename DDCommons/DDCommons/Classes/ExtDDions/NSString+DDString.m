//
//  NSString+DDSEString.m
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//
#import "JSONModel.h"
#import "NSString+DDString.h"
#import <Foundation/Foundation.h>
#import "UIColor+DDColor.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSBundle+DDNSBundle.h"
#import "DDLocalizedBundleFile.h"

@implementation NSString (DDString)

-(float)getHeightwithWidth:(float)width font:(UIFont*)font{
    NSAttributedString *questionattributedText = [[NSAttributedString alloc]
                                                  initWithString:self
                                                  attributes:@{NSFontAttributeName: font}
                                                  ];
    CGRect questionRect = [questionattributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options: NSStringDrawingUsesLineFragmentOrigin context:nil];
    return questionRect.size.height;
}
-(float)getWidthwithHeight:(float)height font:(UIFont*)font{
    NSAttributedString *questionattributedText = [[NSAttributedString alloc]
                                                  initWithString:self
                                                  attributes:@{NSFontAttributeName: font}
                                                  ];
    CGRect questionRect = [questionattributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX, height} options: NSStringDrawingUsesFontLeading context:nil];
    return questionRect.size.width;
}

- (NSString*) getDayMonthYearDateStringWithSlashes {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *dob = [format dateFromString:self];
    format.dateFormat = @"dd/MM/yyyy";
    return [format stringFromDate:dob];
}

-(float)getWidt {
    UILabel *lbl = [UILabel new];
    lbl.text = self;
    [lbl sizeToFit];
    return lbl.frame.size.width;
}

-(UIColor *)colorValue {
    if (self.length > 0) {
        return [UIColor DDcolorFromHexString:self];
    }
    return UIColor.clearColor;
}
- (NSString*)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSURL *) urlValue
{
    // Create pointer to the string as UTF8
    NSURL *url = [NSURL URLWithString:self];
    if (url == nil) {
        url = [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    }
    return [NSURL URLWithString:self];
}

+(NSString *)removeTags:(NSArray <NSString *>*)tags fromString:(NSString *)string {
    NSString *finalString = string;
    for (NSString *tag in tags) {
        finalString = [finalString stringByReplacingOccurrencesOfString:tag withString:@""];
    }
    return finalString;
}

-(NSString *) removeSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(NSString *) removeQuote{
    return [self stringByReplacingOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
}

- (NSString *)urlencoding {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    if (![self containsString:@"%"]) {
        for (int i = 0; i < sourceLen; ++i) {
            const unsigned char thisChar = source[i];
            if (thisChar == ' '){
                [output appendString:@"%20"];
            } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                       (thisChar >= 'a' && thisChar <= 'z') ||
                       (thisChar >= 'A' && thisChar <= 'Z') ||
                       (thisChar >= '0' && thisChar <= '9')) {
                [output appendFormat:@"%c", thisChar];
            } else {
                [output appendFormat:@"%%%02X", thisChar];
            }
        }
        return output;
    }
    return self;
}

- (NSString *)validateURLSuffix {
    return [self hasSuffix:@"/"] ? self : [NSString stringWithFormat:@"%@/",self];
}

-(NSString *) trimmedString{
    NSString *trimmedStringTemp = [self stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedStringTemp;
    
}
-(NSDate *)dateWithFormate:(NSString *)formate {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = formate;
    return [formatter dateFromString:self];
}

-(NSNumber *) toNumber{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = kCFNumberFormatterNoStyle;
    return [f numberFromString:self];
}

-(NSNumber *) toDecimalNumber{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = kCFNumberFormatterDecimalStyle;
    f.maximumFractionDigits = 0;
    return [f numberFromString:self];
}
-(BOOL)isValidEmail {
    if (self.trimmedString.length == 0) return NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isValidPassword {
    return self.length >= 6;
}

-(BOOL)isValidNewPassword {
     return self.length >= 8;
}
-(NSMutableDictionary *)params {
    NSMutableDictionary *paramDict = [NSMutableDictionary new];
    NSString *param = [self componentsSeparatedByString:@"?"].lastObject;
    NSArray <NSString *>*paramArray = [param componentsSeparatedByString:@"&"];
    for (NSString *par in paramArray) {
        NSString *key = [par componentsSeparatedByString:@"="].firstObject;
        NSString *value = [par componentsSeparatedByString:@"="].lastObject;
        [paramDict setObject:value forKey:key];
    }
    return paramDict;
}
-(NSMutableDictionary *)paramsWithLowercaseKey {
    NSMutableDictionary *paramDict = [NSMutableDictionary new];
    NSString *param = [self componentsSeparatedByString:@"?"].lastObject;
    NSArray <NSString *>*paramArray = [param componentsSeparatedByString:@"&"];
    for (NSString *par in paramArray) {
        NSString *key = [par componentsSeparatedByString:@"="].firstObject;
        NSString *value = [par componentsSeparatedByString:@"="].lastObject;
        [paramDict setObject:value forKey:key.lowercaseString];
    }
    return paramDict;
}
-(NSDate *)timeStampDate {
    if (self.length > 0) {
        NSTimeInterval timeInterval = self.doubleValue;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return date;
    }
    return [NSDate date];
}

-(void)openUrlInBrowser
{
    NSURL *url = [NSURL URLWithString:self];
    if([UIApplication.sharedApplication canOpenURL:url])
    {
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    }
}

-(NSAttributedString *)attributedWithFont:(UIFont *)font andColor:(UIColor *)color {
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:self attributes:@{
                                                                                           NSFontAttributeName: font,
                                                                                           NSForegroundColorAttributeName: color
                                                                                           }];
    return attr;
}
-(NSAttributedString *)searchAttrWithFont:(UIFont *)font andColor:(UIColor *)color searchText:(NSString *)str searchFont:(UIFont *)searchFont andSearchColor:(UIColor *)searchColor {
    NSMutableAttributedString *attr = [[NSAttributedString alloc]initWithString:self attributes:@{
                                                                                           NSFontAttributeName: font,
                                                                                           NSForegroundColorAttributeName: color
                                                                                           }].mutableCopy;
    NSRange range = [self.lowercaseString rangeOfString:str.lowercaseString];
    NSDictionary <NSAttributedStringKey, id>*searchAttributes = @{NSForegroundColorAttributeName: searchColor, NSFontAttributeName: searchFont};
    [attr addAttributes:searchAttributes range:range];
    
    return attr;
}
-(NSAttributedString*)addAttribute:(NSAttributedStringKey)key value:(id)value{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [attributedString.mutableString rangeOfString:self options:NSCaseInsensitiveSearch];
       if (range.location != NSNotFound) {
           [attributedString addAttribute:key value:value range:range];
       }
    return attributedString;
}
+(NSString *)deviceLanguage {
    
    NSString  *langId = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDictionary *components = [NSLocale componentsFromLocaleIdentifier:langId];
    NSString *languageDesignator = components[NSLocaleLanguageCode];
    
    if([languageDesignator isEqualToString:@"el"]){
        return languageDesignator;
    } else if([languageDesignator isEqualToString:@"ar"]){
        return languageDesignator;
    } else if([languageDesignator isEqualToString:@"zh"]){
        return @"cn";
    } else {
        return @"en";
    }
}

+(BOOL)isCantoneseLanguage {
    return [NSString.deviceLanguage isEqualToString:@"zh"];
}

-(BOOL)isDeeplink {
    NSString *http = [self componentsSeparatedByString:@"://"].firstObject;
    if ([http.lowercaseString containsString:@"http"]) {
        return NO;
    }
    return YES;
}
-(NSString*)localized {
//    return self;
    NSBundle *bundle = [NSBundle getLocalizedStringsResourcesBundle:DDLocalizedBundleFile.class];
    return NSLocalizedStringFromTableInBundle(self, @"DDLocalizable", bundle, self);
}
-(NSString *)noRequireRefreshGlobally {
    if ([self componentsSeparatedByString:@"?"].count > 1) {
        return [NSString stringWithFormat:@"%@&ref_app=false",self];
    }
    return [NSString stringWithFormat:@"%@?ref_app=false",self];
}
-(NSString *)requireRefreshGlobally {
    if ([self componentsSeparatedByString:@"?"].lastObject.length > 0) {
        return [NSString stringWithFormat:@"%@&ref_app=true",self];
    }
    return [NSString stringWithFormat:@"%@?ref_app=true",self];
}
-(NSString *)removeString:(NSString *)str {
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}
+(NSString *)appVersion {
    return [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}
+(NSString *)advertisingIdentifier {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}
-(BOOL)applyRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject: self];
}

-(NSString*)stringWithDot {
    return [NSString stringWithFormat:@"%@%@",self,[self dotString]];
}

-(NSString *) dotString {
//    return @" . ";
    return @" • ";
}
-(NSString *)snakeToUpperCammel {
    NSMutableArray *arr = [self componentsSeparatedByString:@"_"].mutableCopy;
    NSMutableArray *finalArr = [NSMutableArray new];
    for (NSString *str in arr) {
        NSString *firstLetter = [str substringToIndex:1].uppercaseString;
        NSString *remainingLetters = [str substringFromIndex:1].lowercaseString;
        [finalArr addObject:[NSString stringWithFormat:@"%@%@",firstLetter, remainingLetters]];
    }
    return [finalArr componentsJoinedByString:@" "];
}
-(void)makeCall {
    NSString *phoneURLString = [[NSString stringWithFormat:@"telprompt:%@", self] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]){
        [[UIApplication sharedApplication] openURL:phoneURL options:@{} completionHandler:nil];
    }
}
- (NSString *)mimeType {
    // get a mime type for an extension using MobileCoreServices.framework

    CFStringRef extension = (__bridge CFStringRef)self;
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);

    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);

    CFRelease(UTI);

    return mimetype;
}

-(NSString *)getURLSubString {
    NSString *messageString = self;
    NSRange r1 = [messageString rangeOfString:@"<a>"];
    NSRange r2 = [messageString rangeOfString:@"</a>"];
    NSRange rangeSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
    if ([messageString containsString:@"<a>"] && [messageString containsString:@"</a>"]) {
        return [messageString substringWithRange:rangeSub];
    }else{
        return @"";
    }
    
}

- (NSURL *) getUrl
{
    return [NSURL URLWithString:self];
}
-(NSString *)add:(NSString *)str {
    return [NSString stringWithFormat:@"%@%@",self,str];
}
-(NSString *)insert:(NSDictionary *)dictionary {
    return [self insert:dictionary excludeKeysHavingString:@[]];
}
-(NSString *)insert:(NSDictionary *)dictionary excludeKeysHavingString:(NSArray <NSString *>*)excludedKeys {
    NSString *finalString = self;
    for (NSString *key in dictionary) {
        if (excludedKeys.count > 0 && [self haveInArray:excludedKeys key:key]) {
            continue;
        }
        id value = dictionary[key];
        if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) {
            if ([finalString containsString:@"?"]) {
                finalString = [NSString stringWithFormat:@"%@&%@=%@",finalString,key,value];
            }else {
                finalString = [NSString stringWithFormat:@"%@?%@=%@",finalString,key,value];
            }
        }
    }
    return finalString;
}
-(BOOL)haveInArray:(NSArray <NSString *>*)array key:(NSString *)key {
    for (NSString *keyExclude in array) {
        if ([key containsString:keyExclude]) {
            return YES;
        }
    }
    return NO;
}
-(UIImage *)pngImage:(Class)cls {
    return [NSBundle loadImageFromResourceBundlePNG:cls imageName:self];
}
-(BOOL)contains:(NSString *)str {
    return [self containsString:str];
}
-(NSAttributedString *)tagBasedAttributesWithTagFont:(UIFont*)boldFont andTagColor:(UIColor *)boldColor andNormalFont:(UIFont *)normalFont andNormalColor:(UIColor *)normalColor {
    NSArray *slices = [self componentsSeparatedByString:@"<b>"];
    if (slices.count == 1) {
        slices = [self componentsSeparatedByString:@"<B>"];
    }
    NSMutableArray *boldSlices = [NSMutableArray new];
    for (NSString *this in slices) {
        if ([this contains:@"</b>"]) {
            NSString *temp = [this componentsSeparatedByString:@"</b>"].firstObject.trimmedString;
            if (temp.length)
                [boldSlices addObject:temp];
        }
        if ([this contains:@"</B>"]) {
            NSString *temp = [this componentsSeparatedByString:@"</B>"].firstObject.trimmedString;
            if (temp.length)
                [boldSlices addObject:temp];
        }
    }
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *normalText = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:normalText attributes:@{NSFontAttributeName: normalFont, NSForegroundColorAttributeName: normalColor}];
    
    for (NSString *this in boldSlices) {
        [str addAttribute:NSFontAttributeName value:boldFont range:[normalText rangeOfString:this]];
        [str addAttribute:NSForegroundColorAttributeName value:boldColor range:[normalText rangeOfString:this]];
    }
    
    return str;
}

-(id)decodeTo:(Class)cls {
    return [[cls alloc] initWithString:self error:nil];
}
-(BOOL)isNonCaseEqual:(NSString *)str {
    return [self.lowercaseString isEqualToString:str.lowercaseString];
}
-(BOOL)isNonCaseContains:(NSString *)str {
    return [self.lowercaseString contains:str.lowercaseString];
}
@end
