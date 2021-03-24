//
//  DDCashlessRemoveItemTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 19/03/2020.
//

#import "DDCashlessRemoveItemTVC.h"

@interface DDCashlessRemoveItemTVC()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *deleteAllBtn;
@property (weak, nonatomic) IBOutlet UIStackView *itemStack;
@property (weak, nonatomic) IBOutlet UIStackView *deleteAllStack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (nonatomic, strong) DDCashlessItemM *item;

@end

#define DELETE_All @"Delete All"

@implementation DDCashlessRemoveItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDCashlessItemM class]]) return;
    self.item = (DDCashlessItemM*)data;
        
    if ([self.item.itemName isEqualToString:DELETE_All]) {
        self.deleteAllStack.hidden = NO;
        self.itemStack.hidden = YES;
        self.topConstraint.constant = 8;
        [self setSeparatorInset:UIEdgeInsetsMake(0, CGFLOAT_MAX, 0, 0)];
    }
    else {
        self.deleteAllStack.hidden = YES;
        self.itemStack.hidden = NO;
        self.topConstraint.constant = 16;
        [self setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
        
        self.titleLbl.text = self.item.itemName;
        self.subtitleLbl.text = [self.item combineSelectedAdonsWithSeparator:@", "];
    }
    
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:17];
    self.titleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDRegularFont:13];
    self.subtitleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    
    [self.deleteBtn setTitle:DELETE.localized forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:DDCashlessThemeManager.shared.selected_theme.app_theme.colorValue];
    [self.deleteBtn setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont DDMediumFont:15];
    self.deleteBtn.cornerR = 9;
    self.deleteBtn.clipsToBounds = YES;
    
    [self.deleteAllBtn setTitle:DELETE_All forState:UIControlStateNormal];
    [self.deleteAllBtn setTitleColor:DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
    self.deleteAllBtn.titleLabel.font = [UIFont DDBoldFont:17];
    
}


- (IBAction)deleteButtonTapped:(UIButton *)sender {
    if (self.item && self.delegate && [self.delegate respondsToSelector:@selector(deleteItem:atIndex:)]) {
        [self.delegate deleteItem:self.item atIndex:sender.tag];
    }
}

- (IBAction)deleteAllButtonTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAllItems)]) {
        [self.delegate deleteAllItems];
    }
}


@end
