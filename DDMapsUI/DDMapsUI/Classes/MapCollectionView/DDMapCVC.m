//
//  DDMapCVC.m
//  DDMapsUI
//
//  Created by Zubair Ahmad on 11/02/2020.
//

#import "DDMapCVC.h"
#import "SDWebImage.h"
#import "DDLocationsManager.h"
#import "DDMapsUIConstants.h"

@interface DDMapCVC ()
{
    NSArray *outlet_attributes;
}
@end

@implementation DDMapCVC


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)designUI {
    [super designUI];
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.textColor = DDMapsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subTitleLabel.textColor = DDMapsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.distanceLabel.textColor = DDMapsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.subTitleLabel.font = [UIFont DDRegularFont:15];
    self.distanceLabel.font = [UIFont DDRegularFont:13];
    
    self.logoImageView.layer.borderWidth = 1;
    self.logoImageView.layer.borderColor = [UIColor DDLineBorderShadowColor].CGColor;
    self.logoImageView.cornerR = 10;
    self.logoImageView.clipsToBounds = YES;
    [self.logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.containerView.backgroundColor = DDMapsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.containerView.cornerR = 10;
    self.containerView.clipsToBounds = YES;
    
     self.cuisinesLabel.font  = [UIFont DDRegularFont:13];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setData:(id)data {
    self.lockImageView.hidden = YES;
//    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:outlet.merchant.logo_url]];
//    if (outlet.locked_image_url != nil && outlet.locked_image_url.length > 0){
//        self.lockImageView.hidden = NO;
//        [self.lockImageView sd_setImageWithURL:[NSURL URLWithString:outlet.locked_image_url]];
//    }
//    self.titleLabel.text = outlet.merchant.name;
//    self.subTitleLabel.text =  outlet.human_location;
//    self.distanceLabel.text = [[DDLocationsManager shared] distanceFromLatidute:outlet.lat longitude:outlet.lng];
//    outlet_attributes = outlet.merchant.cuisines_sub_categories;
//
//    self.cuisinesLabel.text = @"";
//
//    if (outlet_attributes != nil && outlet_attributes.count > 0){
//        NSMutableAttributedString *cousine = [[NSMutableAttributedString alloc] initWithString:@""];
//        [outlet_attributes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            DDMerchantCuisines *cuisineObj = (DDMerchantCuisines*)obj;
//            NSAttributedString *attrStr = [cuisineObj.title attributedWithFont:[UIFont DDMediumFont:13] andColor:cuisineObj.color.colorValue];
//            [cousine appendAttributedString:attrStr];
//            if (idx != outlet_attributes.count-1){
//                NSAttributedString *dotString = [@"".dotString attributedWithFont:[UIFont DDMediumFont:10] andColor:cuisineObj.color.colorValue];
//                [cousine appendAttributedString:dotString];
//            }
//        }];
//        self.cuisinesLabel.attributedText = cousine;
//    }else{
//        self.cuisinesLabel.text = @"";
//    }
    
    [super setData:data];
}

@end
