//
//  DDPurchaseProductsHistoryTableViewCell.m
//  DDProductsUI
//
//  Created by M.Jabbar on 26/03/2020.
//

#import "DDPurchaseProductsHistoryTableViewCell.h"

@implementation DDPurchaseProductsHistoryTableViewCell

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
    
    self.purchaseTypeLabel.superview.layer.cornerRadius = 10;
    self.purchaseTypeLabel.superview.clipsToBounds = YES;

    self.addonsLabel.superview.layer.cornerRadius = 10;
    self.addonsLabel.superview.clipsToBounds = YES;

    
    self.container.layer.cornerRadius = 4;
    self.container.layer.borderWidth = 1;
    self.container.clipsToBounds = YES;
    self.container.borderColor =  [[DDUIThemeManager shared].selected_theme.separator_grey_199.colorValue colorWithAlphaComponent:0.5];
    
    self.purchaseLabel.layer.cornerRadius = 0;
    self.purchaseLabel.layer.borderWidth = 1;
    self.purchaseLabel.clipsToBounds = YES;
    self.purchaseLabel.borderColor =  [[DDUIThemeManager shared].selected_theme.separator_grey_227.colorValue colorWithAlphaComponent:0.5];
    self.purchaseLabel.backgroundColor =  [[DDUIThemeManager shared].selected_theme.bg_grey_199.colorValue colorWithAlphaComponent:0.2];

    self.validLabel.layer.cornerRadius = 0;
    self.validLabel.layer.borderWidth = 1;
    self.validLabel.clipsToBounds = YES;
    self.validLabel.borderColor =  [[DDUIThemeManager shared].selected_theme.separator_grey_227.colorValue colorWithAlphaComponent:0.5];
    self.validLabel.backgroundColor =  [[DDUIThemeManager shared].selected_theme.bg_grey_199.colorValue colorWithAlphaComponent:0.2];

    self.nameLabel.font = [UIFont DDMediumFont:17];
    self.addonsLabel.font = [UIFont DDBoldFont:10];
    self.purchaseTypeLabel.font = [UIFont DDBoldFont:10];
    self.detailLabel.font = [UIFont DDRegularFont:15];
    self.purchaseLabel.font = [UIFont DDRegularFont:13];
    self.validLabel.font = [UIFont DDRegularFont:13];
    self.productCountLabel.font = [UIFont DDBoldFont:15];

    self.nameLabel.textColor = [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.detailLabel.textColor = [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.purchaseLabel.textColor = [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.validLabel.textColor = [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.productCountLabel.textColor = [DDUIThemeManager shared].selected_theme.text_black_40.colorValue;

    self.productCountLabel.superview.backgroundColor = [DDUIThemeManager shared].selected_theme.bg_grey_244.colorValue;

    self.addonsLabel.superview.backgroundColor = [@"#2f85fe".colorValue colorWithAlphaComponent:0.1];
    self.addonsLabel.textColor = @"#2f85fe".colorValue;
    self.purchaseTypeLabel.superview.backgroundColor = [UIColor colorWithRed:57/255 green:215/255 blue:154/255 alpha:0.1];
    self.purchaseTypeLabel.textColor = [UIColor colorWithRed:57/255 green:215/255 blue:154/255 alpha:1.0];
   
    self.sideSliderView.backgroundColor = [DDUIThemeManager shared].selected_theme.app_theme.colorValue;

}
- (void)setData:(id)data{
    [super setData:data];
    
    DDProductPurchaseSectionListM *item = (DDProductPurchaseSectionListM*)data;
    
    if (item) {
        NSString *names = [item.names componentsJoinedByString:@","];
        if (item.purchase_count.intValue > 1) {
            self.productCountLabel.text = [NSString stringWithFormat:@"%@",item.purchase_count];
            self.nameLabel.text = [NSString stringWithFormat:@" x %@",names];
            self.countContainerHeightConstraint.constant = 24;
        }else{
            self.nameLabel.text = names;
            self.productCountLabel.text = @"";
            self.countContainerHeightConstraint.constant = 0;

        }

        self.addonsLabel.text = item.add_ons.count > 0 ?  @"ADD ONS" : @"";
        [self.addonsLabel.superview setHidden:item.add_ons.count <= 0];
        NSString *adons = [[NSString alloc] init];
        for (DDProductPurchaseAddonsM *obj in item.add_ons) {
          adons = [adons stringByAppendingFormat:@"%@\n",obj.name];
        }

        self.detailLabel.attributedText = [[adons trimmedString] addAttribute: NSFontAttributeName value:[UIFont DDRegularFont:15]];
        if (item.purchase_type_text && item.purchase_type_text.length){
            self.purchaseTypeLabel.text = item.purchase_type_text;
            self.purchaseTypeLabel.superview.backgroundColor = [item.purchase_type_text_color.colorValue colorWithAlphaComponent:0.1];
            
            self.purchaseTypeLabel.textColor = item.purchase_type_text_color.colorValue;
        }else {
            self.purchaseTypeLabel.text = @"";
            self.purchaseTypeLabel.superview.backgroundColor = [UIColor clearColor];
        }
        
        
        self.purchaseLabel.text = item.product_purchased_message;
        self.validLabel.text = item.product_validity_message;
        
    }
}
@end
