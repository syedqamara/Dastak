//
//  DDLevelsInfoTableViewCell.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/2/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDLevelsInfoTableViewCell.h"

@implementation DDLevelsInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.levelImgView.layer.masksToBounds = YES;
    self.levelImgView.layer.cornerRadius = self.levelImgView.frame.size.width / 2;
    
}

@end
