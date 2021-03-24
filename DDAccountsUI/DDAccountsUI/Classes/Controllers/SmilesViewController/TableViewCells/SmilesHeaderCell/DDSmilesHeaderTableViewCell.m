//
//  DDSmilesHeaderTableViewCell.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 20/03/2020.
//

#import "DDSmilesHeaderTableViewCell.h"
#import "DDAccountUIThemeManager.h"
#import <DDModels/DDModels.h>
#import "DDAccountManager.h"

@implementation DDSmilesHeaderTableViewCell

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
    self.currentSmilesCountLbl.font = [UIFont DDBoldFont:53];
    self.expiredSmilesCountLbl.font = [UIFont DDLightFont:11];
    self.currentSmilesCountLblTitle.font = [UIFont DDBoldFont:15];
    self.messsageLabel.font = [UIFont DDMediumFont:17];
    
    self.currentSmilesCountLbl.textColor = [DDAccountUIThemeManager shared].selected_theme.app_smiles_color.colorValue;
    self.expiredSmilesCountLbl.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.currentSmilesCountLblTitle.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.messsageLabel.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
}
- (void)setData:(id)data{
    [super setData:data];
    PSSmilesData *smilesData = (PSSmilesData*)data;
    self.currentSmilesCountLbl.text = smilesData.current_smiles.stringValue;
    self.currentSmilesCountLblTitle.text = @"TOTAL SMILES".localized;
    self.messsageLabel.text = [NSString stringWithFormat:@"%@",@"Turn your smiles into even more savings:".localized];

    
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    [nf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    
    NSString *expire =  [NSString stringWithFormat:@"%@ ",@"Expiring this month:".localized];
    
    NSMutableAttributedString *cousine = [[NSMutableAttributedString alloc] initWithString:expire];
 
    [cousine addAttribute:NSFontAttributeName value:[UIFont DDRegularFont:11] forString:cousine.string];

    [cousine appendAttributedString:[[NSString stringWithFormat:@"%@",[nf stringFromNumber:smilesData.expired_smiles]] addAttribute:NSFontAttributeName value:[UIFont DDMediumFont:11]]];
   
    self.expiredSmilesCountLbl.attributedText = cousine;

    
    
}

@end
