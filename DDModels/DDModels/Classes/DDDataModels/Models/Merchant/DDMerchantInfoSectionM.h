//
//  DDMerchantInfoSectionM.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 22/07/2020.
//

#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantInfoSectionM : DDBaseModel
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSString <Optional> *sub_title;
@property (strong,nonatomic) NSString <Optional> *identifier;
@property (strong,nonatomic) NSString <Optional> *image_url;
@property (strong,nonatomic) NSArray <DDMerchantInfoSectionListM,Optional> *list;
@end

NS_ASSUME_NONNULL_END
