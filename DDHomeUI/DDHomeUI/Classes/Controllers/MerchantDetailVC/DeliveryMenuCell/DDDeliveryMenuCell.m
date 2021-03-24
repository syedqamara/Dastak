//
//  DDDeliveryMenuCell.m
//  The dynamicdelivery
//
//  Created by mac on 3/30/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDDeliveryMenuCell.h"
#import "DDHomeThemeManager.h"
@interface DDDeliveryMenuCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation DDDeliveryMenuCell

-(void)setIsMenuSelected:(BOOL)isMenuSelected {
    _bottomView.backgroundColor = HOME_THEME.app_theme.colorValue;
    [_bottomView setHidden:!isMenuSelected];
    if (isMenuSelected) {
        _titleLabel.font = [UIFont DDBoldFont:15];
        _titleLabel.textColor = HOME_THEME.app_theme.colorValue;
    }else {
        _titleLabel.font = [UIFont DDLightFont:15];
        _titleLabel.textColor = HOME_THEME.text_black.colorValue;
    }
}
-(void)setTitleStr:(NSString *)titleStr {
    _titleLabel.text = titleStr;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
