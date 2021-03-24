//
//  DDCashlessNavBaseVC.h
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 21/04/2020.
//

#import "DDCashlessBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessNavBaseVC : DDCashlessBaseVC
@property (weak, nonatomic) DDCashlessNavigationBarView * _Nullable navigationBar;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *navigationView;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *navigationBarHeightConstraint;
-(void)showMoreButton;
-(BOOL)shouldLoadNavigationBar;
-(BOOL)shouldHideOptionButton;
-(void)didTapOptionsButton;
-(void)deliveryLocationChanged;
-(void)hideNavBarWithDuration:(NSTimeInterval)duration;
-(void)showNavBarWithDuration:(NSTimeInterval)duration;
-(void)didTapSelectDeliveryLocation;
@property (strong, nonatomic) DDOutletM *outlet;
@property (strong, nonatomic) DDCashlessMerchantM *merchant;
@end

NS_ASSUME_NONNULL_END
