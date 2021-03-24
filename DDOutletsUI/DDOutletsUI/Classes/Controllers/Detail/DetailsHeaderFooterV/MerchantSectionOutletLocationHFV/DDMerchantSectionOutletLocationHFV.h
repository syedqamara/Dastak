//
//  DDMerchantSectionOutletLocationHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDMerchantBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantSectionOutletLocationHFVDelegate <NSObject>
-(void)didTapAreYouHereButton;
@end

@interface DDMerchantSectionOutletLocationHFV : DDMerchantBaseHFV

@property (weak, nonatomic) id<DDMerchantSectionOutletLocationHFVDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblOutletLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnAreYouHere;
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

NS_ASSUME_NONNULL_END
