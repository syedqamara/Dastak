//
//  DDCashlessOutletTextAttributeCVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 16/03/2020.
//

#import "DDCashlessOutletTextAttributeCVC.h"

@interface DDCashlessOutletTextAttributeCVC()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@end

@implementation DDCashlessOutletTextAttributeCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    DDOutletAttributes *attribute = (DDOutletAttributes*)data;
    if (attribute == nil) return;
    self.titleLbl.text = attribute.value;
    
    if (attribute.isBold) {
        self.titleLbl.font = [UIFont DDBoldFont:13];
    }
    else {
        self.titleLbl.font = [UIFont DDRegularFont:13];
    }

    [super setData:data];
}

- (void)designUI {
    self.titleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end

