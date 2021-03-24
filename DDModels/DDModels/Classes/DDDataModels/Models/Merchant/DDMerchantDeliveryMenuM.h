//
//  DDMerchantDeliveryMenuM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDBaseModel.h"
#import "DDMerchantDeliveryMenuItemM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantDeliveryMenuM : DDBaseModel
@property (strong,nonatomic) NSNumber <Optional> *menu_id;
@property (strong,nonatomic) NSString <Optional> *name;
@property (strong,nonatomic) NSArray <DDMerchantDeliveryMenuItemM, Optional> *items;



@end

NS_ASSUME_NONNULL_END
