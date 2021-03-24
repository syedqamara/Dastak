//
//  DDMerchantDetailOutletLocationTVC.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 19/03/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantDetailOutletLocationTVC : DDBaseTVC

@property (unsafe_unretained, nonatomic) IBOutlet UIView *sepratorView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *locationTitle_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *locationDescription_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *distance_label;

@end

NS_ASSUME_NONNULL_END
