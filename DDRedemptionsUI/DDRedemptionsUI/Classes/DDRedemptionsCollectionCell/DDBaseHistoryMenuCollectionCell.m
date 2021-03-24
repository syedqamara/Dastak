//
//  DDBaseHistoryMenuCollectionCell.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDBaseHistoryMenuCollectionCell.h"
#import "DDRedemptionsThemeManager.h"
#import "DDMonthsData+DDCalendarComponent.h"
#import <DDModels/DDModels.h>


@implementation DDBaseHistoryMenuCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self designUI];
}
-(void)designUI{
    self.lbl_title.font = [UIFont DDMediumFont:15];
    self.lbl_title.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.container_view.layer.cornerRadius = self.container_view.bounds.size.width/2;
    self.container_view.clipsToBounds = YES;
}
- (void)setData:(id __nullable )data : (NSString*)item{
//    [super setData:data];
    NSArray *monthDataArray = [[NSArray alloc] initWithArray:(NSArray*)data];
    self.lbl_title.text = [NSString stringWithFormat:@"%@",item.capitalizedString];
    self.userInteractionEnabled = FALSE;
    if ([self isMonthAvailable:monthDataArray :item]){
        self.userInteractionEnabled = TRUE;
        if (self.isCellSelected){
            self.container_view.backgroundColor = DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue;
            self.lbl_title.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_white.colorValue;
            [self animateSelectedView];
        }else{
            self.container_view.backgroundColor = [UIColor clearColor];
             self.lbl_title.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
        }
    }
    else{
        self.container_view.backgroundColor = [UIColor clearColor];
        self.lbl_title.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    }
    if (self.lbl_title.text.length > 3) {
        self.lbl_title.font = [UIFont DDMediumFont:13];
    }else {
        self.lbl_title.font = [UIFont DDMediumFont:15];
    }
}
-(void)animateSelectedView{
 
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        
      self.container_view.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8);
        self.container_view.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    } completion:^(BOOL finished) {
        
    }];
}
-(BOOL)isMonthAvailable:(NSArray *)monthDataArray :(NSString*)itemStr{
    BOOL isMonthAvailable = FALSE;
    NSString *monthStr = [[itemStr componentsSeparatedByString:@" "] firstObject];
    NSDateComponents *dc1 = [DDExtraUtil getCalendarCopmonetFromLocale:monthStr :@"MM"];
    if (dc1 == nil){
        dc1= [DDExtraUtil getCalendarCopmonetFromLocale:monthStr :@"MM yyyy"];
    }
    NSInteger month = [dc1 month];
    for (int i = 0; i < monthDataArray.count; i++) {
        DDMonthsData * monthObj = [monthDataArray objectAtIndex:i];
        NSDateComponents *dc2 = [DDExtraUtil getCalendarCopmonetFromLocale:monthObj.month :@"yyyy MMM"];
        if (month == [dc2 month]) {
            self.isCellSelected = [monthObj isSelected];
            return isMonthAvailable = YES;
        }
    }
    return isMonthAvailable;
}
@end
