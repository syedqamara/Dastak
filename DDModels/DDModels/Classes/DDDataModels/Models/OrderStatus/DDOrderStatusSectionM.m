//
//  DDOrderStatusSectionM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusSectionM.h"

@implementation DDOrderStatusSectionM
- (DDOrderStatusSectionType)type {
    if ([self.identifier isEqualToString:@"order_status"]) {
        return DDOrderStatusSectionTypeStatus;
    }
    if ([self.identifier isEqualToString:@"merchant_info"]) {
        return DDOrderStatusSectionTypeMerchantInfo;
    }
    if ([self.identifier isEqualToString:@"delivery_info"]) {
        return DDOrderStatusSectionTypeDeliveryInfo;
    }
    if ([self.identifier isEqualToString:@"order_detail"]) {
        return DDOrderStatusSectionTypeDetail;
    }
    if ([self.identifier isEqualToString:@"driver_info"]) {
        return DDOrderStatusSectionTypeDriverInfo;
    }
    
    return DDOrderStatusSectionTypeUnknown;
}
-(BOOL)isExpanded {
    return self.is_expanded.boolValue;
}
-(BOOL)isExpandable {
    return self.is_expandable.boolValue;
}
-(void)toggle {
    self.is_expanded = @(![self isExpanded]);
}
-(NSArray<NSDictionary *> *)charts {
    NSMutableArray *arr = [NSMutableArray new];
    for (DDOrderStatusM *status in self.statuses) {
        [arr addObject:status.chartDict];
        [arr addObject:status.emptyChartDict];
    }
    return arr;
}
@end
