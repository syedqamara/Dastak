//
//  DDPersonalDetails.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 25/07/2020.
//

#import "DDUIBaseViewController.h"
#import "ACFloatingTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDPersonalDetails : DDUIBaseViewController
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *emailCrossBtn;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *emailTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *emailLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *emailInfoLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *firstNameCrossBtn;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *firstNameTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *firstNameLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *firstNameInfoLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *lastNameCrossBtn;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *lastNameTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *lastNameLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lastNameInfoLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *phoneNumCrossBtn;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *phoneNumTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *phoneNumLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *phoneNumInfoLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *dobCrossBtn;
@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *dobTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *dobLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dobInfoLabel;
@end

NS_ASSUME_NONNULL_END
