//
//  DDMerchantInfoSectionM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDMerchantInfoSectionM.h"

@implementation DDMerchantInfoSectionM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"times":@"list"}];
}
@end
