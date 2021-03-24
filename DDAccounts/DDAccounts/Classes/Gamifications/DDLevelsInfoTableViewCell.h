//
//  DDLevelsInfoTableViewCell.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/2/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MRCircularProgressView/MRCircularProgressView.h>
#import "TYMProgressBarView.h"

@interface DDLevelsInfoTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet MRCircularProgressView *badgeProgressView;
@property (nonatomic, weak) IBOutlet UIImageView *levelImgView;
@property (nonatomic, weak) IBOutlet UIImageView *levelEarnedImgView;
@property (nonatomic, weak) IBOutlet UILabel *levelTitleLbl;
@property (nonatomic, weak) IBOutlet UILabel *levelSubTitleLbl;
@property (nonatomic, weak) IBOutlet UILabel *levelCountLbl;
@property (nonatomic, weak) IBOutlet UILabel *smilelabel;
@property (nonatomic, weak) IBOutlet UIImageView *smilesImgView;

@property (nonatomic, weak) IBOutlet TYMProgressBarView *levelProgressView;


@end
