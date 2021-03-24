//
//  DDAddCustomisationTHFV.h
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDBaseHFV.h"
#import "DDMerchantMenuItemCustomizationM.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDAddCustomisationTHFVDelegate <NSObject>

-(void)didTapExpandCollapseButtonWithCust:(DDMerchantMenuItemCustomizationM *)cust;

@end

@interface DDAddCustomisationTHFV : DDBaseHFV
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) id<DDAddCustomisationTHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
