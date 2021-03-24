//
//  DDNormalDeliveryMenuTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 21/04/20.
//

#import "DDNormalDeliveryMenuTVC.h"
#import "DDOutletsThemeManager.h"

@implementation DDNormalDeliveryMenuTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
        // Configure the view for the selected state
}

- (void)setData:(id)data {
    DDMenu * menu = (DDMenu*)data;
    if (menu.title == nil){
        menu.title = @"";
    }
    if (menu.desc == nil){
        menu.desc = @"";
    }
    if (menu.price == nil){
        menu.price = @"";
    }
    
    if([menu.is_deliverable boolValue]){
        [self.category_icon loadImageWithString:menu.img forClass:self.class];
        self.category_icon.hidden = NO;
    }else{
        [self.category_icon setImage:[[UIImage alloc] init]];
        self.category_icon.hidden = YES;
    }
    
    self.menu_title.text = menu.title;
    self.menu_description.text = menu.desc;
    self.menu_price.text = menu.price;
}

-(void)designUI {
    self.menu_price.font = [UIFont DDMediumFont:15];
    self.menu_price.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.menu_title.font = [UIFont DDMediumFont:15];
    self.menu_title.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.menu_description.font = [UIFont DDRegularFont:13];
    self.menu_description.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    [self layoutSubviews];
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    self.backgroundView = [[UIImageView alloc] init];
//    //    self.backgroundImageView = (UIImageView *)self.backgroundView;
//    self.selectionStyle = UITableViewCellSelectionStyleBlue;
//
//    self.textLabel.font = [UIFont DDBoldTextFont];
//    self.textLabel.textColor = [UIColor DDBlueTextColor];
//    self.textLabel.backgroundColor = [UIColor clearColor];
//
//    self.detailTextLabel.font = [UIFont DDOfferSubtitleFont];
//    self.detailTextLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
//    self.detailTextLabel.backgroundColor = [UIColor clearColor];
//    self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
//
//
//
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"button-bg-ping"]];
//    [self setMultipleSelectionBackgroundView:bgColorView];
//}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    [self.category_icon sd_setImageWithURL:[NSURL URLWithString:self.menu.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if(self.selected){
//            if(image.size.height)
//                self.category_icon.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//            [self.category_icon setTintColor:[UIColor whiteColor]];
//        }
//    }];
//
//
//    if(self.selected){
//        self.menu_title.textColor = [UIColor whiteColor];
//        self.menu_description.textColor = [UIColor whiteColor];
//        self.menu_price.textColor = [UIColor whiteColor];
//    }else{
//        self.menu_title.textColor = [UIColor DDTextV5Color];
//        self.menu_description.textColor = [UIColor DDTextV5Color];
//        self.menu_price.textColor = [UIColor DDTextV5Color];
//    }
//
//}

@end
