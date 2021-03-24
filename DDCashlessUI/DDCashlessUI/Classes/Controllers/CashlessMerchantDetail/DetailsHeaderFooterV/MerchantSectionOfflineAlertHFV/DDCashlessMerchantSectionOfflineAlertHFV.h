//
//  DDMerchantSectionOffersHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//


#import "DDCashlessMerchantBaseHFV.h"
NS_ASSUME_NONNULL_BEGIN


@interface DDCashlessMerchantSectionOfflineAlertHFV : DDCashlessMerchantBaseHFV
@property (weak, nonatomic) IBOutlet UILabel *lblSectionTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *outerViewHeightConstraint;

@end

NS_ASSUME_NONNULL_END
