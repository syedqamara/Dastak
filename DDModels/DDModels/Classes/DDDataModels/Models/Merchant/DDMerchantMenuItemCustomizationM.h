//
//  DDMerchantMenuItemCustomizationM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDBaseModel.h"
#import "DDMerchantMenuItemCustomizationOptionM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantMenuItemCustomizationM : DDBaseModel
@property (strong,nonatomic) NSNumber <Optional> *cust_id;
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSString <Optional> *sub_title;
@property (strong,nonatomic) NSNumber <Optional> *min_selected_count;
@property (strong,nonatomic) NSNumber <Optional> *max_selected_count;
@property (strong,nonatomic) NSNumber <Optional> *is_single_selection;
@property (strong,nonatomic) NSArray <DDMerchantMenuItemCustomizationOptionM, Optional> *options;
@property (strong,nonatomic) NSNumber <Optional> *is_opened;

-(BOOL)isOpened;
-(BOOL)allowSingleSelection;
-(void)resetAllSelection;
-(void)toggle;
-(void)select:(DDMerchantMenuItemCustomizationOptionM *)option;
-(BOOL)isMinSelected;
-(BOOL)isAllowedToEnterMore;
@end

NS_ASSUME_NONNULL_END
