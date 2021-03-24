//
//  DDAuthEmailValidationM.h
//  DDCommons
//
//  Created by Zubair Ahmad on 20/01/2020.
//

#import "DDBaseApiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAuthEmailValidationM : JSONModel
@property (strong, nonatomic) NSString <Optional> *message;
@property (strong, nonatomic) NSNumber <Optional> *is_user_exist;
@end

NS_ASSUME_NONNULL_END
