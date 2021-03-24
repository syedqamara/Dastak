//
//  DDMerchantSectionOnlineOffersHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//


#import "DDMerchantBaseHFV.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantSectionOnlineOffersHFV : DDMerchantBaseHFV
@property (weak, nonatomic) IBOutlet UILabel *lblSectionTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSeeAll;
@property (weak, nonatomic) IBOutlet UIView *liveView;
@property (nonatomic, copy) void (^callBackSeeAll)(void);
@end

NS_ASSUME_NONNULL_END
