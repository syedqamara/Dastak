//
//  DDMerchantMenuItemCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDCashlessMerchantMenuItemCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>

@implementation DDCashlessMerchantMenuItemCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.label.font = [UIFont DDMediumFont:13];
    [super designUI];
}
-(void)setData:(id)data {
    DDMerchantMenuButtonM* menu = (DDMerchantMenuButtonM*)data;
    self.label.text = menu.title;
    if ([menu.type isEqualToString:@"favourites"]){
        if (menu.is_favourite && menu.is_favourite.boolValue) {
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:menu.image_selected_url]];
        }else {
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:menu.image_url]];
        }
    }else {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:menu.image_url]];
    }
    [super setData:data];
}
@end

