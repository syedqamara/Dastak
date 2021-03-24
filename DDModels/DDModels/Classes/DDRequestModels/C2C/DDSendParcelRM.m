//
//  DDSendParcelRM.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 13/10/2020.
//

#import "DDSendParcelRM.h"
@implementation DDParcelClientInfoRM

@end
@implementation DDParcelInfoRM

@end

@implementation DDSendParcelRM
-(void)setPayment:(DDPaymentMethod<Ignore> *)payment {
    self.payment_type = payment.identifier;
    _payment = payment;
}
-(BOOL)hideDropoffAddressView {
    return ![self havePickupAddress];
}
-(BOOL)hidePickupAddressView {
    return self.pick_up_address == nil;
}
-(BOOL)hideBottomView {
    return ![self haveBothAddresses];
}
-(BOOL)haveBothAddresses {
    return [self haveDropoffAddress] && [self havePickupAddress];
}
-(BOOL)haveDropoffAddress {
    return self.drop_off_address != nil;
}
-(BOOL)havePickupAddress {
    return self.pick_up_address != nil;
}
-(BOOL)haveSenderInfo {
    return self.sender_info.name.length > 0;
}
-(BOOL)haveRecieverInfo {
    return self.reciever_info.name.length > 0;
}
-(BOOL)havePaymentMethod {
    return self.payment_type.length > 0;
}
-(BOOL)haveParcelType {
    return self.parcel_info.category_title.length > 0;
}
-(BOOL)haveFairParams {
    return self.fair_params.count > 0;
}
-(BOOL)isReadyToPlaceOrder {
    return [self haveBothAddresses] && [self havePaymentMethod] && [self haveParcelType] && [self haveRecieverInfo] && [self haveSenderInfo] && [self haveFairParams];
}
-(DDDeliveryAddressM *)defaultAddress {
    if (self.havePickupAddress) {
        return self.pick_up_address;
    }
    return self.app_address;
}
@end
