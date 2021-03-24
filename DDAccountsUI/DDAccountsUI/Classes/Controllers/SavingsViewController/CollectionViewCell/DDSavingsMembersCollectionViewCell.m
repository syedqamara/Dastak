//
//  DDSavingsMembersCollectionViewCell.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 09/04/2020.
//

#import "DDSavingsMembersCollectionViewCell.h"
#import <DDCommons/DDCommons.h>
#import "DDAccountUIThemeManager.h"

@implementation DDSavingsMembersCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI{
    [super designUI];
    self.lbl_title.font = [UIFont DDRegularFont:15];
    self.lbl_title.textColor = [DDAccountUIThemeManager shared].selected_theme.text_black_40.colorValue;
    self.container_view.clipsToBounds = YES;
    self.container_view.layer.cornerRadius = 3;
}
-(void)setData:(id)data{
    [super setData:data];
    if ([data isKindOfClass:[DDSavingsGraphDataSection class]]) {
        DDSavingsGraphDataSection *member =  (DDSavingsGraphDataSection*)data;
        self.lbl_title.text = member.legend_name;
        self.container_view.backgroundColor = member.line_color.colorValue;
    }
    
}
@end
