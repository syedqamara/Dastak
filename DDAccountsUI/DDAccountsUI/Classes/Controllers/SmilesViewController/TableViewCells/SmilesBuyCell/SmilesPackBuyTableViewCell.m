//
//  SmilesPackBuyTableViewCell.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 20/03/2020.
//

#import "SmilesPackBuyTableViewCell.h"
#import "DDAccountUIThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDAccountManager.h"

@implementation SmilesPackBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)designUI{
    [super designUI];
    self.pointsLabel.font = [UIFont DDBoldFont:13];
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.descriptionLabel.font = [UIFont DDRegularFont:15];
    self.buyButton.titleLabel.font = [UIFont DDMediumFont:15];
    
    self.pointsLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_white.colorValue;
    self.titleLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.descriptionLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    
    [self.buyButton setTitleColor:[DDAccountUIThemeManager shared].selected_theme.text_white.colorValue forState:UIControlStateNormal];
    
    self.pointsView.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.app_smiles_color.colorValue;
    self.buyButton.backgroundColor = [DDAccountUIThemeManager shared].selected_theme.app_theme.colorValue;
    
    self.pointsImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icBuyBack.png"];
    self.containerView.layer.cornerRadius = 12;
    self.containerView.clipsToBounds = YES;
    self.containerView.layer.borderColor = [DDAccountUIThemeManager shared].selected_theme.bg_grey_199.colorValue.CGColor;
    self.containerView.layer.borderWidth = 1;
    
    self.pointsImageView.superview.layer.cornerRadius = 10;
    self.pointsImageView.superview.clipsToBounds = YES;
    self.pointsImageView.superview.layer.borderColor = [DDAccountUIThemeManager shared].selected_theme.app_smiles_color.colorValue.CGColor;
    self.pointsImageView.superview.layer.borderWidth = 1;
    
    self.buyButton.layer.cornerRadius = 9;
    self.buyButton.clipsToBounds = YES;
    
}
- (void)setData:(id)data{
    [super setData:data];
    PSSmiles *smileInfo = (PSSmiles*)data;
    self.titleLabel.text = smileInfo.reward_name;
    self.descriptionLabel.text = smileInfo.smile_desc;
    self.pointsLabel.text = [NSString stringWithFormat:@" %@",smileInfo.smile_points];
    if(smileInfo.show_buy_button && [smileInfo.show_buy_button boolValue] && ([[DDUserManager shared] isMember] || [[DDUserManager shared] isSecondary])){
        [self.buyButton setHidden:NO];
    } else {
        [self.buyButton setHidden:YES];
    }
    [self.buyButton setTitle:@"BUY NOW".localized forState:UIControlStateNormal];
    
}
@end
