//
//  DDCashlessMerchantOffersCellViewModel.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 17/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessMerchantOffersCellViewModel : JSONModel

@property (nonatomic, strong) DDOutletM<Optional> * selectedOutlet;
@property (nonatomic, strong) DDMerchantDetailM<Optional> * merchant;
@property (nonatomic, strong) DDMerchantOfferToDisplay<Optional> *offerToDisplay;
@property (nonatomic, strong) DDMerchantOfferM<Optional> *offerSection;
@property (nonatomic, strong) DDMerchantDetailSectionM<Optional> *section;
@end

NS_ASSUME_NONNULL_END
