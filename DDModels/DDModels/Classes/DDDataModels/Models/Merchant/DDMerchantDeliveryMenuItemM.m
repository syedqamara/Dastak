//
//  DDMerchantDeliveryMenuItemM.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDMerchantDeliveryMenuItemM.h"
#import "UIFont+DDFont.h"
@implementation DDMerchantDeliveryMenuItemM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"item_id":@"id"}];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    if (self.object_id == nil) {
        [self setUniqueObjectID];
    }
    if (self.selected_options == nil) {
        self.selected_options = [NSMutableArray new];
    }
    return self;
}
-(void)setUniqueObjectID {
    self.object_id = NSUUID.UUID.UUIDString;
}
-(void)insertAdon:(DDMerchantMenuItemCustomizationOptionM *)adon inCust:(DDMerchantMenuItemCustomizationM *)cust {
    adon.cust_id = cust.cust_id;
    [cust select:adon];
}
-(BOOL)haveMenuTitle {
    return self.menu_name.length > 0;
}
-(BOOL)haveCustomization {
    return self.customizations.count > 0;
}
-(NSString *)priceWithCurrency {
    return [NSString stringWithFormat:@"%@ %.2f  ",self.currency, self.price.floatValue];
}
-(NSMutableAttributedString *)orignalPriceWithCurrency {
    if (self.original_price.floatValue > 0) {
        NSString *priceStr = [NSString stringWithFormat:@"%@ %.2f",self.currency, self.original_price.floatValue];
        NSMutableAttributedString *attr = [NSMutableAttributedString.alloc initWithString:priceStr attributes:@{NSFontAttributeName: [UIFont DDRegularFont:11], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSStrikethroughColorAttributeName: UIColor.darkGrayColor, NSStrikethroughStyleAttributeName: @2
        }];
        return attr;
    }
    return nil;
}
-(BOOL)isEqual:(DDMerchantDeliveryMenuItemM *)object {
    return self.item_id.integerValue == object.item_id.integerValue && self.menu_id.integerValue == object.menu_id.integerValue;
}
-(NSInteger)stockCount {
    if (self.item_stock_count != nil) {
        return self.item_stock_count.integerValue;
    }
    return 0;
}
-(CGFloat)priceOfAllOption {
    CGFloat price = 0;
    for (DDMerchantMenuItemCustomizationOptionM *option in self.selected_options) {
        price += option.price.floatValue;
    }
    return price;
}
-(CGFloat)priceWithAllOption {
    CGFloat price = self.price.floatValue;
    for (DDMerchantMenuItemCustomizationOptionM *option in self.selected_options) {
        price += option.price.floatValue;
    }
    return price;
}
-(NSString *)priceOfAllOptionWithCurrency {
    return [NSString stringWithFormat:@"%2.f %@",[self priceOfAllOption], self.currency];
}
-(NSString *)priceWithAllOptionWithCurrency {
    return [NSString stringWithFormat:@"%2.f %@",[self priceWithAllOption], self.currency];
}
-(DDMerchantDeliveryMenuItemM *)copyForItem:(DDMerchantDeliveryMenuItemM *)item {
    DDMerchantDeliveryMenuItemM *temp = [self.toDictionary decodeTo:DDMerchantDeliveryMenuItemM.class];
    if (temp.haveCustomization) {
        NSMutableArray *temArr = [NSMutableArray new];
        for (DDMerchantMenuItemCustomizationM *cust in temp.customizations) {
            for (DDMerchantMenuItemCustomizationOptionM *opt in cust.options) {
                for (DDMerchantMenuItemCustomizationOptionM *addedOpt in item.selected_options) {
                    if (addedOpt.option_id.integerValue == opt.option_id.integerValue) {
                        DDMerchantMenuItemCustomizationOptionM *copy = [opt.toDictionary decodeTo:DDMerchantMenuItemCustomizationOptionM.class];
                        [temArr addObject:copy];
                    }
                }
            }
        }
        temp.selected_options = temArr;
    }
    return temp;
}
-(NSString *)allSelectedOptions {
    NSMutableArray *names = [NSMutableArray new];
    for (DDMerchantMenuItemCustomizationOptionM *option in self.selected_options) {
        [names addObject:option.title];
    }
    return [names componentsJoinedByString:@","];
}
-(id)copy {
    DDMerchantDeliveryMenuItemM *item = [self.toDictionary decodeTo:DDMerchantDeliveryMenuItemM.class];
    return item;
}
@end
