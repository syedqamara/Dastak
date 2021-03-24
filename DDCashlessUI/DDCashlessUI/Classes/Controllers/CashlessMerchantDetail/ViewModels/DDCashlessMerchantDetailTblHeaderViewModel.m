//
//  DDCashlessMerchantDetailTblHeaderViewModel.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 13/03/2020.
//

#import "DDCashlessMerchantDetailTblHeaderViewModel.h"
#import "NSString+DDString.h"
@implementation DDCashlessMerchantDetailTblHeaderViewModel

-(NSString *) cuisinesAndSubCategoriesWithDot {
    return [self.merchant.cuisines_sub_categories componentsJoinedByString:@"".dotString];
}

@end
