//
//  DDCashlessMerchantM+DDCashless.m
//  DDCashless
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import "DDCashlessMerchantM+DDCashless.h"
#import "DDLocations.h"
#import <CoreLocation/CoreLocation.h>
#import "DDBasket.h"
#import "DDCashlessManager.h"
#import "DDCommons.h"
@implementation DDCashlessMerchantM(DDCashless)
-(BOOL) isOutletOpenAndExistInPloygon {
    if (DDLocationsManager.shared.selectedCashlessDeliveryLocation == nil) {
        return NO;
    }
    if (self.isLastMileDelivery || self.isTakeAway) {
        return self.isOutletOpen;
    }
    CLLocationCoordinate2D selectedLocationCoords = DDLocationsManager.shared.selectedCashlessDeliveryLocation.toCoreLocationCoordinate;
    if (self.isNewRegion && [self CheckPointExist:selectedLocationCoords] && self.isOutletOpen) {
        return YES;
    } else if ([DDLocationsManager.shared checkPoint:selectedLocationCoords existInCoordinates:self.coreDeliveryRegion] && self.isOutletOpen){
        return YES;
    }
    return NO;
}
-(BOOL)CheckPointExist:(CLLocationCoordinate2D)coordinate {
    BOOL isExist = NO;
    for (DDDeliveryRegionM *region in self.delivery_regions) {
        if (region.map_shape_info.type == DDPolygonShapeTypeCircle) {
            isExist = [DDLocationsManager.shared checkPoint:coordinate existInCircle:region.map_shape_info.toCoreLocation.coordinate withRadius:region.map_shape_info.radius.doubleValue];
        } else {
            isExist = [DDLocationsManager.shared checkPoint:coordinate existInCoordinates:region.getCLLocationsCoordinates];
        }
        if (isExist) {
            if (region.delivery_rules.count > 0) {
                [self setDeliveryRules:region.delivery_rules];
            }
            DDBasket.shared.currentOrder.selected_region = region;
            break;
        }
    }
    return isExist;
}
-(void)validateSelectedLocationOnOutlet:(DDOutletM *)outlet onCompletion:(StringCompletionCallBack)completion {
    
    DDDeliveryAddressM *deliveryAddressModel = DDLocationsManager.shared.selectedCashlessDeliveryLocation;
    if (deliveryAddressModel == nil) return;
    
    if (self.isLastMileDelivery) {
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        if (outlet.outlet_id != nil) {
            [param setValue:outlet.outlet_id forKey:@"outlet_id"];
        }
        if (outlet.lat != nil) {
            [param setValue:outlet.lat.stringValue forKey:@"outlet_lat"];
        }
        if (outlet.lng != nil) {
            [param setValue:outlet.lng.stringValue forKey:@"outlet_lng"];
        }
        if (deliveryAddressModel.latitude != nil) {
            [param setValue:deliveryAddressModel.latitude forKey:@"delivery_lat"];
        }
        if (deliveryAddressModel.longitude != nil) {
            [param setValue:deliveryAddressModel.longitude forKey:@"delivery_lng"];
        }
        
        DDCashlessRequestM *reqM = [DDCashlessRequestM new];
        reqM.custom_parameters = param;
        reqM.merchant_id = self.merchant_id;
        reqM.outlet_id = outlet.outlet_id;
        __weak typeof(self) weakSelf = self;
        [DDCashlessManager.shared checkLastMileRegion:reqM withCompletion:^(DDLastMileRegionCheckApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (model != nil) {
                if (model.successfulApi) {
                    weakSelf.is_open = model.data.is_open;
                    weakSelf.is_exit_in_region = model.data.is_open;
                    DDDeliveryRegionM *region = [[DDDeliveryRegionM alloc] init];
                    region.zone_id = model.data.zone_id;
                    region.title = nil;
                    
                    if (region.delivery_rules.count > 0) {
                        [weakSelf setDeliveryRules:region.delivery_rules];
                    }
                    
                    DDDeliveryRegionInfoM *regionInfo = [[DDDeliveryRegionInfoM alloc] init];
                    regionInfo.lat = @(deliveryAddressModel.latitude.doubleValue);
                    regionInfo.lng = @(deliveryAddressModel.longitude.doubleValue);
                    
                    region.map_shape_info = regionInfo;
                    
                    DDBasket.shared.currentOrder.selected_region = region;

                    if (completion !=nil) {
                        completion(nil);
                    }
                }
                else {
                    if (completion !=nil) {
                        completion(model.message);
                    }
                }
            }
            else {
                if (completion !=nil) {
                    completion(error.localizedDescription);
                }
            }
        }];
    } else {
        self.is_exit_in_region = @([self isOutletOpenAndExistInPloygon]);
        if (completion !=nil) {
            completion(nil);
        }
    }
}
-(BOOL)isAllowedToPlaceOrder {
    return [self isOutletOpen] && [self isExistInRegion];
}
@end
