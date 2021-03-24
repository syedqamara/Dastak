//
//  FamilyTreeDetailsTHFV.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 28/01/2020.
//

#import "DDFamilyTreeDetailsTHFV.h"

@interface DDFamilyTreeDetailsTHFV()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (nonatomic, copy) DDFamilyListingSectionVM *section;
@end

@implementation DDFamilyTreeDetailsTHFV

- (void)setData:(id)data {
    self.section = (DDFamilyListingSectionVM*)data;
    if (self.section == nil) return;
    
    self.titleLbl.text = self.section.section_title;
    self.descLbl.text = self.section.section_subtitle;
    
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:13];
    self.titleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.descLbl.font = [UIFont DDMediumFont:13];
    self.descLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
}

@end
