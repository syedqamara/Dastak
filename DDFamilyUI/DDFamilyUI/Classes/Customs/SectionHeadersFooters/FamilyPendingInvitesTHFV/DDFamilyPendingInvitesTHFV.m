//
//  DDFamilyPendingInvitesTHFV.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 03/02/2020.
//

#import "DDFamilyPendingInvitesTHFV.h"

@interface DDFamilyPendingInvitesTHFV()
@property (weak, nonatomic) IBOutlet UILabel *sectionLbl;
@end

@implementation DDFamilyPendingInvitesTHFV


- (void)setData:(id)data {
    self.sectionLbl.text = (NSString*)data;
    [super setData:data];
}

- (void)designUI {
    self.sectionLbl.font = [UIFont DDMediumFont:15];
    self.sectionLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.contentView.backgroundColor = DDFamilyThemeManager.shared.selected_theme.app_grouped_table_235.colorValue;
}

@end
