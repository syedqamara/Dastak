//
//  FeedbackViewController.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 14/02/2020.
//

#import "FeedbackViewController.h"
#import "DDAccountUIThemeManager.h"
#import <DDCommons/DDCommons.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <DDAccounts/DDAccounts.h>
#import <DDUI/DDUI.h>

@interface FeedbackViewController ()<UITextViewDelegate>
@property(nonatomic) IBOutlet UILabel* messageLabel;
@property(nonatomic) IBOutlet IQTextView* textView;
@property(nonatomic) IBOutlet UIView* seperatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstreaint;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"App Feedback".localized;
    self.textView.delegate = self;
}
-(void)designUI{
    
    self.textView.textContainer.heightTracksTextView = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] ,NSFontAttributeName : [UIFont DDBoldFont:17]};

    self.messageLabel.text = @"We want to hear what you think we can do much better".localized ;
    self.messageLabel.font = [UIFont DDBoldFont:16];
    self.messageLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.bg_black.colorValue;

    self.textView.font = [UIFont DDRegularFont:17];
    
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"Review".localized];
    [attributedPlaceholder addAttribute:NSForegroundColorAttributeName value:[DDAccountUIThemeManager shared].selected_theme.bg_grey_199.colorValue ?: [UIColor lightGrayColor]   forString:attributedPlaceholder.string];
    [attributedPlaceholder addAttribute:NSFontAttributeName value: [UIFont DDRegularFont:17]   forString:attributedPlaceholder.string];

    self.textView.placeHolder = NO;
    self.textView.attributedPlaceholder = attributedPlaceholder;
    
    self.textView.textColor = [DDAccountUIThemeManager shared].selected_theme.bg_black.colorValue;
    
    self.seperatorView.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.bg_grey_199.colorValue;

    [self addNavigationItemWithTitle:SUBMIT.localized identifier:SUBMIT tintColor:DDAccountUIThemeManager.shared.selected_theme.text_white.colorValue direction:DDNavigationItemDirectionRight];

}
- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:SUBMIT]) {
        [self submitFeedBack];
    }else{
        [self goBackWithCompletion:nil];
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    CGSize size  = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, 200)];
    CGFloat height = size.height < 42 ? 42 :  MIN(200, size.height);
    dispatch_async(dispatch_get_main_queue(), ^{
   
        self.textViewHeightConstreaint.constant = height;
        self.textView.scrollEnabled = height == 200;
    });
}
-(void)submitFeedBack{
    NSString *text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (text == nil || text.length == 0) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[DDAccountManager shared] submitFeedback:@{@"source":@"feedback",@"feedback":text} completion:^(DDResponseMessageApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
        }else{
            
            if (model.data.is_saved.boolValue) {
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.data.message completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                DDSEAPIError *e = [NSError errorWithDDSEAPIError:error];
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:e.localizedDescription completion:nil];
            }
            
        }
    }];
}
+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *settings = [[DDUIRouterM alloc]init];
    settings.route_link = DD_Nav_Accounts_Feedback;
    settings.should_embed_in_nav = NO;
    settings.transition = DDUITransitionPush;
    settings.is_animated = YES;
    return @[settings];
}
@end
