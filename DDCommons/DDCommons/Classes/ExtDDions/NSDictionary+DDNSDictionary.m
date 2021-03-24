//
//  NSDictionary+DDSENSDictionary.m
//  DDSE_Example
//
//  Created by Raheel on 07/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import "NSDictionary+DDNSDictionary.h"
#import <JSONModel/JSONModel.h>
#import "NSString+DDString.h"
#import "NSDate+DDDate.h"
static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}


@implementation NSDictionary (DDNSDictionary)

-(NSMutableDictionary *)mapDictionaryWithKeyChangeRules:(NSDictionary *)keyDict {
    NSMutableDictionary *newDict = [NSMutableDictionary new];
    NSArray *allKeys = self.allKeys;
    for (NSString *key in allKeys) {
        NSString *finalKey = key;
        id finalValue = self[key];
        if ([keyDict.allKeys containsObject:key]) {
            NSString *newKey = keyDict[key];
            finalKey = newKey;
        }
        [newDict setObject:finalValue forKey:finalKey];
    }
    return newDict;
}


-(NSMutableDictionary *)changeSubstringInKeys:(NSString *)subString withNewString:(NSString *)newKey {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *key in self.allKeys) {
        NSString *finalKey = [key stringByReplacingOccurrencesOfString:subString withString:newKey];
        [dict setValue:self[key] forKey:finalKey];
    }
    return dict;
}
-(NSMutableDictionary *)flatDict {
    return [self flatDictionaryWithPrefix:@""];
}
-(NSMutableDictionary *)flatDictionaryWithPrefix:(NSString *)prefix {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSString *key in self.allKeys) {
        if ([self[key] isKindOfClass:NSDictionary.class]) {
            NSDictionary *newDict = self[key];
            [dict addEntriesFromDictionary:[newDict flatDictionaryWithPrefix:[key add:@"_"]]];
        }else {
            [dict setValue:self[key] forKey:[NSString stringWithFormat:@"%@%@",prefix,key]];
        }
    }
    return dict;
}
-(BOOL)boolForKey:(id)key {
    if ([self.allKeys containsObject:key]) {
        id value = self[key];
        if ([value isKindOfClass:NSString.class]) {
            NSString *v = value;
            return v.boolValue;
        }
        if ([value isKindOfClass:NSNumber.class]) {
            NSNumber *v = value;
            return v.boolValue;
        }
    }
    return NO;
}
-(id)decodeTo:(Class)classObj {
    NSError *error;
    NSObject *obj = [[classObj alloc]initWithDictionary:self error:&error];
    return obj;
}

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
-(id) bv_jsonDataWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (!jsonData) {
        return error.localizedDescription;
    } else {
        return jsonData;
    }
}

+(NSDictionary<NSAttributedStringKey, id> *)getNavBarTitleColor:(UIColor *)color withFont:(UIFont *)font
{
    return @{NSForegroundColorAttributeName: color, NSFontAttributeName: font};
}

- (NSData *)createBodyWithBoundary:(NSString *)boundary
                             images:(NSDictionary *)images {
    NSMutableData *httpBody = [NSMutableData data];

    // add params (all params are strings)

    [self enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    // add image data
    NSString *imageExtension = @"png";
    for (NSString *key in images) {
        NSString *filename  = key;
        UIImage *img = images[key];
        NSData   *data      = UIImagePNGRepresentation(img);
        NSString *mimetype  = [imageExtension mimeType];

        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, [NSString stringWithFormat:@"%@.%@",@"photo",imageExtension]] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return httpBody;
}
- (NSData *)header:(NSString *)boundary
                             images:(NSDictionary *)images {
    NSMutableData *httpBody = [NSMutableData data];

    // add params (all params are strings)

    [self enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    // add image data
    NSString *imageExtension = @"png";
    for (NSString *key in images) {
        NSString *filename  = key;
        UIImage *img = images[key];
        NSData   *data      = UIImagePNGRepresentation(img);
        NSString *mimetype  = [imageExtension mimeType];

        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, [NSString stringWithFormat:@"%@.%@",@"photo",imageExtension]] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    return httpBody;
}

@end

@implementation NSMutableDictionary (DDNSMutableDictionary)
-(NSMutableDictionary *)removeImagesAndGiveInNewDictionary {
    NSMutableDictionary *images = [NSMutableDictionary new];
    NSDictionary *dict = self;
    for (NSString *key in dict.allKeys) {
        id obj = self[key];
        if ([obj isKindOfClass:UIImage.class]) {
            [images setValue:obj forKey:key];
            [self removeObjectForKey:key];
        }
    }
    return images;
}
@end

@implementation NSArray (Extensions)

- (NSString*)json
{
    NSString* json = nil;
    
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return (error ? nil : json);
}

@end

@implementation NSMutableArray (Extensions)

- (NSString*)json
{
    NSString* json = nil;
    
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return (error ? nil : json);
}

@end



