//
//  FavouritesTableViewCell.m
//  DDFavourites
//
//  Created by M.Jabbar on 03/03/2020.
//

#import "FavouritesTableViewCell.h"
#import <DDModels/DDModels.h>
#import "DDFavouritesThemeManager.h"
@implementation FavouritesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)designUI{
    self.nameLabel.textColor = [DDFavouritesThemeManager shared].selected_theme.text_black.colorValue;
    self.nameLabel.font = [UIFont DDBoldFont:17];
    self.cousinesLabel.font = [UIFont DDMediumFont:13];
    _logoImageView.layer.cornerRadius = 12;
    _logoImageView.layer.borderWidth = 1;
    _logoImageView.clipsToBounds = YES;
    _logoImageView.layer.borderColor = [DDFavouritesThemeManager shared].selected_theme.border_grey_199.colorValue.CGColor;
}
-(void)setData:(id)data{
    [super setData:data];
    DDFavouritesSectionListM *item = (DDFavouritesSectionListM*)data;
     
    self.nameLabel.text = item.name;
    NSString *favourite = item.is_favourite.boolValue ? @"icFavouriteFilled" : @"icFavourite";
    [self.favouriteButton setImage:[[NSBundle loadImageFromResourceBundlePNG:self.class imageName:favourite] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.shareButton setImage:[[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icShare"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    NSMutableAttributedString *cousine = [[NSMutableAttributedString alloc] initWithString:@""];
    if (item.cuisines_sub_categories.count > 0){
        [item.cuisines_sub_categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DDFavouritesCuisinesListM *cuisineObj = (DDFavouritesCuisinesListM*)obj;
            NSAttributedString *attrStr = [cuisineObj.title attributedWithFont:[UIFont DDMediumFont:13] andColor:cuisineObj.font_color.colorValue];
            if (attrStr)
                [cousine appendAttributedString:attrStr];
            if (idx != item.cuisines_sub_categories.count-1){
                NSAttributedString *dotString = [@"".dotString attributedWithFont:[UIFont DDMediumFont:10] andColor:cuisineObj.font_color.colorValue];
                if (dotString)
                    [cousine appendAttributedString:dotString];
            }
        }];
        self.cousinesLabel.attributedText = cousine;
    }else{
        self.cousinesLabel.text = @"";
    }
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:item.logo_url]];
}
-(IBAction)shareButtonTapped:(id)sender{
    _callBackShare(self);
}
-(IBAction)favouriteButtonTapped:(id)sender{
    _callBackFavourite(self);
}
@end
