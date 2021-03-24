//
//  DDFiltersShowMoreCVC.m
//  The Entertainer
//
//  Created by Raheel on 23/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDFiltersShowMoreCVC.h"

@interface DDFiltersShowMoreCVC()

@property (nonatomic, weak) IBOutlet UIView *mainView;
@property (nonatomic, weak) IBOutlet UIImageView *backImageTemp;
@property (nonatomic, weak) IBOutlet UILabel *countLbl;

@end

@implementation DDFiltersShowMoreCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)designUI{
    [self.backImageTemp loadImageWithString:@"filter_show_more.png" forClass:self.class];
    //    self.mainView.layer.borderColor = [UIColor DDTRAppCorporateColor].CGColor;
    self.mainView.layer.cornerRadius = 6.0;
    self.mainView.layer.borderWidth = 0.5;
    
    //    self.countLbl.font = [UIFont DDRegularFont:14.0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void) changeLayout{
    CGRect frame = self.mainView.frame;
    frame.size.height = self.frame.size.height;
    frame.size.width = self.frame.size.width;
    self.mainView.frame = frame;
    
    frame = self.backImageTemp.frame;
    frame.origin.y = (self.frame.size.height / 2) - (self.backImageTemp.frame.size.height / 2);
    frame.origin.x = (self.frame.size.width / 2) - (self.backImageTemp.frame.size.width / 2);
    self.backImageTemp.frame = frame;
    
    frame = self.countLbl.frame;
    frame.size.height = self.frame.size.height;
    self.countLbl.frame = frame;

}

-(void) changeLayoutForCusines{
    CGRect frame = self.mainView.frame;
    frame.size.height = 55;
    frame.size.width = 55;
    self.mainView.frame = frame;
    
    frame = self.backImageTemp.frame;
    frame.origin.y = (self.mainView.frame.size.height / 2) - (self.backImageTemp.frame.size.height / 2);
    frame.origin.x = (self.mainView.frame.size.width / 2) - (self.backImageTemp.frame.size.width / 2);
    self.backImageTemp.frame = frame;
    
    
}

-(void) setSelectedCellLayout:(NSString *) text{
    [self.backImageTemp setHidden: true];
    self.countLbl.text = text;
    self.mainView.backgroundColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
}

-(void) setUnSelectedCellLayout{
    [self.backImageTemp setHidden: false];
    self.countLbl.text = @"";
    self.mainView.backgroundColor = DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
//    self.mainView.layer.borderColor = [UIColor DDTRAppCorporateColor].CGColor;
    self.mainView.layer.borderWidth = 0.5;
}



@end
