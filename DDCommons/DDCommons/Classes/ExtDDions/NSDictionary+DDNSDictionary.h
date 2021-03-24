//
//  NSDictionary+DDSENSDictionary.h
//  DDSE_Example
//
//  Created by Raheel on 07/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DDNSDictionary)

-(NSString*) urlEncodedString;
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
-(id) bv_jsonDataWithPrettyPrint:(BOOL) prettyPrint;
+(NSDictionary<NSAttributedStringKey, id> *)getNavBarTitleColor:(UIColor *)color withFont:(UIFont *)font;
-(id)decodeTo:(Class)classObj;
- (NSData *)createBodyWithBoundary:(NSString *)boundary images:(NSDictionary *)images;
-(BOOL)boolForKey:(id)key;
-(NSMutableDictionary *)flatDict;
-(NSMutableDictionary *)changeSubstringInKeys:(NSString *)subString withNewString:(NSString *)newKey;
-(NSMutableDictionary *)mapDictionaryWithKeyChangeRules:(NSDictionary *)keyDict;

@end

@interface NSMutableDictionary (DDNSMutableDictionary)
-(NSMutableDictionary *)removeImagesAndGiveInNewDictionary;

@end
@interface NSArray (Extensions)

- (NSString*)json;

@end

@interface NSMutableArray (Extensions)

- (NSString*)json;




@end

NS_ASSUME_NONNULL_END
