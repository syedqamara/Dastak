//
//  DDFamilyCreatedByTHFV.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 28/01/2020.
//

#import "DDFamilyCreatedByTHFV.h"

@interface DDFamilyCreatedByTHFV()
@property (weak, nonatomic) IBOutlet UILabel *createdByLbl;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLbl;

@property (nonatomic, copy) DDFamilyListingSectionVM *section;

@end

@implementation DDFamilyCreatedByTHFV


- (void)setData:(id)data {
    self.section  = (DDFamilyListingSectionVM*)data;
    if (self.section == nil) return;
    
    self.createdByLbl.text = self.section.section_title;
    self.createdAtLbl.text = self.section.section_subtitle;
    
    [super setData:data];
}

- (void)designUI {
        
    self.createdByLbl.font = [UIFont DDRegularFont:13];
    self.createdByLbl.textColor = [FAMILY_THEME.text_black_40.colorValue colorWithAlphaComponent:0.5];
    
    self.createdAtLbl.font = [UIFont DDRegularFont:13];
    self.createdAtLbl.textColor = [FAMILY_THEME.text_black_40.colorValue colorWithAlphaComponent:0.5];
}

@end
