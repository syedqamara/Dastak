//
//  DDMerchantDetailTblHeaderView.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 02/03/2020.
//

#import "DDUIBaseView.h"
#import <DDModels/DDModels.h>
#import "DDMerchantDetailTblHeaderViewModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface DDMerchantDetailTblHeaderView : DDUIBaseView

@property (weak, nonatomic) IBOutlet UICollectionView *heroImagesCollection;

@property (weak, nonatomic) IBOutlet UILabel *lblMerchantTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantCuisines;

@property (weak, nonatomic) IBOutlet UIView *ratingViewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblReviews;
@property (weak, nonatomic) IBOutlet UIButton *btnReviews;

@property (weak, nonatomic) IBOutlet UIView *gradientView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratingViewContainerHeight;
-(void)changeOverlayColorByAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
