//
//  DDEncryptionManager.h
//  DDCommons
//
//  Created by M.Jabbar on 29/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDCommons/DDCommons.h"
#import "DDEncryption.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDEncryptionManager : NSObject

+(DDEncryptionManager *)shared;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *iv;

-(NSString *) decryptString:(NSString *) str;
-(NSData *) decryptStringToData:(NSString *) str;
-(NSString *) encryptDictionaryIntoString:(NSMutableDictionary *) parameters;
-(NSMutableDictionary *) encryptDictionary:(NSMutableDictionary *) parameters;
-(NSData *) decryptData:(NSData *) responseData;
-(NSString *) encryptRedemptionPin:(NSString *) pin;
-(NSString *) decryptRedemptionPin:(NSString *) pin;

@end

NS_ASSUME_NONNULL_END
