//
//  NSData+DDNSData.h
//  DDEncryption
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSData(DDNSData)
-(NSString *)stringValue;
-(NSString *)plainString;
-(id)decodeTo:(Class)classObj;
@end

NS_ASSUME_NONNULL_END
