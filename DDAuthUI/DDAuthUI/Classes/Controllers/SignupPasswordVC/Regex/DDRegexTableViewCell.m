//
//  DDRegexTableViewCell.m
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 20/02/2020.
//  Copyright © 2020 dynamicdelivery. All rights reserved.
//

#import "DDRegexTableViewCell.h"

@implementation DDRegexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDRegularFont:13];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
