//
//  DDFamilyMemberTVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 24/01/2020.
//

#import "DDFamilyMemberTVC.h"

@interface DDFamilyMemberTVC()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, copy) DDFamilyMemberM *member;

@end

@implementation DDFamilyMemberTVC

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(id)data {
    self.member = (DDFamilyMemberM*)data;
    if (self.member == nil) return;
    
    self.nameLabel.text = self.member.name;
    self.statusLabel.text = self.member.status;
    [self setMemberImage];
    [super setData:data];
    
    if(self.member.shouldDisableAddButton) {
        [self disableAddNew];
    }
}

-(void)disableAddNew {
    [self.mainImageview loadImageWithString:@"iconDisabledAdd.png" forClass:self.class];
    self.nameLabel.textColor = [DDFamilyThemeManager.shared.selected_theme.text_theme.colorValue colorWithAlphaComponent:0.4];
}

-(void)setMemberImage {
    if (self.member.isNew) {
        [self.mainImageview loadImageWithString:@"iconContentAdd.png" forClass:self.class];
    }
    else {
        UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:DUMMY_PLACEHOLDER];
        [self.mainImageview loadImageWithString:self.member.profile_img withPlaceHolderImage:placeHolder forClass:self.class];
    }
}

- (void)designUI {
    self.nameLabel.font = [UIFont DDMediumFont:17];
    self.nameLabel.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.statusLabel.font = [UIFont DDRegularFont:15];
    self.statusLabel.textColor = self.member.color.colorValue;
    
    self.mainImageview.circle = YES;
    self.mainImageview.clipsToBounds = YES;
    
    if (self.member.isNew) {
        self.nameLabel.font = [UIFont DDBoldFont:17];
        self.nameLabel.textColor = DDFamilyThemeManager.shared.selected_theme.text_theme.colorValue;
    }
}

@end
