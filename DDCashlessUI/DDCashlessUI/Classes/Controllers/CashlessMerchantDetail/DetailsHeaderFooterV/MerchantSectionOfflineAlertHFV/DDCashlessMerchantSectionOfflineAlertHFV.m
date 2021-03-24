//
//  DDMerchantSectionOffersHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantSectionOfflineAlertHFV.h"

@interface DDCashlessMerchantSectionOfflineAlertHFV() {
    DDMerchantDetailSectionM *sectionModel;
}
@property (weak, nonatomic) IBOutlet UIView *innerView;

@end


@implementation DDCashlessMerchantSectionOfflineAlertHFV
-(void)dealloc {
    [sectionModel removeObserver:self forKeyPath:@"is_expanded" context:nil];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblSectionTitle.text = @"";
    
}

- (void)setData:(id)data {
    sectionModel = (DDMerchantDetailSectionM*)data;
    self.lblSectionTitle.text = sectionModel.section_subtitle;
    [sectionModel addObserver:self forKeyPath:@"is_expanded" options:(NSKeyValueObservingOptionNew) context:nil];
    [self setHeight];
    [super setData:data];
}

- (void)designUI {
    self.lblSectionTitle.font = [UIFont DDMediumFont:11];
    self.innerView.backgroundColor = UIColor.redColor;//DDCashlessThemeManager.shared.selected_theme.bg_red_39.colorValue;
    self.lblSectionTitle.textColor = DDCashlessThemeManager.shared.selected_theme.text_white.colorValue;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"is_expanded"]) {
        [self setHeight];
    }
}
-(void)setHeight{
    [UIView performWithoutAnimation:^{
        [((UITableView *)self.superview) beginUpdates];
        
        if (sectionModel.isExpanded) {
            self.outerViewHeightConstraint.constant = 40;
            [self layoutIfNeeded];
            [self.superview layoutIfNeeded];
        }else {
            self.outerViewHeightConstraint.constant = 3;
            [self layoutIfNeeded];
            [self.superview layoutIfNeeded];
        }
        [self setHidden:!sectionModel.isExpanded];
        [((UITableView *)self.superview) endUpdates];
    }];
}
@end

