//
//  DDMerchantSectionManusHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantBaseHFV.h"
#import "DDCashlessThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDCashlessUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDReorderInfoHFVDelegate <NSObject>
-(void)didTapReorderButtonForOrder:(DDOrderM *)order;
@end

@interface DDReorderInfoHFV : DDCashlessMerchantBaseHFV
@property (assign, nonatomic) NSInteger section;
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (weak, nonatomic) id<DDReorderInfoHFVDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
