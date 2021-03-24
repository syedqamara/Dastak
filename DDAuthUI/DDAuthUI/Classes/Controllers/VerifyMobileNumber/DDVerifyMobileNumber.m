//
//  DDSignupVC.m
//  DDAuth
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDVerifyMobileNumber.h"
#import "NimbusKitAttributedLabel.h"
#import <DDConstants/DDConstants.h>
#import "DDAuthUIThemeManager.h"
#import "DDAuthUIManager.h"
#import "DDAuthUIConstants.h"
#import <DDCommons/DDCommons.h>

@interface DDVerifyMobileNumber ()<UITextFieldDelegate>{
    NSMutableArray <NSString *> *keyString;
    UIImage *editImage;
    NSMutableAttributedString *detailText;
}
@property (weak, nonatomic) IBOutlet DDGradientButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *resendCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenTitleLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *separators;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *keyContainers;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *keyLabels;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (strong, nonatomic, readonly) DDSignupRequestM *signup;
@end

@implementation DDVerifyMobileNumber
-(DDSignupRequestM *)signup {
    return (DDSignupRequestM *)self.navigation.routerModel.data;
}
-(NSString *)phoneNumber {
    return self.signup.completeMobileNumber;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyTextField.text = @"";
    self.submitButton.cornerR = 12;
    [self.submitButton setClipsToBounds:YES];
    
    [self addBackArrowNavigtaionItemWithtitle:@""];
    
    [self.keyTextField addTarget:self action:@selector(didChangeText) forControlEvents:(UIControlEventEditingChanged)];
}
-(void)didChangeText {
    keyString = [NSMutableArray.alloc init];
    for (int i = 0; i < [self.keyTextField.text length]; i++) {
        NSString *ch = [self.keyTextField.text substringWithRange:NSMakeRange(i, 1)];
        [keyString addObject:ch];
    }
    [self setSeparatorColor];
    if (keyString.count == 4) {
        [self sendCodeToServer];
    }
}
-(void)sendCodeToServer {
    self.signup.otp = [keyString componentsJoinedByString:@""];
    [DDAuthManager.shared verifyOTPWithRequestModel:self.signup WithCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (model.http_code.integerValue == 200) {
            DDUserManager.shared.currentUser.is_phone_verified = @(YES);
            DDUserManager.shared.currentUser.phone_number = self.signup.phone_number;
            DDUserManager.shared.currentUser = DDUserManager.shared.currentUser;
            [self dismissViewControllerAnimated:YES completion:^{
                [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
            }];
        }
        else if (model != nil){
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:model.message completion:nil];
        }
        else if (model != nil){
            [DDAlertUtils showOkAlertWithTitle:@"" subtitle:error.localizedDescription completion:nil];
        }
    }];
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([string isEqualToString:@""]) {
//        [keyString removeLastObject];
//    }else {
//        if (keyString.count == 4) {
//            [self.view endEditing:YES];
//        }else{
//            [keyString addObject:string];
//            if (keyString.count == 4) {
//                [self.view endEditing:YES];
//            }
//        }
//    }
//    
//    
//    return YES;
//}
//You must need to set the Color Themes Here
-(void)designUI {
    detailText = [NSMutableAttributedString.alloc init];
    editImage = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"edit.png"];
    editImage = [editImage setTintColor:DDUIThemeManager.shared.selected_theme.app_theme.colorValue];
    NSTextAttachment *attachment;
    if (@available(iOS 13.0, *)) {
        attachment = [NSTextAttachment textAttachmentWithImage:editImage];
    } else {
        attachment = [[NSTextAttachment alloc]init];
        attachment.image = editImage;
        // Fallback on earlier versions
    }
    [detailText appendAttributedString:[SEND_OTP_SCREEN_DETAIL attributedWithFont:[UIFont DDRegularFont:16] andColor:DDUIThemeManager.shared.selected_theme.text_black.colorValue]];
    [detailText appendAttributedString:[[self phoneNumber] attributedWithFont:[UIFont DDMediumFont:16] andColor:DDUIThemeManager.shared.selected_theme.app_theme.colorValue]];
    [detailText appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    self.resendCodeLabel.font = [UIFont DDRegularFont:13];
    self.submitButton.titleLabel.font = [UIFont DDBoldFont:17];
    [self.submitButton setTitleColor:THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [self.submitButton setTitle:VERIFY_NUMBER.localized forState:(UIControlStateNormal)];
    
    self.screenTitleLabel.font = [UIFont DDBoldFont:28];
    self.screenTitleLabel.textColor = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
    [self setSeparatorColor];
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(didTapOnDetail:)];
    gesture.numberOfTapsRequired = 1;
    [self.screenDetailLabel setUserInteractionEnabled:YES];
    [self.screenDetailLabel addGestureRecognizer:gesture];
    self.screenDetailLabel.attributedText = detailText;
    self.screenTitleLabel.text = [VERIFY_YOUR_NUMBER localized];
    self.screenDetailLabel.numberOfLines = 0;
}
-(void)didTapOnDetail:(UITapGestureRecognizer *)gesture {
    UILabel* label = (UILabel*)gesture.view;
    CGPoint tapLocation = [gesture locationInView:label];

    // create attributed string with paragraph style from label

    NSMutableAttributedString* attr = [label.attributedText mutableCopy];
    NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = label.textAlignment;

    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.attributedText.length)];

    // init text storage

    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attr];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];

    // init text container

    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(label.frame.size.width, label.frame.size.height+100) ];
    textContainer.lineFragmentPadding  = 0;
    textContainer.maximumNumberOfLines = label.numberOfLines;
    textContainer.lineBreakMode        = label.lineBreakMode;

    [layoutManager addTextContainer:textContainer];

    // find tapped character

    NSUInteger characterIndex = [layoutManager characterIndexForPoint:tapLocation
                                                      inTextContainer:textContainer
                             fractionOfDistanceBetweenInsertionPoints:NULL];

    // process link at tapped character

    [attr enumerateAttributesInRange:NSMakeRange(characterIndex, 1)
                                             options:0
                                          usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (range.location >= SEND_OTP_SCREEN_DETAIL.length) {
//            [[self phoneNumber] makeCall];
            [self goBackWithCompletion:nil];
        }
    }];
}
-(void)setSeparatorColor {
    for (NSInteger i = 0; i < self.separators.count; i++) {
        UIView *sep = self.separators[i];
        UILabel *lbl = self.keyLabels[i];
        if ((i + 1) <= keyString.count) {
            lbl.text = keyString[i];
            sep.backgroundColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
        }else {
            lbl.text = @"";
            sep.backgroundColor = DDUIThemeManager.shared.selected_theme.text_grey_238.colorValue;
        }
        lbl.font = [UIFont DDRegularFont:28];
        lbl.textColor = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Verify_Phone_Number andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
