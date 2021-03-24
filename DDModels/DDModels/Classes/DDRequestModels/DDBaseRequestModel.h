//
//  DDBaseRequestModel.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 25/02/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseRequestModel : JSONModel
@property (strong, nonatomic) NSString <Ignore> *encryption_key;
@property (strong, nonatomic) NSString <Ignore> *encryption_iv;
@property (strong, nonatomic) NSNumber <Optional> *i_c_e;
//Although bellow dictionary is ignore but all of its content will be include when convert this class object to dictionary
@property (strong, nonatomic) NSMutableDictionary <Ignore> *custom_parameters;
-(void)addCustomParams:(NSDictionary*)dic;
-(void)addImage:(UIImage *)img withFileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
