//
//  DDUserM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 20/08/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDUserGender) {
    DDUserGenderMale,
    DDUserGenderFemale,
    DDUserGenderNone,
};

@interface DDUserM : DDBaseModel
@property (strong, nonatomic) NSString <Optional>*cmd;
@property (strong, nonatomic) NSNumber <Optional>*status;
@property (strong, nonatomic) NSNumber <Optional>*user_id;
@property (strong, nonatomic) NSString <Optional>*session_token;
@property (strong, nonatomic) NSString <Optional>*first_name;
@property (strong, nonatomic) NSString <Optional>*last_name;
@property (strong, nonatomic) NSString <Optional>*email;
@property (strong, nonatomic) NSString <Optional>*date_of_birth;
@property (strong, nonatomic) NSString <Optional>*gender;
@property (strong, nonatomic) NSString <Optional>*phone_number;
@property (strong, nonatomic) NSNumber <Optional>*is_phone_verified;
@property (strong, nonatomic) NSNumber <Optional>*is_third_party_login;
@property (strong, nonatomic) NSString <Optional>*country_of_residence;

-(BOOL)isPhoneNumberVerified;
-(NSString *)completeMobileNumber;

-(DDUserGender)genderType;
-(void)setGenderType:(DDUserGender)genderType;
@end

NS_ASSUME_NONNULL_END
