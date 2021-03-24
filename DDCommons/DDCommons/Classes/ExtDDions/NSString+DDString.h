//
//  NSString+DDSEString.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (DDString)

-(NSAttributedString*)addAttribute:(NSAttributedStringKey)key value:(id)value;
-(NSURL *) urlValue;
-(BOOL)isValidEmail;
-(NSString*)MD5;
-(NSString *)removeSpace;
-(NSString *)removeQuote;
-(NSString *)urlencoding;
-(NSString *)validateURLSuffix;
-(NSString *) trimmedString;
-(UIColor *)colorValue;
-(float)getHeightwithWidth:(float)width font:(UIFont*)font;
-(float)getWidthwithHeight:(float)height font:(UIFont*)font;
-(float)getWidt;
+(NSString *)removeTags:(NSArray <NSString *>*)tags fromString:(NSString *)string;
-(NSDate *) dateWithFormate:(NSString *)formate;
-(NSNumber *) toNumber;
-(NSNumber *) toDecimalNumber;
-(NSMutableDictionary *)params;
-(NSDate *)timeStampDate;
-(void)openUrlInBrowser;
-(NSAttributedString *)attributedWithFont:(UIFont *)font andColor:(UIColor *)color;
-(BOOL)isValidPassword;
-(BOOL)isValidNewPassword;
-(BOOL)isDeeplink;
-(NSString*)localized;
-(NSMutableDictionary *)paramsWithLowercaseKey;
-(NSString *)noRequireRefreshGlobally;
-(NSString *)requireRefreshGlobally;
-(NSString *)removeString:(NSString *)str;
+(NSString *)appVersion;
+(NSString *)advertisingIdentifier;
+(NSString *)deviceLanguage;
-(BOOL)applyRegex:(NSString *)regex;
-(NSString*)stringWithDot;
-(NSString *) dotString;
-(NSString *) snakeToUpperCammel;
-(void)makeCall;
- (NSString *)mimeType;
-(NSString *)getURLSubString;
- (NSURL *) getUrl;
- (NSString*) getDayMonthYearDateStringWithSlashes;
-(NSString *)add:(NSString *)str;
-(NSString *)insert:(NSDictionary *)dictionary;
-(NSString *)insert:(NSDictionary *)dictionary excludeKeysHavingString:(NSArray <NSString *>*)excludedKeys;
-(UIImage *)pngImage:(Class)cls;
+(BOOL)isCantoneseLanguage;
-(NSAttributedString *)searchAttrWithFont:(UIFont *)font andColor:(UIColor *)color searchText:(NSString *)str searchFont:(UIFont *)searchFont andSearchColor:(UIColor *)searchColor;
-(NSAttributedString *)tagBasedAttributesWithTagFont:(UIFont*)boldFont andTagColor:(UIColor *)boldColor andNormalFont:(UIFont *)normalFont andNormalColor:(UIColor *)normalColor;
-(id)decodeTo:(Class)cls;
-(BOOL)isNonCaseEqual:(NSString *)str;
-(BOOL)isNonCaseContains:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
