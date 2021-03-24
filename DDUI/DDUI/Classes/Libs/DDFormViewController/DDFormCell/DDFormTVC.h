//
//  DDFormTVC.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDBaseTVC.h"
#import "ACFloatingTextField.h"
NS_ASSUME_NONNULL_BEGIN



@interface DDFormTVC : DDBaseTVC

@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorView;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *textField;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *formTypeImageView;

@end

NS_ASSUME_NONNULL_END
