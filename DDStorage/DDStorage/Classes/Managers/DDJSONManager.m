//
//  DDJSONManager.m
//  DDStorage
//
//  Created by Syed Qamar Abbas on 30/01/2020.
//

#import "DDJSONManager.h"
#import "NSBundle+DDNSBundle.h"
#import "DDEncryption.h"
@implementation DDJSONManager
+(NSDictionary * _Nullable)loadJSON:(NSString *)fileName forClass:(Class)cls isEncrypted:(BOOL)isEncrypted {
    NSBundle *bundle;
    if (cls == nil) {
        bundle = NSBundle.mainBundle;
    }else {
        bundle = [NSBundle getJsonResourcesBundle:cls];
    }
    NSString *className = [NSString stringWithFormat:@"%@.json",fileName];
    NSArray <NSString *> *fileNames = [NSFileManager.defaultManager contentsOfDirectoryAtPath:bundle.bundleURL.path error:NULL];
    NSData *data;
    if ([fileNames containsObject:className]) {
        NSURL *url = [bundle URLForResource:className withExtension:@"json"];
        if (url != nil) {
            data = [NSData dataWithContentsOfURL:url];
        }
    }else {
        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* fileAtPath = [filePath stringByAppendingPathComponent:className];
        data = [NSData dataWithContentsOfFile:fileAtPath];
    }
    if (isEncrypted) {
        data = [DDEncryptionManager.shared decryptStringToData:[data plainString]];
    }
    if (data != nil) {
        NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data
                                                                             options:0 error:NULL];
        return dict;
    }
    return nil;
}
+(NSString *)saveJSON:(NSDictionary *)jsonString withFileName:(NSString *)file withExtension:(NSString *)extension isEncrypted:(BOOL)isEncrypted {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error;
    NSString* fileName = [NSString stringWithFormat:@"%@.%@", file, extension];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }else {
        [NSFileManager.defaultManager removeItemAtPath:fileAtPath error:&error];
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    NSString *encryptedString;
    if (isEncrypted) {
        encryptedString = [DDEncryptionManager.shared encryptDictionaryIntoString:jsonString.mutableCopy];
    }else {
        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonString options:(NSJSONWritingPrettyPrinted) error:nil];
        encryptedString = [data stringValue];
    }

    [encryptedString writeToFile:fileAtPath atomically:YES encoding:(NSUTF8StringEncoding) error:&error];
    return fileAtPath;
}
+(BOOL)removeJSON:(NSString *)file andExtension:(NSString *)fileExt forClass:(Class)cls {
    NSString *extension = fileExt;
    if (extension.length == 0) {
        extension = @"json";
    }
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error;
    NSString* fileName = [NSString stringWithFormat:@"%@.%@", file, extension];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        return [NSFileManager.defaultManager removeItemAtPath:fileAtPath error:&error];
    }
    return NO;
}
@end
