//
//  DDStarRatingVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 10/09/2020.
//

#import "DDStarRatingVC.h"
#import "HCSStarRatingView.h"
#import "DDUI.h"
#import "DDHomeThemeManager.h"
#import "DDHomeManager.h"
@interface DDStarRatingVC ()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *feedbackQuestion;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *feedbackInformation;

@property (unsafe_unretained, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (unsafe_unretained, nonatomic) IBOutlet DDGradientButton *submitButton;

@property (unsafe_unretained, nonatomic) IBOutlet ACFloatingTextField *additionCommentTF;
@property (readonly, nonatomic) DDRatingRM *rating;
@end

@implementation DDStarRatingVC
-(DDRatingRM *)rating {
    return self.navigation.routerModel.data;
}
-(instancetype)initWithNibName:(NSString *)name forClass:(Class)cls {
    self = [super initWithNibName:name forClass:cls];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return self;
}
-(void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    [super setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
    // Do any additional setup after loading the view from its nib.
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDRegularFont:14];
    self.subtitleLabel.font = [UIFont DDSemiBoldFont:20];
    self.feedbackQuestion.font = [UIFont DDSemiBoldFont:15];
    self.feedbackInformation.font = [UIFont DDRegularFont:14];
    self.additionCommentTF.font = [UIFont DDRegularFont:15];
    self.submitButton.titleLabel.font = [UIFont DDSemiBoldFont:17];
    
    self.titleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.subtitleLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.feedbackQuestion.textColor = HOME_THEME.text_black_40.colorValue;
    self.feedbackInformation.textColor = HOME_THEME.text_grey_111.colorValue;
    self.additionCommentTF.textColor = HOME_THEME.text_black_40.colorValue;
    [self.submitButton setTitleColor:HOME_THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [self.submitButton addTarget:self action:@selector(didTapSubmitButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.submitButton setTitle:@"Submit".localized forState:(UIControlStateNormal)];
    self.titleLabel.text = @"Rate your experience".localized;
    self.subtitleLabel.text = self.rating.merchant_name;
    self.feedbackQuestion.text = @"How is your experience?".localized;
    self.feedbackInformation.text = @"Your feedback will help improve\nservices experience".localized;
    self.additionCommentTF.placeholder = @"Additional comments".localized;
    
    [self.ratingView setEmptyStarColor:@"dddddd".colorValue];
    [self.ratingView setStarBorderColor:HOME_THEME.app_theme.colorValue];
    [self.ratingView setTintColor:HOME_THEME.app_theme.colorValue];
    
    [self.submitButton.layer setCornerRadius:12];
    [self.submitButton.superview.superview.superview.layer setCornerRadius:16];
    [self.submitButton.superview.superview.superview setClipsToBounds:YES];
    [self.submitButton setClipsToBounds:YES];
}
-(void)didTapSubmitButton {
    self.rating.rating = @(self.ratingView.value);
    self.rating.additional_comment = self.additionCommentTF.text;
    
    [DDHomeManager.shared rating:self.rating showHUD:YES onCompletion:^(DDBaseApiModel * _Nullable model, NSError * _Nullable error) {
        if (model.successfulApi) {
            [self goBackWithCompletion:nil];
        }
    }];
    
}
- (IBAction)didTapBackBtn:(id)sender {
    [self goBackWithCompletion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Order_Rating andModuleName:@"DDHomeUI" withClassRef:self];
}
@end
