//
//  DDCashlessMerchantDetailTblHeaderView.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 02/03/2020.
//

#import "DDUIBaseView.h"
#import <DDModels/DDModels.h>
#import "DDCashlessMerchantDetailTblHeaderViewModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface DDCashlessMerchantDetailTblHeaderView : DDUIBaseView

@property (weak, nonatomic) IBOutlet UICollectionView *heroImagesCollection;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UILabel *lblMerchantTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantCuisines;

@property (weak, nonatomic) IBOutlet UIView *ratingViewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblReviews;
@property (weak, nonatomic) IBOutlet UIButton *btnReviews;

@property (weak, nonatomic) IBOutlet UIView *gradientView;


-(void)changeOverlayColorByAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
