//
//  DDUIThemeTableViewCell.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDUIThemeTableViewCell.h"

@implementation DDUIThemeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)designUI {
    
}
-(void)setData:(id)data {
    [self designUI];
}
-(void)setSection:(id)data {
    
}
@end
