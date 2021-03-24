//
//  DDOrderTotalTHFV.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 01/08/2020.
//

#import "DDBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderTotalTHFV : DDBaseHFV
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtotalTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtotalValueLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryValueLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *discountTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *discountValueLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalValueLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *separatorViews;

@end

NS_ASSUME_NONNULL_END
