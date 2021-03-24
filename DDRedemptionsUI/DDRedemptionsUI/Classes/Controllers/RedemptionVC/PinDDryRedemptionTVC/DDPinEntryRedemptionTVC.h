//
//  DDPinEntryRedemptionTVC.h
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 13/03/2020.
//

#import "DDRedemptionBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPinEntryRedemptionTVC : DDRedemptionBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *pinEntryLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSString *code;

@end

NS_ASSUME_NONNULL_END
