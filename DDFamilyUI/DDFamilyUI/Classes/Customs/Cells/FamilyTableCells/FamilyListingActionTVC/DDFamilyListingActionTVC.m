//
//  DDFamilyListingActionTVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 28/01/2020.
//

#import "DDFamilyListingActionTVC.h"

@interface DDFamilyListingActionTVC()
@property (weak, nonatomic) IBOutlet UILabel *actionLbl;
@property (nonatomic, copy) DDFamilyListingActionVM *action;
@end

@implementation DDFamilyListingActionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    self.action = (DDFamilyListingActionVM*)data;
    if (self.action == nil) return;
    self.actionLbl.text = self.action.member_info.button_title;
    [super setData:data];
}

- (void)designUI {
    self.actionLbl.font = [UIFont DDBoldFont:17];
    self.actionLbl.textColor = self.action.member_info.button_color.colorValue;
}

@end
