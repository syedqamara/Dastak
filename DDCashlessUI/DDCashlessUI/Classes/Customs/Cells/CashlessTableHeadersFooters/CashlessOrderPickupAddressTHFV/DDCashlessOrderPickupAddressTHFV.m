//
//  DDCashlessOrderPickupAddressTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderPickupAddressTHFV.h"
#import "DDCashlessUIManager.h"

@interface DDCashlessOrderPickupAddressTHFV () {
    DDOrderDetailSectionM *section;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *addressImageView;
@property (weak, nonatomic) IBOutlet UIView *viewMapContainer;
@property (weak, nonatomic) IBOutlet UILabel *viewMapLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewMapImageView;
@property (weak, nonatomic) IBOutlet UIView *mapImageContainer;

@end


@implementation DDCashlessOrderPickupAddressTHFV

-(void)setData:(id)data {
    section = data;
    self.titleLbl.text = section.section_title;
    self.subtitleLbl.text = section.section_subtitle;
    [self.addressImageView loadImageWithString:section.section_takeaway_map.map_image forClass:self.class];
    [self.viewMapImageView loadImageWithString:section.section_takeaway_map.icon forClass:self.class];
    self.viewMapLabel.text = section.section_takeaway_map.title;
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDRegularFont:15];
    self.subtitleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    
    self.viewMapLabel.textColor = CASHLESS_THEME.text_white.colorValue;
    self.viewMapLabel.font = [UIFont DDMediumFont:15];
    
    self.viewMapContainer.backgroundColor = CASHLESS_THEME.app_theme.colorValue;
    self.viewMapContainer.layer.cornerRadius = 5;
    [self.viewMapContainer setClipsToBounds:YES];
    self.mapImageContainer.cornerR = 12;
    self.mapImageContainer.clipsToBounds = 12;
    self.mapImageContainer.borderColor = CASHLESS_THEME.border_grey_199.colorValue;
    self.mapImageContainer.borderW = 0.5;
    
}
- (IBAction)didTapViewMap:(id)sender {
    [[DDCashlessUIManager shared] showOrderStatusMapViewController:section onController:[UIApplication topMostController] andControllerCallBack:^(NSString * _Nonnull identifier, id  _Nonnull data, UIViewController * _Nonnull controller) {
    }];
}


@end
