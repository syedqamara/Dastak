//
//  DDBaseApiModel.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 08/01/2020.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseApiModel: JSONModel
@property (strong, nonatomic) NSString <Optional>*title;
@property (strong, nonatomic) NSString <Optional>*message;
@property (strong, nonatomic) NSNumber <Optional>*status;
@property (strong, nonatomic) NSNumber <Optional>*http_code;
@property (strong, nonatomic) NSDictionary <Optional>*api_response;
-(BOOL)successfulApi;
-(NSError*)apiError;
@end

NS_ASSUME_NONNULL_END
