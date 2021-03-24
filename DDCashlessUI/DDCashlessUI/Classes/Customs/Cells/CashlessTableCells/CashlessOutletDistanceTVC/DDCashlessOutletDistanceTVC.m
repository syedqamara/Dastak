//
//  DDCashlessOutletDistanceTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 10/04/2020.
//

#import "DDCashlessOutletDistanceTVC.h"

@interface DDCashlessOutletDistanceTVC()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *overlayView;

@property (strong, nonatomic) DDOutletM *outlet;

@end

@implementation DDCashlessOutletDistanceTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data {
    if (![data isKindOfClass:[DDOutletM class]]) return;
    self.outlet = data;
    self.titleLbl.text = self.outlet.name;
    self.subtitleLbl.text = [[DDLocationsManager shared] distanceFromLatidute:self.outlet.lat longitude:self.outlet.lng];
    self.overlayView.hidden = self.outlet.is_open.boolValue;
    
    [super setData:data];
    
    
}

- (void)designUI {
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDRegularFont:13];
    self.subtitleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
}

@end
