//
//  DDBaseApiModel.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 08/01/2020.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDDeeplinkModel: JSONModel

@property (strong, nonatomic) NSString <Optional>*title;
@property (strong, nonatomic) NSString <Optional>*category;
@property (strong, nonatomic) NSString <Optional>*search_sub_category;
@property (strong, nonatomic) NSString <Optional>*query;

@property (strong, nonatomic) NSString <Optional>* m_id; // Merchant | Magento
@property (strong, nonatomic) NSString <Optional>* g_id; // Gift ID
@property (strong, nonatomic) NSString <Optional>* o_id; // Outlet | Order
@property (strong, nonatomic) NSString <Optional>* p_id; // Product ID
@property (strong, nonatomic) NSString <Optional>* s_id; // Section_id

@property (strong, nonatomic) NSString <Optional>* merchnat_id;
@property (strong, nonatomic) NSString <Optional>* gift_id;
@property (strong, nonatomic) NSString <Optional>* outlet_id;
@property (strong, nonatomic) NSString <Optional>* product_id;
@property (strong, nonatomic) NSString <Optional>* section_id;
@property (strong, nonatomic) NSString <Optional>* order_id;

@property (strong, nonatomic) NSString <Optional>* country;
@property (strong, nonatomic) NSString <Optional>* code;
@property (strong, nonatomic) NSString <Optional>* search;

@property (strong, nonatomic) NSString <Optional>* cashless_delivery_enabled;
@property (strong, nonatomic) NSString <Optional>* is_last_mile_enabled;
@property (strong, nonatomic) NSString <Optional>* is_take_away;
@property (strong, nonatomic) NSString <Optional>* videoId;

//Filter Search Params
@property (strong, nonatomic) NSString <Optional>* cuisine_filter;
@property (strong, nonatomic) NSString <Optional>* sub_category_filter;
@property (strong, nonatomic) NSString <Optional>* yes_filters;
@property (strong, nonatomic) NSString <Optional>* offer_attributes;
@property (strong, nonatomic) NSString <Optional>* offer_types;
@property (strong, nonatomic) NSString <Optional>* show_offers_of_type;
@property (strong, nonatomic) NSString <Optional>* show_monthly_product_offers;









@property (strong, nonatomic) NSDictionary <Optional>* c_p;

@property (strong, nonatomic) NSString <Ignore>* host;
@property (strong, nonatomic) NSMutableDictionary <Ignore>* all_params;

-(NSMutableDictionary *)toApiDictionary;

@end

NS_ASSUME_NONNULL_END
