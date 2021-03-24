//
//  DDOrderHistoryM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDOrderHistoryM.h"

@implementation DDOrderHistoryM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"order_id":@"id"}];
}
@end
