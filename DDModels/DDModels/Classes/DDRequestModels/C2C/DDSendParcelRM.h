//
//  DDSendParcelRM.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 13/10/2020.
//

#import "DDBaseRequestModel.h"
#import "DDDeliveryAddressM.h"
#import "DDUserM.h"
#import "DDBaseModel.h"
#import "DDConfigDataM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDParcelClientInfoRM : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *name;
@property (strong, nonatomic) NSString <Optional> *phone_number;
@end
@interface DDParcelInfoRM : DDBaseModel
@property (strong, nonatomic) NSNumber <Optional> *category_id;
@property (strong, nonatomic) NSString <Optional> *category_title;
@end


@interface DDSendParcelRM : DDBaseRequestModel
@property (strong, nonatomic) DDDeliveryAddressM<Ignore> *app_address;
@property (strong, nonatomic) DDDeliveryAddressM<Optional> *pick_up_address;
@property (strong, nonatomic) DDDeliveryAddressM<Optional> *drop_off_address;
@property (strong, nonatomic) DDParcelInfoRM<Optional> *parcel_info;
@property (strong, nonatomic) DDParcelClientInfoRM<Optional> *reciever_info;
@property (strong, nonatomic) DDParcelClientInfoRM<Optional> *sender_info;
@property (strong, nonatomic) DDPaymentMethod <Ignore> *payment;
@property (strong, nonatomic) NSString <Optional> *payment_type;
@property (strong, nonatomic) NSDictionary <Optional> *fair_params;
@property (strong, nonatomic) NSDictionary <Optional> *default_param;
@property (strong, nonatomic) DDUserM <Optional> *user;
-(BOOL)hideDropoffAddressView;
-(BOOL)hidePickupAddressView;
-(BOOL)hideBottomView;
-(BOOL)haveBothAddresses;
-(BOOL)haveDropoffAddress;
-(BOOL)havePickupAddress;
-(BOOL)isReadyToPlaceOrder;
-(DDDeliveryAddressM *)defaultAddress;
@end

NS_ASSUME_NONNULL_END
