//
//  DDMerchantDetailOutletLocationTVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 19/03/2020.
//

#import "DDMerchantDetailOutletLocationTVC.h"
#import <DDlocations/DDLocationsManager.h>
#import "DDOutletsThemeManager.h"

@implementation DDMerchantDetailOutletLocationTVC

- (void)awakeFromNib {
    [super awakeFromNib];
//    [[DDLocationsManager shared] distanceFromLatidute:outlet.lat longitude:outlet.lng]

    // Initialization code
}
- (void)designUI{
    self.locationTitle_label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.locationTitle_label.font = [UIFont DDBoldFont:17];
    self.locationDescription_label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.locationDescription_label.font = [UIFont DDRegularFont:15];
    self.distance_label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.distance_label.font = [UIFont DDRegularFont:13];
    self.sepratorView.backgroundColor = DDOutletsThemeManager.shared.selected_theme.bg_grey_199.colorValue;
}
- (void)setData:(id)data{
    DDOutletM *obj = (DDOutletM *)data;
    self.locationTitle_label.text = obj.name;
    self.locationDescription_label.text = obj.human_location;
    self.distance_label.text = [[DDLocationsManager shared] distanceFromLatidute:obj.lat longitude:obj.lng];
    [super setData:data];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
