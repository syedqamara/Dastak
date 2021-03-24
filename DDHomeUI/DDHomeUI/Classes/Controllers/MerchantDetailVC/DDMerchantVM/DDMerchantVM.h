//
//  DDMerchantVM.h
//  dynamicdelivery
//
//  Created by Syed Qamar Abbas on 26/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDModels.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DDMerchantDetailSectionType) {
    DDMerchantDetailSectionTypeInfo,
    DDMerchantDetailSectionTypeMenu,
    DDMerchantDetailSectionTypeRating,
};

@interface DDMerchantVM : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *viewButtonTitle;

@property (strong, nonatomic) DDMerchantM *merchant;
@property (strong, nonatomic) DDMerchantDeliveryMenuM *selectedMenu;
@property (assign, nonatomic) DDMerchantDetailSectionType type;
-(BOOL)haveImage;
-(BOOL)haveViewButton;
-(NSInteger)selectedIndex;
+(DDMerchantVM *)vmWithType:(DDMerchantDetailSectionType)type andMerchant:(DDMerchantM *)merchant;
@end

NS_ASSUME_NONNULL_END
