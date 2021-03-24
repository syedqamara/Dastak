//
//  DDMunchMerchantDetailHeaderView.h
//  Munch
//
//  Created by Syed Qamar Abbas on 25/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDUI.h"
#import "DDHomeThemeManager.h"
#import "DDModels.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDMunchMerchantDetailHeaderViewDelegate <NSObject>

-(void)didTapInfoButton;
-(void)didTapFavouriteButton;

@end


@interface DDMunchMerchantDetailHeaderView : DDUIBaseView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (assign, nonatomic) CGFloat navHeight;
@property (weak, nonatomic) DDMerchantM *merchant;
@property (weak, nonatomic) id<DDMunchMerchantDetailHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
-(void)superScrollViewDidScroll:(UIScrollView *)scrollView;
-(void)updateSelectedLocationTitle;

@end

NS_ASSUME_NONNULL_END
