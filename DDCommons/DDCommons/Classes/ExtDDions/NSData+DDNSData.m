//
//  NSData+DDNSData.m
//  DDEncryption
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import "NSData+DDNSData.h"
#import "NSDictionary+DDNSDictionary.h"

@implementation NSData(DDNSData)
-(NSString *)stringValue {
    NSError *error;
    id decoded = [NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
    if ([decoded isKindOfClass:NSDictionary.class]) {
        NSDictionary *dict = decoded;
        return [dict bv_jsonStringWithPrettyPrint:YES];
    }
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
-(NSString *)plainString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
-(id)decodeTo:(Class)classObj {
    NSError *error;
    if ([classObj isEqual:NSDictionary.class]) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:&error];
        return dictionary;
    }
    NSObject *obj = [[classObj alloc]initWithData:self error:&error];
    return obj;
}
@end
