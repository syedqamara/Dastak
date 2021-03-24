//
//  DDMerchantSectionManusHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantBaseHFV.h"
#import "DDOutletsThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDMerchantMenuItemCVC.h"
#import "DDOutletsUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantSectionManusHFVDelegate <NSObject>
-(void)didTapMenuItem : (DDMerchantMenuButtonM*)button;
@end

@interface DDMerchantSectionManusHFV : DDMerchantBaseHFV

@property (weak, nonatomic) id<DDMerchantSectionManusHFVDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

NS_ASSUME_NONNULL_END
