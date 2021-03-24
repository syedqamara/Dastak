//
//  DDLogs.h
//  AFNetworking
//
//  Created by Awais Shahid on 18/06/2019.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDLogs : NSObject
+ (void)log:(NSString *)format, ...;
@end

NS_ASSUME_NONNULL_END
