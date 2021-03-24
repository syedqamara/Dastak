//
//  DDCashlessDeliveryLocationsTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import "DDCashlessDeliveryLocationsTVC.h"
#import "DDLocationsUIConstants.h"
#import "DDLocationsManager.h"
@interface DDCashlessDeliveryLocationsTVC()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (nonatomic, copy) DDDeliveryAddressM *adress;
@property (weak, nonatomic) IBOutlet UIImageView *cImageView;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;

@property (weak, nonatomic) IBOutlet UIImageView *selectionImage;

@end

@implementation DDCashlessDeliveryLocationsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPrediction:(GMSAutocompletePrediction*)prediction {
    self.titleLbl.text = prediction.attributedPrimaryText.string;
    self.subtitleLbl.text = prediction.attributedSecondaryText.string;
    [self.cImageView loadImageWithString:@"ic-pin.png" forClass:self.class];
    [self designUI];
}
- (void)setAddress:(DDDeliveryAddressM *)adress {
    if (adress == nil) return;
    self.adress = adress;
    if (self.adress.isCurrentLocation) {
        self.titleLbl.text = CURRDD_LOCATION.localized;
        self.subtitleLbl.text = UNABLE_TO_DEFINE_CURRDD_LOCATION.localized;
        [self.cImageView loadImageWithString:@"ic-current-location.png" forClass:self.class];
    }else {
        self.titleLbl.text = self.adress.getTitle;
        self.subtitleLbl.text = self.adress.getAddress;
        [self.cImageView loadImageWithString:@"ic-pin.png" forClass:self.class];
    }
    [self.editImage.superview setHidden:YES];
    [self.selectionImage.superview setHidden:YES];
    [super setData:adress];
}
- (void)setData:(id)data {
    DDDeliveryAddressM *adress = (DDDeliveryAddressM*)data;
    if (adress == nil) return;
    self.adress = adress;
    self.titleLbl.text = self.adress.getTitle;
    self.subtitleLbl.text = self.adress.getCompleteAddress;
    [self.cImageView loadImageWithString:self.adress.tag.image_url forClass:self.class];
    [self.editImage loadImageWithString:@"ic-edit.png" forClass:self.class];
    [self.selectionImage loadImageWithString:@"ic-delete.png" forClass:self.class];
    
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_black.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:15];
    
    self.subtitleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.subtitleLbl.font = [UIFont DDRegularFont:14];
}

@end
