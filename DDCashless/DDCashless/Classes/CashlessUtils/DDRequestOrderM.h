//
//  DDOrderM.h
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 5/15/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDOrderBasketM.h"


@interface DDUserInfo: JSONModel
@property (strong, nonatomic) NSNumber<Optional> *userId;
@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *phoneNumber;
@property (strong, nonatomic) DDDeliveryAddressM<Optional> *selectedLocationObject;
@property (strong, nonatomic) NSArray<DDDeliveryAddressM,Optional> *selectedLocations;

@end

@interface DDRequestOrderM : DDOrderBasketM

@property (strong, nonatomic) NSString<Optional> *outlet_name;
@property (strong, nonatomic) NSString<Optional> *outlet_delivery_phonenumber;
@property (strong, nonatomic) NSString<Optional> *outlet_phonenumber;
@property (strong, nonatomic) DDUserInfo *userInfo;
@property (strong, nonatomic) NSNumber<Optional> *deviceId;
@property (strong, nonatomic) NSString<Optional> *outlet_sf_id;
@property (strong, nonatomic) NSString<Optional> *merchant_sf_id;
@property (strong, nonatomic) NSNumber<Optional> *total_items;
@property (strong, nonatomic) NSNumber<Optional> *discount_on_whole_basket;
@property (strong, nonatomic) NSString<Optional> *token;

@property (strong, nonatomic) NSNumber<Optional> *deliveryCharges;
@property (strong, nonatomic) NSNumber<Optional> *outletID;
@property (strong, nonatomic) NSNumber<Optional> *merchantID;
@property (strong, nonatomic) NSNumber<Optional> *subtotalPrice;
@property (strong, nonatomic) NSNumber<Optional> *totalPrice;
@property (strong, nonatomic) NSNumber<Optional> *discountPrice;


@property (strong, nonatomic) NSDictionary<Optional> *delivery_cart_params;


-(instancetype)initWithOrder:(DDOrderBasketM *)order;


+(void) checkAndRemoveItemsFromDictionary:(NSMutableDictionary *) dictionary;

@end
