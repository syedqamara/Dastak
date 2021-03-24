//
//  DDCashlessMerchantDetailModulesViewModel.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 05/03/2020.
//

#import "DDCashlessMerchantDetailModulesViewModel.h"

@implementation DDCashlessMerchantDetailModulesViewModel

+(NSMutableArray  *)getAccumulatedOutletServicesArray:(NSMutableArray<DDMerchantModuleNavigation,Optional> *)array{
    NSMutableArray *resultingArray = [[NSMutableArray alloc] init];
    if (array == nil){
        return resultingArray;
    }
    for (int c= 0; c<array.count;) {
        DDCashlessMerchantDetailModulesViewModel *newObj = [DDCashlessMerchantDetailModulesViewModel new];
        newObj.leftItem = [array objectAtIndex:c];
        newObj.leftItem.objectIndex = [NSNumber numberWithInt:c];
        if (c + 1 < array.count) {
            newObj.rightItem = [array objectAtIndex:c+1];
            newObj.rightItem.objectIndex = [NSNumber numberWithInt:c+1];
            c = c+2;
        }else
            c++;
        [resultingArray addObject:newObj];
    }
    return resultingArray;
}

@end
