//
//  DDCashlessMerchantDetailTblHeaderViewModel.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 13/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessMerchantDetailTblHeaderViewModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> * is_deliveryView;
@property (nonatomic, strong) DDOutletM<Optional> * outlet;
@property (nonatomic, strong) DDMerchantDetailM<Optional> * merchant;


-(NSString *) cuisinesAndSubCategoriesWithDot;

@end

NS_ASSUME_NONNULL_END
