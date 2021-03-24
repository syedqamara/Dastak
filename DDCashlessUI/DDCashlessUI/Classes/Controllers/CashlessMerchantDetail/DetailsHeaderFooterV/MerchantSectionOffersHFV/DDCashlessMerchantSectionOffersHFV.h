//
//  DDMerchantSectionOffersHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//


#import "DDCashlessMerchantBaseHFV.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessMerchantSectionOffersHFVDelegate <NSObject>
-(void)didTapExpandCollapsButtonFromOfferAtSection:(NSInteger)section;
@end

@interface DDCashlessMerchantSectionOffersHFV : DDCashlessMerchantBaseHFV
@property (weak, nonatomic) id<DDCashlessMerchantSectionOffersHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
