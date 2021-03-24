//
//  DDPingsLeaderBoardTVC.h
//  DDPingsUI
//
//  Created by Zubair Ahmad on 15/04/2020.
//

#import "DDPingsLeaderBoardTVC.h"

@interface DDPingsLeaderBoardTVC()

@property (weak, nonatomic) IBOutlet UIImageView *mainImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation DDPingsLeaderBoardTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setData:(id)data {
    NSDictionary *object = (NSDictionary*)data;
    self.titleLbl.text = [object valueForKey:@"title"];
    self.subTitleLbl.text = [object valueForKey:@"sub_title"];
    [self.mainImgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icRadioActive"]];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDMediumFont:17];
    self.titleLbl.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.subTitleLbl.font = [UIFont DDRegularFont:15];
    self.subTitleLbl.textColor = DDPingsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.lineView.backgroundColor = DDPingsThemeManager.shared.selected_theme.border_grey_199.colorValue;
    
}

@end
