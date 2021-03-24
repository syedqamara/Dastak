//
//  NSBundle+DDSENSBundle.h
//  DDSE_Example
//
//  Created by Raheel on 07/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (DDNSBundle)

+(NSBundle * _Nullable)getBundle:(Class) cls;
+(NSBundle * _Nullable)getNibBundle:(Class) cls;
+(NSBundle * _Nullable)getResourcesBundle:(Class) cls;
+(NSBundle * _Nullable)getJsonResourcesBundle:(Class) cls;
+(NSBundle * _Nullable)getLocalizedStringsResourcesBundle:(Class) cls;
+(UINib * _Nullable)loadNibFromBundle:(Class) cls nibName:(NSString *)nibName;
+(NSURL * _Nullable)getDBBundlePathURL:(Class) cls dbName:(NSString*)db;
+(NSBundle * _Nullable)getDBBundlePath:(Class) cls;
+(UIImage * _Nullable)loadImageFromResourceBundlePNG:(Class) cls imageName:(NSString *)imageName;
+(UIImage * _Nullable)loadImageFromResourceBundleJPG:(Class) cls imageName:(NSString *)imageName;
+(UIImage * _Nullable)loadImageFromResourceBundleGIF:(Class) cls imageName:(NSString *)imageName;
+ (NSString *)loadHtmlStringForClass:(Class)cls fileName:(NSString *)fileName;
+(NSString  * _Nullable )loadJsonStringWithFileName:(Class) cls fileName:(NSString *)fileName;
+(NSDictionary  * _Nullable )loadJsonDictionaryWithFileName:(Class) cls fileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
