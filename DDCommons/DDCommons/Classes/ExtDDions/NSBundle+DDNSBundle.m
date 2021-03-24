//
//  NSBundle+DDSENSBundle.m
//  DDSE_Example
//
//  Created by Raheel on 07/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import "NSBundle+DDNSBundle.h"

@implementation NSBundle (DDNSBundle)


+(NSBundle *) getBundle:(Class) cls {
    NSBundle *bundle = [NSBundle bundleForClass:cls];
    return bundle;
}
+(NSBundle *) getNibBundle:(Class) cls {
    return [NSBundle loadBundleFor:cls suffix:@"Nibs" extension:@"bundle"];
}
+(NSBundle *)getResourcesBundle:(Class) cls
{
    return [NSBundle loadBundleFor:cls suffix:@"Images" extension:@"bundle"];
}
+(NSBundle *)getJsonResourcesBundle:(Class) cls
{
    return [NSBundle loadBundleFor:cls suffix:@"Jsons" extension:@"bundle"];
}
+(NSBundle * _Nullable)getLocalizedStringsResourcesBundle:(Class) cls {
    return [NSBundle loadBundleFor:cls suffix:@"DDLocalizedStrings" extension:@"bundle"];
}
+(NSBundle *)getHtmlsResourcesBundle:(Class) cls
{
    return [NSBundle loadBundleFor:cls suffix:@"Htmls" extension:@"bundle"];
}
+(NSBundle *) getDBBundlePath:(Class) cls
{
    return [NSBundle loadBundleFor:cls suffix:@"Database" extension:@"bundle"];
}
+(NSURL *) getDBBundlePathURL:(Class) cls dbName:(NSString*)db {
    return [[self getDBBundlePath:cls] URLForResource:db withExtension:@"momd"];
}
+(UINib *) loadNibFromBundle:(Class) cls nibName:(NSString *) nibName {
    NSBundle *bundle = [NSBundle getNibBundle:cls];
    if (bundle) {
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        return nib;
    }
    return nil;
}
+ (UIImage *)loadImageFromResourceBundlePNG:(Class)cls imageName:(NSString *)imageName{
    NSBundle *bundle;
    if (cls == nil) {
        bundle = NSBundle.mainBundle;
    }
    bundle = [self getResourcesBundle:cls];
    NSString *imageFileNameWithExtension = [NSString stringWithFormat:@"%@.png",imageName];
    NSString *imageFileName = imageName;
    UIImage *image = [UIImage imageNamed:imageFileNameWithExtension inBundle:bundle compatibleWithTraitCollection:nil];
    if (image == nil) {
        image = [UIImage imageNamed:imageFileName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    return image;
}

+ (UIImage *)loadImageFromResourceBundleJPG:(Class)cls imageName:(NSString *)imageName
{
    NSBundle *bundle;
    if (cls == nil) {
        bundle = NSBundle.mainBundle;
    }
    bundle = [self getResourcesBundle:cls];
    NSString *imageFileNameWithExtension = [NSString stringWithFormat:@"%@.jpg",imageName];
    NSString *imageFileName = imageName;
    UIImage *image = [UIImage imageNamed:imageFileNameWithExtension inBundle:bundle compatibleWithTraitCollection:nil];
    if (image == nil) {
        image = [UIImage imageNamed:imageFileName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    return image;
}
+ (UIImage *)loadImageFromResourceBundleGIF:(Class)cls imageName:(NSString *)imageName
{
    NSBundle *bundle;
    if (cls == nil) {
        bundle = NSBundle.mainBundle;
    }
    bundle = [self getResourcesBundle:cls];
       NSString *imageFileNameWithExtension = [NSString stringWithFormat:@"%@.gif",imageName];
       NSString *imageFileName = imageName;
       UIImage *image = [UIImage imageNamed:imageFileNameWithExtension inBundle:bundle compatibleWithTraitCollection:nil];
       if (image == nil) {
           image = [UIImage imageNamed:imageFileName inBundle:bundle compatibleWithTraitCollection:nil];
       }
       return image;
}
+ (NSString *)loadHtmlStringForClass:(Class)cls fileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle getHtmlsResourcesBundle:cls] URLForResource:fileName withExtension:@"html"];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *jsonString = [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)];
        return jsonString;
    }
    return nil;
}
+ (NSString *)loadJsonStringWithFileName:(Class)cls fileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle getJsonResourcesBundle:cls] URLForResource:fileName withExtension:@"json"];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *jsonString = [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)];
        return jsonString;
    }
    return nil;
}
+ (NSDictionary *)loadJsonDictionaryWithFileName:(Class)cls fileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle getJsonResourcesBundle:cls] URLForResource:fileName withExtension:@"json"];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data != nil) {
            NSError *error;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:&error];
            return dictionary;
        }
    }
    return nil;
}
+(NSString* _Nullable)moduleNameForClass:(Class)cls
{
    NSString *completeClassName = NSStringFromClass(cls);
    NSString *moduleName = [completeClassName componentsSeparatedByString:@"."].firstObject;
    if (moduleName.length > 0) {
        return moduleName;
    }
    return nil;
}
+(NSBundle * _Nullable)loadBundleFor:(Class) cls suffix:(NSString* _Nullable)suffix extension:(NSString*)extension
{
    NSMutableString *nibBundleName = [NSMutableString stringWithFormat:@"%@",@""];
    if (suffix) {
       [nibBundleName appendString:suffix];
    }
    
    NSBundle *bundleForClass = [NSBundle bundleForClass:cls];
//    if ([bundleForClass.bundleURL.absoluteString isEqualToString:NSBundle.mainBundle.bundleURL.absoluteString]) {
//        return bundleForClass;
//    }
    NSURL *url = [bundleForClass URLForResource:nibBundleName withExtension:extension];
    if (url != nil) {
        NSBundle *bundle = [NSBundle bundleWithURL:url];
        NSError *error;
        [bundle loadAndReturnError:&error];
        return bundle;
    }
    return nil;
}
//+(NSBundle * _Nullable)loadBundleFor:(Class) cls suffix:(NSString* _Nullable)suffix extension:(NSString*)extension
//{
//    NSMutableString *nibBundleName = [NSMutableString stringWithFormat:@"%@",@""];
//    if (suffix) {
//       [nibBundleName appendString:suffix];
//    }
//    NSBundle *bundleForClass = [NSBundle bundleForClass:cls];
//    NSURL *url = [bundleForClass URLForResource:nibBundleName withExtension:extension];
//    if (url != nil) {
//        NSBundle *bundle = [NSBundle bundleWithURL:url];
//        if ([suffix.lowercaseString isEqualToString:@"nibs"]) {
//            NSURL *fileURL = [bundle URLForResource:NSStringFromClass(cls) withExtension:@"nib"];
//            if (fileURL != nil) {
//                return bundle;
//            }
//            return NSBundle.mainBundle;
//        }
//        return bundle;
//    }
//    return nil;
//}
@end
