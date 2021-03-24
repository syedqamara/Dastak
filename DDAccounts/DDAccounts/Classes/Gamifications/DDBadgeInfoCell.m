//
//  DDBadgeInfoCell.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/2/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDBadgeInfoCell.h"

@implementation DDBadgeInfoCell


-(void)layoutSubviews{
    [super layoutSubviews];
    self.badgeImgView.clipsToBounds = YES;
    self.badgeImgView.layer.cornerRadius = self.badgeImgView.frame.size.width / 2;
    
}


@end
