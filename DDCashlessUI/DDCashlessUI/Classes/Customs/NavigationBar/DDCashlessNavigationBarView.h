//
//  DDCashlessNavigationBarView.h
//  DDCashlessUI
//
//  Created by Syed Qamar Abbas on 09/03/2020.
//

#import "DDUIBaseView.h"
#import <DDModels/DDModels.h>
#import <DDLocationsUI/DDLocationsUI.h>
#import "DDCashlessThemeManager.h"
#import <DDCommons/DDCommons.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessNavigationBarView : DDUIBaseView
@property (unsafe_unretained, nonatomic) IBOutlet UIView *containerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *backButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *optionsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *selectedTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;
-(void)hideOptionButton:(BOOL)hide;
@end

NS_ASSUME_NONNULL_END
