//
//  DDBaseApiModel.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 08/01/2020.
//

#import "DDDeeplinkModel.h"

#define kOldBeautyAndFitness  @"Body"
#define kOldFoodAndDrink  @"Restaurants and Bars"
#define kOldAttractionsAndLeisure  @"Leisure"
#define kOldRetailAndServices  @"Services"
#define kOldHotelsWorldwide  @"Travel"
#define kOldMoreSA  @"SA"
#define kOldKids  @"Kids"
#define kOldRetail  @"Retail"

#define kBeautyAndFitness        @"BeautyAndFitness"
#define kFoodAndDrink            @"FoodAndDrink"
#define kAttractionsAndLeisure   @"AttractionsAndLeisure"
#define kRetailAndServices       @"RetailAndServices"
#define kHotelsWorldwide         @"HotelsWorldwide"
#define kMoreSA                  @"SA"
#define kKids                    @"Kids"
#define kRetail                  @"Retail"


@implementation DDDeeplinkModel

+(NSMutableDictionary *)keyChanges {
    return @{
        @"o_id": @"outlet_id",
        @"m_id": @"merchant_id",
        @"search": @"query",
    }.mutableCopy;
}
-(NSString<Optional> *)category {
    return [self getCategoriesName:_category];
}
-(NSString<Optional> *)search_sub_category {
    return [self getCategoriesName:_search_sub_category];
}
-(NSString *)getCategoriesName:(NSString *)category {
    NSString *cat = category;
    if ([cat isEqualToString:kFoodAndDrink]) {
        return kOldFoodAndDrink;
    }
    if ([cat isEqualToString:kBeautyAndFitness]) {
        return kOldBeautyAndFitness;
    }
    if ([cat isEqualToString:kAttractionsAndLeisure]) {
        return kOldAttractionsAndLeisure;
    }
    if ([cat isEqualToString:kRetailAndServices]) {
        return kOldRetailAndServices;
    }
    if ([cat isEqualToString:kHotelsWorldwide]) {
        return kOldHotelsWorldwide;
    }
    return cat;
}
+(NSMutableDictionary *)commaToArraykeys {
    return @{
        @"cuisine_filter"               : @"cuisines",
        @"sub_category_filter"          : @"sub_categories",
        @"yes_filters"                  : @"merchant_attributes",
        @"offer_attributes"             : @"offer_attributes",
        @"offer_types"                  : @"offer_types",
        @"show_offers_of_type"          : @"show_offers_of_type",
        @"show_monthly_product_offers"  : @"show_monthly_product_offers",
    }.mutableCopy;
}


-(NSDictionary *)toDictionary {
    NSMutableDictionary *dict = self.all_params.mutableCopy;
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [dict addEntriesFromDictionary:[super toDictionary]];
    return dict;
}
-(NSMutableDictionary *)toApiDictionary {
    NSMutableDictionary *dict = [self toDictionary].mutableCopy;
    NSMutableDictionary *newDict = [self checkAndReplaceCommaToArrayAttributes:dict];
    newDict = [self checkAndReplaceKeys:newDict];
    return newDict;
}

-(NSMutableDictionary *)checkAndReplaceKeys:(NSDictionary *)dict {
    NSMutableDictionary *newDict = [NSMutableDictionary new];
    NSArray *allKeys = dict.allKeys;
    for (NSString *key in allKeys) {
        NSString *finalKey = key;
        id finalValue = dict[key];
        if ([[DDDeeplinkModel keyChanges].allKeys containsObject:key]) {
            NSString *newKey = [DDDeeplinkModel keyChanges][key];
            finalKey = newKey;
        }
        [newDict setObject:finalValue forKey:finalKey];
    }
    return newDict;
}

-(NSMutableDictionary *)checkAndReplaceCommaToArrayAttributes:(NSDictionary *)dict {
    NSMutableDictionary *newDict = [NSMutableDictionary new];
    for (NSString *key in dict.allKeys) {
        NSString *finalKey = key;
        id finalValue = dict[key];
        if ([[DDDeeplinkModel commaToArraykeys].allKeys containsObject:key]) {
            NSString *newKey = [DDDeeplinkModel commaToArraykeys][key];
            finalKey = newKey;
            NSString *finalStr = finalValue;
            NSArray *finalArray = [finalStr componentsSeparatedByString:@","];
            NSMutableArray *commaSeparatedArray = [NSMutableArray new];
            for(NSString * separatedStr in finalArray){
                if ([separatedStr stringByRemovingPercentEncoding]){
                    [commaSeparatedArray addObject:[separatedStr stringByRemovingPercentEncoding]];
                }
            }
            finalValue = commaSeparatedArray;
        }
        [newDict setObject:finalValue forKey:finalKey];
    }
    return newDict;
}

@end
