//
//  DDMyFriendsTVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 25/03/2020.
//

#import "DDMyFriendsTVC.h"

@interface DDMyFriendsTVC()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation DDMyFriendsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    if (![data isKindOfClass:[NSString class]]) return;
    NSString *txt = (NSString *)data;
    self.titleLbl.text = txt.localized;
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:17];
}


@end
