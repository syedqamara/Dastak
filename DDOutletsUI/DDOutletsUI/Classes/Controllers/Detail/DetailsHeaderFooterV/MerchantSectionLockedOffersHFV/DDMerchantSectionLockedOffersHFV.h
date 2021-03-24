//
//  DDMerchantSectionLockedOffersHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantSectionLockedOffersHFV : DDMerchantBaseHFV

@property (nonatomic, copy) void (^callBackShowAllLlockeOffers)(void);

@end

NS_ASSUME_NONNULL_END
