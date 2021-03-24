//
//  DDSahrePingAttributedCVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 11/02/2020.
//

#import "DDSahrePingAttributedCVC.h"
#import "DDPings.h"
#import "DDPingsUI.h"
#import <DDModels/DDModels.h>

@implementation DDSahrePingAttributedCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    self.lbl_title.font = [UIFont DDRegularFont:13];
    self.lbl_title.textColor = DDPingsThemeManager.shared.selected_theme.text_grey_199.colorValue;
}

- (void)setData:(id)data {
    DDOfferAdditionalDetail *object = (DDOfferAdditionalDetail*)data;
    NSString *title = object.title.stringWithDot;
    self.lbl_title.text = title;
    [super setData:data];
}

@end
