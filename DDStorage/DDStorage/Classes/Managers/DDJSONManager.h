//
//  DDJSONManager.h
//  DDStorage
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDJSONManager : NSObject
/** @name Load JSON and return Dictionary */

/**
 * Load JSON & return Dict. Use [dictionary decodeTo:YourModelClass] to parse this dict into your model class.
 * @param fileName File Name without extension
 * @param cls Class from the bundle which contain JSON, nil if main bundle
 * @see decodeTo: for use of auto parsing dictionary into model class.
 */
///decodeTo: for use of auto parsing dictionary into model class.
+(NSDictionary * _Nullable)loadJSON:(NSString *)fileName forClass:(Class)cls isEncrypted:(BOOL)isEncrypted;
+(NSString *)saveJSON:(NSDictionary *)jsonString withFileName:(NSString *)fileName withExtension:(NSString *)extension isEncrypted:(BOOL)isEncrypted;
+(BOOL)removeJSON:(NSString *)file andExtension:(NSString *)fileExt forClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
