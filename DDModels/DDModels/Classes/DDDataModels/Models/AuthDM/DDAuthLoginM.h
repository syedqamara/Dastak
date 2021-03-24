//
//  DDAuthLoginM.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//

#import "DDBaseApiModel.h"
#import "DDUserM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDAuthAlreadyLoginM : JSONModel


@end


@interface DDAuthResendInvitationM : JSONModel

@end

@interface DDAuthResetPasswordSectionM : JSONModel

@end


@interface DDAuthLoginDataM : JSONModel
@property (strong, nonatomic) DDUserM <Optional>*user;
@end


@interface DDAuthLoginM : DDBaseApiModel
@property (strong, nonatomic) DDAuthLoginDataM <Optional>*data;
@end

NS_ASSUME_NONNULL_END
