//
//  DDFriendLeaderBoardTVC.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 25/03/2020.
//

#import "DDFriendLeaderBoardTVC.h"

@interface DDFriendLeaderBoardTVC()

@property (weak, nonatomic) IBOutlet UIImageView *mainImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@property (nonatomic, copy) DDFriend *friend;

@end

@implementation DDFriendLeaderBoardTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setData:(id)data {
    if (![data isKindOfClass:[DDFriend class]]) return;
    
    self.friend = (DDFriend*)data;
    self.titleLbl.text = self.friend.name;
    self.subTitleLbl.text = self.friend.formattedSavings;
    [self setFriendImage];
    
    [super setData:data];
}

-(void)setFriendImage {
    if (self.friend.isNew) {
        [self.mainImgView loadImageWithString:@"iconContentAdd.png" forClass:self.class];
    }
    else {
        UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:DUMMY_PLACEHOLDER];
        [self.mainImgView loadImageWithString:self.friend.profile_image withPlaceHolderImage:placeHolder forClass:self.class];
    }
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:17];
    self.titleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.subTitleLbl.font = [UIFont DDRegularFont:15];
    self.subTitleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.subtitle_blue_219.colorValue;
    
    self.mainImgView.circle = YES;
    self.mainImgView.clipsToBounds = YES;
    
    if (self.friend.isNew) {
        self.titleLbl.font = [UIFont DDBoldFont:17];
        self.titleLbl.textColor = DDFamilyThemeManager.shared.selected_theme.text_theme.colorValue;
    }
}


@end
