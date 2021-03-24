//
//  DDStorageManager.h
//  DDStorage
//
//  Created by Awais Shahid on 05/03/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDSharedPreferences : NSObject

+(DDSharedPreferences *)shared;

- (id _Nullable)loadValueForKey:(NSString*)key forAccessGroup:(NSString *)group;

-(void)saveUserNameAndPWD:(NSString *) user password:(NSString *)password;
-(void)saveUserSessionTokenAndEmail:(NSString* _Nullable)email token:(NSString* _Nullable)token name:(NSString* _Nullable)name profileImg:(NSString* _Nullable)profileImg;
-(void)saveUserPwd:(NSString *) pwd;
    
-(NSString* _Nullable) getUser;
-(NSString* _Nullable) sessionToken;
-(NSString* _Nullable) getPassword;
-(NSString* _Nullable) getUniqueKey;

-(void) saveDeviceKeyInKeyChain;
-(void) resetDeviceKeyInKeyChain;
-(NSString *)uniqueDeviceKeyWithPrefix:(NSString *)key;
-(NSString *)uniqueDeviceKeyForThisAppInKeychain:(NSString *)prefix;
#pragma mark - Defaults

- (void)setBoolDF:(BOOL)val forKey:(NSString *)key;
- (BOOL)boolforKeyDF:(NSString *)key;
- (void)setIntegerDF:(NSInteger)val forKey:(NSString *)key;
- (NSInteger)integerforKeyDF:(NSString *)key;
- (void)setObjectDF:(id _Nullable)obj forKey:(NSString *)key;
- (id _Nullable)objectforKeyDF:(NSString *)key;

#pragma mark - Keychains

- (void)setBoolKC:(BOOL)val forKey:(NSString *)key;
- (BOOL)boolforKeyKC:(NSString *)key;
- (void)setIntegerKC:(NSInteger)val forKey:(NSString *)key;
- (NSInteger)integerforKeyKC:(NSString *)key;
- (void)setObjectKC:(id _Nullable)obj forKey:(NSString *)key;
- (id _Nullable)objectforKeyKC:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
