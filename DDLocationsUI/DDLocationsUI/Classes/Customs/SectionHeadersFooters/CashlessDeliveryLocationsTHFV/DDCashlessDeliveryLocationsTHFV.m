//
//  DDCashlessDeliveryLocationsTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import "DDCashlessDeliveryLocationsTHFV.h"

@interface DDCashlessDeliveryLocationsTHFV()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic, copy) DDCashlessDeliveryLocationsSectionVM *sectionVM;

@end

@implementation DDCashlessDeliveryLocationsTHFV

- (void)setData:(id)data {
    DDCashlessDeliveryLocationsSectionVM *vm = (DDCashlessDeliveryLocationsSectionVM*)data;
    if (vm == nil) return;
    self.sectionVM = vm;
    
    self.titleLbl.text = self.sectionVM.title;
    [self.imgView loadImageWithString:self.sectionVM.image forClass:self.class];
    if (self.sectionVM.isManualSection) {
        self.topLine.hidden = NO;
        self.bottomLine.hidden = YES;
    }
    else {
        self.topLine.hidden = YES;
        self.bottomLine.hidden = NO;
    }
    [super setData:data];
    
}

- (void)designUI {
    self.contentView.backgroundColor = DDLocationsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.imgView.circle = YES;
    self.imgView.clipsToBounds = YES;

    self.titleLbl.textColor = self.sectionVM.color.colorValue;
    if (self.sectionVM.isNewSection || self.sectionVM.isManualSection) {
        self.titleLbl.font = [UIFont DDMediumFont:17];
    }
    else {
        self.titleLbl.font = [UIFont DDLightFont:17];
    }
    self.topLine.backgroundColor = DDLocationsThemeManager.shared.selected_theme.separator_grey_227.colorValue;
    self.bottomLine.backgroundColor = DDLocationsThemeManager.shared.selected_theme.separator_grey_227.colorValue;
    
}


- (IBAction)didTapped:(UIButton *)sender {
    if (self.delegate != nil) {
        if (self.sectionVM.isCurrentSection && [self.delegate respondsToSelector:@selector(currentLocationTapped)]) {
            [self.delegate currentLocationTapped];
        }
        else if (self.sectionVM.isNewSection && [self.delegate respondsToSelector:@selector(currentLocationTapped)]) {
            [self.delegate addNewLocationTapped];
        }
        else if (self.sectionVM.isManualSection && [self.delegate respondsToSelector:@selector(manualLocationTapped)]) {
            [self.delegate manualLocationTapped];
        }
    }
}



@end
