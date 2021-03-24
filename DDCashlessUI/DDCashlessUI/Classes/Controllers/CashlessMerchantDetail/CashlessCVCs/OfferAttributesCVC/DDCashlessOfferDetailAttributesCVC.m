//
//  DDOfferDetailAttributesCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDCashlessOfferDetailAttributesCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDCashlessThemeManager.h"
#import "NSString+DDString.h"

@implementation DDCashlessOfferDetailAttributesCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.label.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.label.font = [UIFont DDRegularFont:13];
    [super designUI];
}
-(void)setData:(id)data {
    DDOfferAdditionalDetail *object = (DDOfferAdditionalDetail*)data;
    NSString *title = object.title.stringWithDot;
    self.label.text = title;
    [super setData:data];
}
@end

