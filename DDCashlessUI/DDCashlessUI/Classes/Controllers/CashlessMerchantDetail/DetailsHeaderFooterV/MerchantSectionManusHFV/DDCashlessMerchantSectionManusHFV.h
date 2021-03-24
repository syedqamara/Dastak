//
//  DDMerchantSectionManusHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantBaseHFV.h"
#import "DDCashlessThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDCashlessMerchantMenuItemCVC.h"
#import "DDCashlessUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessMerchantSectionManusHFVDelegate <NSObject>
-(void)didTapMenuItem : (DDMerchantMenuButtonM*)button;
@end

@interface DDCashlessMerchantSectionManusHFV : DDCashlessMerchantBaseHFV

@property (weak, nonatomic) id<DDCashlessMerchantSectionManusHFVDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

NS_ASSUME_NONNULL_END
