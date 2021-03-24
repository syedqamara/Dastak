//
//  DDStorageManager.m
//  DDStorage
//
//  Created by Awais Shahid on 05/03/2020.
//

#import "DDSharedPreferences.h"
#import <JNKeychain/JNKeychain.h>
#import "KeychainItemWrapper.h"
#import <DDCommons/DDCommons.h>

#define KEYCHAIN_IDDDIFIER @"dynamicdelivery_KEYCHAIN"
#define IS_USER_LOGGED_IN @"IS_USER_LOGGED_IN"
#define ITUNE_ITMS_URL @"itms-apps://itunes.apple.com/app/id"

@interface DDSharedPreferences() {
    KeychainItemWrapper *wrapper;
    NSString* keychain_access_group;
}

@end

@implementation DDSharedPreferences

static DDSharedPreferences *_sharedObject;
+(DDSharedPreferences *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDSharedPreferences alloc]init];
    });
    return _sharedObject;
}

-(id)init{
    if (self=[super init]) {
        keychain_access_group = APP_BUNDLE_ID;
        wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_IDDDIFIER accessGroup:nil];
        [self saveKey];
    }
    return self;
}

-(void)saveKey {
    if(![self getUniqueKey] || [self getUniqueKey].length == 0){
        [wrapper setObject:[NSString stringWithFormat:@"%f",NSDate.date.timeIntervalSince1970] forKey:(__bridge id)(kSecAttrAccount)];
    }
}


-(void) saveUserSessionTokenAndEmail:(NSString *) eml tkn:(NSString *)tkn{
    [wrapper setObject:tkn forKey:(id)kSecAttrService];
    [wrapper setObject:eml forKey:(id)kSecValueData];
}


- (BOOL) saveValueKeyChain:(NSString *)value forKey:(NSString *)key
{
    NSString *group = APP_BUNDLE_ID;
    NSString *forGroupLog = (group ? [NSString stringWithFormat:@" for access group '%@'", group] : @"");
    BOOL saved = [JNKeychain saveValue:value forKey:key forAccessGroup:group];
    if (saved) {
        NSLog(@"Correctly saved value '%@' for key '%@'%@", value, key, forGroupLog);
    } else {
        NSLog(@"Failed to save!%@", forGroupLog);
    }
    
    NSLog(@"Value for key '%@' is: '%@'%@", key, [JNKeychain loadValueForKey:key forAccessGroup:group], forGroupLog);
    
//    if ([JNKeychain deleteValueForKey:key forAccessGroup:group]) {
//        NSLog(@"Deleted value for key '%@'. Value is: '%@'%@", key, [JNKeychain loadValueForKey:key forAccessGroup:group], forGroupLog);
//    } else {
//        NSLog(@"Failed to delete!%@", forGroupLog);
//    }
    return saved;
}

- (id _Nullable)loadValueForKey:(NSString*)key forAccessGroup:(NSString *)group {
     return [JNKeychain loadValueForKey:key forAccessGroup:group];
}


-(void)saveUserNameAndPWD:(NSString *) user password:(NSString *)password {
//    [wrapper setObject:user forKey:(id)kSecAttrService];
//    [wrapper setObject:password forKey:(id)kSecValueData];
}

-(void)saveUserSessionTokenAndEmail:(NSString* _Nullable)email token:(NSString* _Nullable)token name:(NSString* _Nullable)name profileImg:(NSString* _Nullable)profileImg {
    [self setObjectKC:token forKey:@"entutoken"];
    [self setObjectKC:email forKey:@"entuemail"];
    [self setObjectKC:name forKey:@"entuname"];
    [self setObjectKC:profileImg forKey:@"entuprofileimg"];
    BOOL isLoggedIn = token.length > 0;
    [DD_GROUP_DEFAULTS setBool:isLoggedIn forKey:IS_USER_LOGGED_IN];
    [DD_GROUP_DEFAULTS synchronize];
}

-(void)saveUserPwd:(NSString *) pwd {
//    [self saveValueKeyChain:pwd forKey:@"entupwd" andAccessGroup:KEYCHAIN_ACCESS_GROUP];
}
    

-(NSString * _Nullable) getUser {
    return [wrapper objectForKey:(id)kSecAttrService];
}
-(NSString * _Nullable) sessionToken {
    return [JNKeychain loadValueForKey:@"entutoken" forAccessGroup:keychain_access_group];
}
-(NSString * _Nullable) getPassword {
    return [wrapper objectForKey:(id)kSecValueData];
}
-(NSString * _Nullable) getUniqueKey {
    if([wrapper objectForKey:(__bridge id)(kSecAttrAccount)]){
        return [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    }
    return nil;
}


-(void) saveDeviceKeyInKeyChain {
//    if ([DDUserManager sharedManager].device_key){
//        [self saveValueKeyChain:[DDUserManager sharedManager].device_key forKey:@"d_k" andAccessGroup:KEYCHAIN_ACCESS_GROUP];
//        [DDExtraUtil saveUserLoggedInGroups];
//    }
}

-(void) resetDeviceKeyInKeyChain {
//    [self saveValueKeyChain:nil forKey:@"d_k" andAccessGroup:KEYCHAIN_ACCESS_GROUP];
}




#pragma mark - Defaults
- (void)setBoolDF:(BOOL)val forKey:(NSString *)key {
    [DD_DEFAULTS setBool:val forKey:key];
}
- (BOOL)boolforKeyDF:(NSString *)key {
    return [DD_DEFAULTS boolForKey:key];
}
- (void)setIntegerDF:(NSInteger)val forKey:(NSString *)key {
    [DD_DEFAULTS setInteger:val forKey:key];
}
- (NSInteger)integerforKeyDF:(NSString *)key {
    return [DD_DEFAULTS integerForKey:key];
}
- (void)setObjectDF:(id _Nullable)obj forKey:(NSString *)key {
    [DD_DEFAULTS setObject:obj forKey:key];
}
- (id _Nullable)objectforKeyDF:(NSString *)key {
    return [DD_DEFAULTS objectForKey:key];
}


#pragma mark - Keychains

- (void)setBoolKC:(BOOL)val forKey:(NSString *)key {
    [JNKeychain saveValue:@(val) forKey:key forAccessGroup:keychain_access_group];
}
- (BOOL)boolforKeyKC:(NSString *)key {
    NSNumber *val = [JNKeychain loadValueForKey:key forAccessGroup:keychain_access_group];
    return (val != nil && val.boolValue);
}
- (void)setIntegerKC:(NSInteger)val forKey:(NSString *)key {
    [JNKeychain saveValue:@(val) forKey:key forAccessGroup:keychain_access_group];
}
- (NSInteger)integerforKeyKC:(NSString *)key {
    NSNumber *val = [JNKeychain loadValueForKey:key forAccessGroup:keychain_access_group];
    return val.integerValue;
}
- (void)setObjectKC:(id _Nullable)obj forKey:(NSString *)key {
    [JNKeychain saveValue:obj forKey:key forAccessGroup:keychain_access_group];
}
- (id _Nullable)objectforKeyKC:(NSString *)key {
    return [JNKeychain loadValueForKey:key forAccessGroup:keychain_access_group];
}
-(NSString *)uniqueDeviceKeyWithPrefix:(NSString *)key {
    NSUUID *uuid = [NSUUID UUID];
    NSString *uidStr = [NSString stringWithFormat:@"%@%@",key,[uuid UUIDString]];
    return uidStr;
}
-(NSString *)uniqueDeviceKeyForThisAppInKeychain:(NSString *)prefix {
    NSString *key = [self objectforKeyKC:@"ent_device_key"];
    if (key.length > 0) {
        key = [self uniqueDeviceKeyWithPrefix:prefix];
        [self saveValueKeyChain:key forKey:@"ent_device_key"];
    }
    return key;
}
@end
