//
//  DDDriverInfoTHFV.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 18/10/2020.
//

#import "DDBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDDriverInfoTHFV : DDBaseHFV
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *driverNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *driverImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorView;

@end

NS_ASSUME_NONNULL_END
