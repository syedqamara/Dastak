//
//  DDAppboyEventManager.m
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 4/12/19.
//  Copyright © 2019 DDERTAINER. All rights reserved.
//

#import "DDAppboyEventManager.h"
#import <Appboy-iOS-SDK/Appboy.h>
//#import "DDHermesAppAnalytics.h"


#define AB_PARAM_TIMESTAMP @"Timestamp"
#define AB_PARAM_LASTSEARCH @"Last Search"

@implementation DDAppboyEventManager
+(DDAppboyEventManager *) sharedInstance {
    static DDAppboyEventManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DDAppboyEventManager alloc] init];
    });
    return _sharedInstance;
}
-(void)addEventWithTitle:(NSString *)title andParam:(NSDictionary * _Nullable)dictionary {
    [[Appboy sharedInstance] logCustomEvent:title withProperties:dictionary];
//    if (IS_HERMES_ENABLE) {
//        [DDHermesAppAnalytics.defaultAnalytics trackEvent:title parameter:dictionary];
//    }
}
-(void)visitFoodAndDrinkWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_FoodNDrink andParam:dictionary];
}
-(void)visitBeatyAndFitneesWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_BeautyNFitness andParam:dictionary];
}
-(void)visitProfileTapWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_ProfileTab andParam:dictionary];
}
-(void)didRecievePingWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_RecievePing andParam:dictionary];
}
-(void)visitDeliverySectionWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_DeliverySection andParam:dictionary];
}
-(void)didOrderedDeliveryWithParam:(NSDictionary * _Nullable)dictionary {
    [self addEventWithTitle:APPBOY_EVDD_OrderedDelivery andParam:dictionary];
}
-(void)didTypeOnSearchType:(NSString *)searchType withText:(NSString *)searchText withParam:(NSDictionary * _Nullable)param {
    if (searchText.length > 0) {
        NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]init];
        if (param != nil) {
            [paramDict addEntriesFromDictionary:param];
        }
        [paramDict setObject:searchText forKey:AB_PARAM_LASTSEARCH];
        NSDate *date = [NSDate date];
        NSDateFormatter *form = [NSDateFormatter new];
        form.dateFormat = @"HH:mm dd:MM:yyyy";
        NSString *dateStr = [form stringFromDate:date];
        if (dateStr != nil) {
            [paramDict setObject:dateStr forKey:AB_PARAM_TIMESTAMP];
        }
        [self addEventWithTitle:searchType andParam:paramDict];
    }
    
}

@end
