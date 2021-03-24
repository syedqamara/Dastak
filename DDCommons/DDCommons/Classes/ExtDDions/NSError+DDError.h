//
//  NSError+DDSEError.h
//  DDSE_Example
//
//  Created by Raheel on 06/11/2018.
//  Copyright © 2018 dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDSEAPIError:NSObject

@property (nonatomic, strong) NSError *errorObject;
@property (nonatomic, strong) NSString *title;

+(DDSEAPIError *) initWithDDSEAPIError:(NSString * _Nullable) title error:(NSError *) error;

-(NSString *) localizedDescription;
@end


@interface NSError (DDSEError)

+ (DDSEAPIError *)errorWithDDSEAPIError:(NSError *)error;
+ (DDSEAPIError *)errorWithDDSEInternetError;

@end

NS_ASSUME_NONNULL_END
