//
//  DDProfileFamilyTVC.m
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDProfileFamilyTVC.h"
#import "DDAccountUIThemeManager.h"

@implementation DDProfileFamilyTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.nameLabel.font = [UIFont DDMediumFont:17];
    self.nameLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.savingsLabel.font = [UIFont DDRegularFont:15];
    self.savingsLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.app_theme.colorValue;
    self.seperatorView.backgroundColor = DDAccountUIThemeManager.shared.selected_theme.separator_grey_227.colorValue;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(id)data{
    [super setData:data];
    DDFriend *item = (DDFriend*)data;
    
//    self.nameLabel.placeHolder = item.name;
//    self.savingsLabel.placeHolder = item.formattedSavings;
//    self.memberImageView.superview.placeHolder = [item isDummy];
    
    self.nameLabel.text = item.name;
    self.savingsLabel.text = item.formattedSavings;
    
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icDefaultPhoto"];
    [self.memberImageView loadImageWithString:item.profile_image withPlaceHolderImage:placeHolder forClass:self.class];
}

-(void)setFriendImage {
    
}
@end
