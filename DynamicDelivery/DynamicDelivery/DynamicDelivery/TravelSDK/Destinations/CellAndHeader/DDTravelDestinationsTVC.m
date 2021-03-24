//
//  DDTravelDestinationsTVC.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 13/02/2020.
//

#import "DDTravelDestinationsTVC.h"

@interface DDTravelDestinationsTVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (nonatomic, copy) DDCountryM *location;

@end

@implementation DDTravelDestinationsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.flagImageView.circle = YES;
    self.flagImageView.clipsToBounds = YES;
    self.flagImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setData:(id)data {
    DDCountryM *loc = (DDCountryM*)data;
    if (loc == nil) return;
    self.location = loc;
    
    self.titleLbl.text = self.location.name;
    NSString *flag = self.location.shortname;
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:flag];
    if (![flag containsString:@"http"]){
        flag = [flag stringByAppendingString:@".png"];
        flag = [NSString stringWithFormat:@"%@%@",FLAGS_BASE_URL,flag];
    }
    [self.flagImageView loadImageWithString:flag withPlaceHolderImage:placeHolder forClass:self.class];
}

- (void)designUI {
    self.titleLbl.textColor = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:17];
}


@end
