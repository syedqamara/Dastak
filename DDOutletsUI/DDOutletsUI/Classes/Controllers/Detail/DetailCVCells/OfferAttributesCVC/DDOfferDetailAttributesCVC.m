//
//  DDOfferDetailAttributesCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDOfferDetailAttributesCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDOutletsThemeManager.h"
#import "NSString+DDString.h"

@interface DDOfferDetailAttributesCVC () {
    DDOfferAdditionalDetail *object;
}
@end

@implementation DDOfferDetailAttributesCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.label.textColor = DDOutletsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    if (object && object.color && object.color.length)  {
        self.label.textColor = object.color.colorValue;
    }
    self.label.font = [UIFont DDRegularFont:13];
    [super designUI];
}
-(void)setData:(id)data {
    object = (DDOfferAdditionalDetail*)data;
    if (object.hideDotFromString.boolValue){
        self.label.text = object.title;
    }else {
        self.label.text = object.title.stringWithDot;
    }
    [super setData:data];
}
@end

