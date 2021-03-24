//
//  DDMerchantDetailModulesTVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 04/03/2020.
//

#import "DDMerchantDetailModulesTVC.h"
#import "DDOutletsThemeManager.h"
#import "DDMerchantDetailModulesViewModel.h"
#import "DDOutletsUIConstants.h"


@implementation DDMerchantDetailModulesTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    
    self.contentView1.backgroundColor = [UIColor DDcolorFromHexString:@"33c7c7c7"];
    self.contentView1.layer.cornerRadius = 12.0;
    self.contentView1.clipsToBounds = TRUE;
    self.categoryImage1.layer.cornerRadius = 8.0;
    self.categoryImage1.clipsToBounds = TRUE;
    self.titleLabel1.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLabel1.font = [UIFont DDBoldFont:15.0];
    self.contentView2.backgroundColor = [UIColor DDcolorFromHexString:@"33c7c7c7"];
    self.contentView2.layer.cornerRadius = 12.0;
    self.contentView2.clipsToBounds = TRUE;
    self.categoryImage2.layer.cornerRadius = 8.0;
    self.categoryImage2.clipsToBounds = TRUE;
    self.titleLabel2.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLabel2.font = [UIFont DDBoldFont:15.0];
}

-(void)setData:(id)data{
     DDMerchantDetailModulesViewModel* dataObj = (DDMerchantDetailModulesViewModel*)data;
    if (dataObj.leftItem) {
        self.titleLabel1.text = dataObj.leftItem.title;
        if ([dataObj.leftItem.has_accessory_icon boolValue]) {
            [self.accessoryIcon1 loadImageWithString:@"icArrowDown.png" forClass:self.class];
        }
        if (![self checkIfNormalDeliveryOrDineINButton:dataObj.leftItem:self.categoryImage1]) {
            [self.categoryImage1 loadImageWithString:dataObj.leftItem.image_url forClass:self.class];
        }
        self.contentViewBtn1.tag = dataObj.leftItem.objectIndex.intValue;
    }
    if (dataObj.rightItem) {
        self.contentView2.hidden = FALSE;
        self.titleLabel2.text = dataObj.rightItem.title;
        if ([dataObj.rightItem.has_accessory_icon boolValue]) {
            [self.accessoryIcon2 loadImageWithString:@"icArrowDown.png" forClass:self.class];
        }
        if (![self checkIfNormalDeliveryOrDineINButton:dataObj.rightItem:self.categoryImage2]) {
            [self.categoryImage2 loadImageWithString:dataObj.rightItem.image_url forClass:self.class];
        }
        self.contentViewBtn2.tag = dataObj.rightItem.objectIndex.intValue;
    }else
        self.contentView2.hidden = TRUE;
    [super setData:data];
}

-(BOOL) checkIfNormalDeliveryOrDineINButton : (DDMerchantModuleNavigation*)item  :  (UIImageView*)imgView {
    if ([item.identifier isEqualToString:NormalDeliveryID] && [item.title isEqualToString:[NormalDineIn localized]]){
        [imgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"dineInMerchant"]];
        return YES;
    }
    return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapButton:(UIButton*)btn  {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTapOnModuleItem:)]) {
        [_delegate didTapOnModuleItem:btn.tag];
    }
}

@end
