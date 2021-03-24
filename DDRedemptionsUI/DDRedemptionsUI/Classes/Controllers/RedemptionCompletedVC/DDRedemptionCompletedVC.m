//
//  DDRedemptionCompletedVC.m
//  DDRedemptionsUI
//
//  Created by Umair on 19/04/2020.
//

#import "DDRedemptionCompletedVC.h"
#import "DDRedemptionsThemeManager.h"

@interface DDRedemptionCompletedVC ()
{
    DDMerchantOffersLocalDataM *data;
}
@property (weak, nonatomic) IBOutlet UILabel *offerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *redemptionCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *redemptionCompleted;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;


@end

@implementation DDRedemptionCompletedVC

- (void)viewDidLoad {
    [super viewDidLoad];
     data = (DDMerchantOffersLocalDataM *)self.navigation.routerModel.data;
    [self seUIData];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return self;
}
-(UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

-(void)seUIData {
    self.offerTitleLbl.text = @"";
    self.redemptionCodeLbl.text = @"";
    self.offerTitleLbl.text = data.offerToDisplay.name;
    self.redemptionCodeLbl.text = data.offerToDisplay.redemptionCode;
}

-(void)designUI{
    self.offerTitleLbl.font = [UIFont DDMediumFont:17];
    self.offerTitleLbl.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.redemptionCodeLbl.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.redemptionCodeLbl.font = [UIFont DDBoldFont:34];
    
    self.redemptionCompleted.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.redemptionCompleted.text = @"Redemption completed".localized;
    self.redemptionCompleted.font = [UIFont DDBoldFont:20];
    
    self.doneBtn.titleLabel.font = [UIFont DDMediumFont:15];
    [self.doneBtn setTitle:@"Done".localized forState:UIControlStateNormal];
    self.doneBtn.backgroundColor = DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
}

- (IBAction)doneBtnAction:(id)sender {
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:@"Done" withData:nil withController:self];
    }];
}


@end
