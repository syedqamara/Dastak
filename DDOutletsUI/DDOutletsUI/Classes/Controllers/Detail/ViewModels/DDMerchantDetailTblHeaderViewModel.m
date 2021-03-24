//
//  DDMerchantDetailTblHeaderViewModel.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 13/03/2020.
//

#import "DDMerchantDetailTblHeaderViewModel.h"
#import "NSString+DDString.h"
@implementation DDMerchantDetailTblHeaderViewModel

-(NSString *) cuisinesAndSubCategoriesWithDot {
    return [self.merchant.cuisines_sub_categories componentsJoinedByString:@"".dotString];
}

@end
