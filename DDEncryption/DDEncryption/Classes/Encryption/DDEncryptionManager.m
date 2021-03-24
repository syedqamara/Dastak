//
//  DDEncryptionManager.m
//  DDCommons
//
//  Created by M.Jabbar on 29/01/2020.
//

#import "DDEncryptionManager.h"

@implementation DDEncryptionManager
@synthesize key, iv;

static DDEncryptionManager *_sharedObject;
+(DDEncryptionManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [DDEncryptionManager.alloc init];
    });
    return _sharedObject;
}
-(void)checkAndSetDefaultKey {
    if (key.length == 0 || iv.length == 0) {
        key = DDCAppConfigManager.shared.api_config.ENCRYPTION_KEY;
        iv = DDCAppConfigManager.shared.api_config.ENCRYPTION_IV;
    }
}
-(void)resetKeys {
    key = @"";
    iv = @"";
}
-(NSString *) decryptString:(NSString *) str {
    [self checkAndSetDefaultKey];
    NSString *encryptedStr = str;
    encryptedStr = [encryptedStr stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    encryptedStr = [encryptedStr stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    encryptedStr = [encryptedStr stringByReplacingOccurrencesOfString:@"," withString:@"="];
    
//    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[encryptedStr base64EncodedString] options:0];
    NSData *decyptedData = [FWEncryptorAES decryptFromBase64:encryptedStr Key:[key dataUsingEncoding:NSUTF8StringEncoding] IV:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    [self resetKeys];
    if (decyptedData) {
        NSString *charlieSendString = [[NSString alloc] initWithData:decyptedData encoding:NSUTF8StringEncoding];
        return charlieSendString;
    }
    return nil;
}

-(NSData *) decryptStringToData:(NSString *) str {
    [self checkAndSetDefaultKey];
//    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSString *encryptedString = [str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"," withString:@"="];
    NSData *decyptedData = [FWEncryptorAES decryptFromBase64:encryptedString Key:[key dataUsingEncoding:NSUTF8StringEncoding] IV:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* charlieSendString = [[NSString alloc] initWithData:decyptedData encoding:NSUTF8StringEncoding];
    [self resetKeys];
    return [charlieSendString dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *) encryptDictionaryIntoString:(NSMutableDictionary *) parameters{
    [self checkAndSetDefaultKey];
    NSString *json = [parameters bv_jsonStringWithPrettyPrint:YES];
    NSString *queryString = json;
    NSString *encryptedString = [FWEncryptorAES encryptToBase64:[queryString dataUsingEncoding:NSUTF8StringEncoding] Key:[key dataUsingEncoding:NSUTF8StringEncoding] IV:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    
//    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
//    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
//    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"=" withString:@","];
    [self resetKeys];
    return encryptedString;
}
-(NSMutableDictionary *) encryptDictionary:(NSMutableDictionary *) parameters{
    [self checkAndSetDefaultKey];
    NSString *json = [parameters bv_jsonStringWithPrettyPrint:YES];
    NSString *queryString = json;
    NSString *encryptedString = [FWEncryptorAES encryptToBase64:[queryString dataUsingEncoding:NSUTF8StringEncoding] Key:[key dataUsingEncoding:NSUTF8StringEncoding] IV:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    encryptedString = [encryptedString stringByReplacingOccurrencesOfString:@"=" withString:@","];
    [self resetKeys];
    return [[NSMutableDictionary alloc] initWithDictionary:@{@"params" : encryptedString}];
}
-(NSData *) decryptData:(NSData *) responseData{
    [self checkAndSetDefaultKey];
    NSString* base64String = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSData *decyptedData = [FWEncryptorAES decrypt:decodedData Key:[key dataUsingEncoding:NSUTF8StringEncoding] IV:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    __autoreleasing NSError* error = nil;
    [self resetKeys];
    if (decyptedData) {
        NSString *charlieSendString = [[NSString alloc] initWithData:decyptedData encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:decyptedData
                                                               options:kNilOptions error:&error];
        if (error == nil) {
        }
#if DEBUG_MODE
        if (charlieSendString){
            NSLog(@"JSON STRING:%@",charlieSendString);
        }
        
#endif
        
    }
    return decyptedData;
    
}

-(NSString *) encryptRedemptionPin:(NSString *) pin{
    NSString *encryptedString = [FWEncryptorAES encryptToBase64:[pin dataUsingEncoding:NSUTF8StringEncoding] Key:[AES_PARAM dataUsingEncoding:NSUTF8StringEncoding] IV:[HSS_IV5 dataUsingEncoding:NSUTF8StringEncoding]];
    return encryptedString;
}

-(NSString *) decryptRedemptionPin:(NSString *) pin{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:pin options:0];
    NSData *decyptedData = [FWEncryptorAES decrypt:decodedData Key:[AES_PARAM dataUsingEncoding:NSUTF8StringEncoding] IV:[HSS_IV5 dataUsingEncoding:NSUTF8StringEncoding]];

    if (decyptedData) {
        NSString *charlieSendString = [[NSString alloc] initWithData:decyptedData encoding:NSUTF8StringEncoding];
        return charlieSendString;
    }
    return @"";
}

@end
