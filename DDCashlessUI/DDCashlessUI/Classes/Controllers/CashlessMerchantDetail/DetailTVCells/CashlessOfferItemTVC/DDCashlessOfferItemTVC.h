//
//  DDOfferItemTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDCashlessUIManager.h"
#import "DDCashlessMerchantOffersCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOfferItemTVCDelegate  <NSObject>

@end

@interface DDCashlessOfferItemTVC : DDBaseTVC

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIImageView *lockIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *lblOfferTitle;
@property (nonatomic, weak) IBOutlet UICollectionView *daysValidityCollection;
@property (nonatomic, weak) IBOutlet UICollectionView *attributesCollection;
@property (nonatomic, weak) IBOutlet UILabel *lblOfferDetail;
@property (nonatomic, weak) IBOutlet UILabel *lblTagInfo;

@property (nonatomic, weak) IBOutlet UILabel *lblBuyBackMessage;
@property (nonatomic, weak) IBOutlet UILabel *lblBuyBackSmilesRequired;
@property (nonatomic, weak) IBOutlet UIImageView *imgBuyBackView;
@property (nonatomic, weak) IBOutlet UIView *buyBackContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyBackContainerViewWidth;

@property (nonatomic, weak) IBOutlet UIView *lockIconContainerView;
@property (nonatomic, weak) IBOutlet UIView *topLockedView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysValidityCollectionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attributesCollectionHeight;


@end

NS_ASSUME_NONNULL_END
