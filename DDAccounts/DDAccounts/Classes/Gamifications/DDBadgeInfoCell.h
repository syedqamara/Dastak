//
//  DDBadgeInfoCell.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/2/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCircularProgressView.h"

@interface DDBadgeInfoCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet MRCircularProgressView *badgeProgressView;
@property (nonatomic, weak) IBOutlet UILabel *badgeTitleLbl;
@property (nonatomic, weak) IBOutlet UILabel *badgeSubTitleLbl;
@property (nonatomic, weak) IBOutlet UIImageView *badgeImgView;
@property (nonatomic, weak) IBOutlet UIImageView *doneTickMark;
@property (nonatomic, weak) IBOutlet UILabel *badgesPointsLbl;
@property (nonatomic, weak) IBOutlet UIImageView *badgesPointsImgView;

@end
