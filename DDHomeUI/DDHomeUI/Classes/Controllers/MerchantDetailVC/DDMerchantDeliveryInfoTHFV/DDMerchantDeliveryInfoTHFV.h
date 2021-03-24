//
//  DDMerchantDeliveryInfoTHFV.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 25/07/2020.
//

#import "DDBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantDeliveryInfoTHFV : DDBaseHFV
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryTimeLblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryTimeLblValue;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryMinOrderLblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryMinOrderLblValue;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryFeeLblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *deliveryFeeLblValue;



@end

NS_ASSUME_NONNULL_END
