//
//  DDOrderM.m
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 5/15/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDRequestOrderM.h"
#import "DDAuth.h"
#import "DDBasket.h"
#import "DDModels.h"
#import "DDLocations.h"

@implementation DDUserInfo

@end

@interface DDRequestOrderM(){
    DDOutletM *currentOutlet;
    DDCashlessMerchantM *currentMerchant;
    NSString *specialMessageObject;
    
}

@end
@implementation DDRequestOrderM

-(instancetype)initWithOrder:(DDOrderBasketM *)order {
    if (!self) {
        self = [super init];
    }
    self.order_id = order.order_id;
    self.userInfo = [DDUserInfo.alloc init];
    self.userInfo.name = DDUserManager.shared.currentUser.name;
    self.userInfo.phoneNumber = DDUserManager.shared.currentUser.mobile_phone;
    if (DDBasket.shared.currentOrder.isTakeawayOrder != nil && [DDBasket.shared.currentOrder.isTakeawayOrder boolValue]){
        DDDeliveryAddressM *model = [[DDDeliveryAddressM alloc] init];
        model.latitude = DDLocationsManager.shared.selectedCashlessDeliveryLocation.latitude;
        model.longitude = DDLocationsManager.shared.selectedCashlessDeliveryLocation.longitude;
        model.title = @"";
        model.is_current_location = [NSNumber numberWithBool:YES];
        model.area_city = @"";
        model.apartment_address = @"";
        model.getCompleteAddress = @"";
        self.userInfo.selectedLocationObject = model;
        self.userInfo.selectedLocations = [NSMutableArray arrayWithObject:model];
    }else {
        self.userInfo.selectedLocationObject = DDLocationsManager.shared.selectedCashlessDeliveryLocation;
        self.userInfo.selectedLocations =  DDLocationsManager.shared.cashlessDeliveryLocations;
    }
    self.merchant = order.merchant;
    self.outlet = order.outlet;
    self.addedProducts = [order.addedProducts mutableCopy];
    for (DDCashlessItemM *product in self.addedProducts) {
        product.shouldSaveComplete = @(NO);
    }
    self.currency = order.merchant.outletCurrency;
    self.phoneNumber = [DDUserManager shared].currentUser.mobile_phone;//[NSString stringWithFormat:@"%@",order.phoneNumber];
    self.currentUserName = order.currentUserName;

    self.totalPrice = @(order.allPriceWithUpgradesAndCounts);
    self.subtotalPrice = @(order.allPriceWithUpgradesAndCountsAfterDiscount);
    self.discountPrice = @(order.allPriceWithUpgradesAndCounts - order.allPriceWithUpgradesAndCountsAfterDiscount);
    self.total_items = @(order.allItemCount);
    self.delivery_cart_params = order.merchant.delivery_cart_params;
    NSNumber *zoneId = order.selected_region.zone_id;
    if (zoneId != nil) {
        NSMutableDictionary *dict = self.delivery_cart_params.mutableCopy;
        [dict setObject:zoneId forKey:@"zone_id"];
        self.delivery_cart_params = dict;
    }
    [self setOutlet:order.outlet];
    
    return self;
}
//-(BOOL)isKeyAvailable:(NSString *)key {
//    for (NSString *removingObjectKey in removeObjectFromJson) {
//        if ([removingObjectKey isEqualToString:key]) {
//            return YES;
//        }
//    }
//    return NO;
//}
//-(NSDictionary *)removeFromDictionary:(NSDictionary *)dictionary currentIndex:(NSInteger)index {
//    NSMutableDictionary *dict = dictionary;
//    if (index == removeObjectFromJson.count) {
//        return dict;
//    }
//    for (NSString *key in dictionary.allKeys) {
//        if ([self isKeyAvailable:key]) {
//            [dict removeObjectForKey:key];
//            index++;
//
//        }else {
//            if ([dictionary[key] isKindOfClass:[NSDictionary class]]) {
//                [[self removeFromDictionary:dict[key] currentIndex:index] mutableCopy];
//            }
//            else if ([dictionary[key] isKindOfClass:[NSArray class]]) {
//                NSArray *obj = dictionary[key];
//                NSDictionary *dictObj = obj.firstObject;
//                if (dictObj != nil) {
//                    [[self removeFromDictionary:dictObj currentIndex:index] mutableCopy];
//                }
//            }
//        }
//
//    }
//    return dictionary;
//}


-(NSDictionary *)toDictionary {
    self.total_items = @([self allItemCount]);
    self.discountPrice = @(_totalPrice.doubleValue - _subtotalPrice.doubleValue);
    self.userInfo.userId = DDUserManager.shared.currentUser.user_id;
    self.token = DDUserManager.shared.currentUser.session_token;
    self.discount_on_whole_basket = @(NO);
    
    //NSDictionary *dict = [self removeFromDictionary:[super toDictionary].mutableCopy currentIndex:0];
    
    
    
    NSMutableDictionary *d = [[super toDictionary] mutableCopy];
    [DDCashlessMerchantM checkAndRemoveItemsFromDictionary:d];
    return d;
    //return dict;
}



-(NSString *)toJSONString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self toDictionary]
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"%s: error: %@", __func__, error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
-(NSData *)toJSONData {
    NSError *error;
    NSDictionary *dict = [self toDictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    return data;
}
-(void)setOutlet:(DDOutletM<Optional> *)outlet {
    self.outlet_name = outlet.name;
    self.outletID = outlet.outlet_id;
    self.outlet_phonenumber = outlet.telephone;
    self.outlet_delivery_phonenumber = outlet.delivery_telephone;
    self.outlet_sf_id = outlet.sfId;
    currentOutlet = outlet;
}
-(DDOutletM<Optional> *)outlet{
    return currentOutlet;
}
-(void)setMerchant:(DDCashlessMerchantM<Optional> *)merchant {
    self.merchantID = merchant.merchant_id;
    self.merchant_sf_id = merchant.merchant_sf_id;
    self.deliveryCharges = merchant.deliveryCharges;
    currentMerchant = merchant;
}
-(DDCashlessMerchantM<Optional> *)merchant {
    return currentMerchant;
}
-(void)resetBasket {
    [super resetBasket];
    self.deviceId = DDCCommonParamManager.shared.default_api_parameters.__device_id.toNumber;
}
@end
