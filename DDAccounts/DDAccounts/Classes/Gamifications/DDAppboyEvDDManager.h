//
//  DDAppboyEventManager.h
//  The Entertainer
//
//  Created by Syed Qamar Abbas on 4/12/19.
//  Copyright © 2019 DDERTAINER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#define APPBOY_EVDD_FoodNDrink @"visited food and drink"
#define APPBOY_EVDD_BeautyNFitness @"visited beauty and fitness"
#define APPBOY_EVDD_ProfileTab @"visited profile tab"
#define APPBOY_EVDD_RecievePing @"receive ping"
#define APPBOY_EVDD_DeliverySection @"opened delivery listing"
#define APPBOY_EVDD_OrderedDelivery @"ordered Delivery"

@interface DDAppboyEventManager : NSObject
+(DDAppboyEventManager *) sharedInstance;
-(void)addEventWithTitle:(NSString *)title andParam:(NSDictionary * _Nullable)dictionary;
-(void)visitFoodAndDrinkWithParam:(NSDictionary * _Nullable)dictionary;
-(void)visitBeatyAndFitneesWithParam:(NSDictionary * _Nullable)dictionary;
-(void)visitProfileTapWithParam:(NSDictionary * _Nullable)dictionary;
-(void)didRecievePingWithParam:(NSDictionary * _Nullable)dictionary;
-(void)visitDeliverySectionWithParam:(NSDictionary * _Nullable)dictionary;
-(void)didOrderedDeliveryWithParam:(NSDictionary * _Nullable)dictionary;
-(void)didTypeOnSearchType:(NSString *)searchType withText:(NSString *)searchText withParam:(NSDictionary * _Nullable)param;
@end

NS_ASSUME_NONNULL_END
