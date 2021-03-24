//
//  DDCashlessDeliveryLocationsTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import "DDAppLocationsTVC.h"

@interface DDAppLocationsTVC()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *flagImageView;
@property (nonatomic, copy) DDLocationsM *location;

@end

@implementation DDAppLocationsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.flagImageView.circle = YES;
    self.flagImageView.clipsToBounds = YES;
    self.flagImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setData:(id)data {
    DDLocationsM *loc = (DDLocationsM*)data;
    if (loc == nil) return;
    self.location = loc;
    
    self.titleLbl.text = self.location.name;
    NSString *flag = self.location.flag;
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:flag];
    if (![flag containsString:@"http"]){
        flag = [flag stringByAppendingString:@".png"];
        flag = [NSString stringWithFormat:@"%@%@",FLAGS_BASE_URL,flag];
    }
    [self.flagImageView loadImageWithString:flag withPlaceHolderImage:placeHolder forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_black.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:17];
}

- (void)setShouldSelected:(BOOL)shouldSelected {
    NSString *statusIcon = shouldSelected ? @"info.png" : @"icControlUnselected.png";
    UIImage *img = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:statusIcon];
    self.accessoryView = [[UIImageView alloc] initWithImage:img];
}

@end
