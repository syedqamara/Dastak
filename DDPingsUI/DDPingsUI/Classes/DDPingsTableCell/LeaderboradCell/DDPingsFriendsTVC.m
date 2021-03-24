//
//  DDPingsFriendsTVC.h
//  DDPingsUI
//
//  Created by Zubair Ahmad on 15/04/2020.
//

#import "DDPingsFriendsTVC.h"

@interface DDPingsFriendsTVC()

@property (weak, nonatomic) IBOutlet UIImageView *mainImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;


@property (nonatomic, copy) DDFriend *friend;

@end

@implementation DDPingsFriendsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionBtn.userInteractionEnabled = NO;
    self.overlayView.hidden = YES;
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
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icDefaultPhoto"];
    [self.mainImgView loadImageWithString:self.friend.profile_image withPlaceHolderImage:placeHolder forClass:self.class];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:17];
    self.titleLbl.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.subTitleLbl.font = [UIFont DDRegularFont:15];
    self.subTitleLbl.textColor = DDPingsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    
    self.mainImgView.circle = YES;
    self.mainImgView.clipsToBounds = YES;
    
    if (self.friend.isNew) {
        self.titleLbl.font = [UIFont DDBoldFont:17];
        self.titleLbl.textColor = DDPingsThemeManager.shared.selected_theme.text_theme.colorValue;
    }
    self.overlayView.backgroundColor =  [DDPingsThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.5];
}


@end
