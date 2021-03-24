//
//  DDMerchantSectionManusHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantBaseHFV.h"
#import "DDCashlessThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDCashlessDeliveryInfoCVC.h"
#import "DDCashlessUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessMerchantDeliveryInfoHFV : DDCashlessMerchantBaseHFV

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

NS_ASSUME_NONNULL_END
