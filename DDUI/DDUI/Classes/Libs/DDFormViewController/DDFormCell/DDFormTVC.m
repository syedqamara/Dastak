//
//  DDFormTVC.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDFormTVC.h"
#import "DDFormM.h"
#import "DDUIThemeManager.h"
@implementation DDFormTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.textField.textColor = THEME.text_black_40.colorValue;
    self.textField.placeHolderColor = THEME.bg_grey_199.colorValue;
    self.textField.labelPlaceholder.font = [UIFont DDRegularFont:12];
    self.textField.font = [UIFont DDRegularFont:15];
    self.separatorView.backgroundColor = THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDTextFormM *form = data;
    self.textField.placeholder = form.title;
    [self.imageView loadImageWithString:form.image forClass:self.class];
    self.textField.text = form.value;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
