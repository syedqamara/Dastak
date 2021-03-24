//
//  DDOfferItemTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDOutletsUIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDOfferItemTVCDelegate  <NSObject>

@end

@interface DDOfferItemTVC : DDBaseTVC

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIImageView *lockIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *lblOfferTitle;
@property (nonatomic, weak) IBOutlet UICollectionView *daysValidityCollection;
@property (nonatomic, weak) IBOutlet UILabel *attributesCollectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *lblOfferDetail;
@property (nonatomic, weak) IBOutlet UILabel *lblTagInfo;

@property (nonatomic, weak) IBOutlet UILabel *lblBuyBackMessage;
@property (nonatomic, weak) IBOutlet UILabel *lblBuyBackSmilesRequired;
@property (nonatomic, weak) IBOutlet UIImageView *imgBuyBackView;
@property (nonatomic, weak) IBOutlet UIView *buyBackContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyBackContainerViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyBackContainerTop;

@property (nonatomic, weak) IBOutlet UIView *lockIconContainerView;
@property (nonatomic, weak) IBOutlet UIView *topLockedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysValidityCollectionHeight;


@end

NS_ASSUME_NONNULL_END
