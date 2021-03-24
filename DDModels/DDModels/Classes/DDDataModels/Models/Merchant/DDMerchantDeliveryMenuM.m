//
//  DDMerchantDeliveryMenuM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDMerchantDeliveryMenuM.h"

@implementation DDMerchantDeliveryMenuM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"menu_id":@"id"}];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    [self setMenuIDInEachItem];
    return self;
}
-(void)setMenuIDInEachItem {
    for (DDMerchantDeliveryMenuItemM *item in self.items) {
        item.menu_id = self.menu_id;
    }
}
@end
