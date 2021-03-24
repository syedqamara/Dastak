//
//  DDMerchantInfoTHFV.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/09/2020.
//

#import "DDBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantInfoTHFV : DDBaseHFV
@property (weak, nonatomic) IBOutlet UIView *bottomSpaceView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *sectionImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

NS_ASSUME_NONNULL_END
