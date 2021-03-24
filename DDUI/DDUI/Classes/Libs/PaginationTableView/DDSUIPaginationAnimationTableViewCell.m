//
//  DDSUIPaginationAnimationTableViewCell.m
//  DDSearchUI_Example
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDSUIPaginationAnimationTableViewCell.h"

@interface DDSUIPaginationAnimationTableViewCell () {
    UIActivityIndicatorView *activityView;
}

@end

@implementation DDSUIPaginationAnimationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (activityView != nil) {
        CGFloat heightWidth = 40;
        activityView.frame = CGRectMake((self.frame.size.width/2)-(heightWidth/2), (self.frame.size.height/2)-(heightWidth/2), heightWidth, heightWidth);
        [activityView setHidesWhenStopped:YES];
    }
}
-(instancetype)init {
    self = [super init];
    [self loadActivityIndicator];
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadActivityIndicator];
    return self;
}
-(void)loadActivityIndicator {
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        [self.contentView addSubview:activityView];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)startAnimation {
    [activityView startAnimating];
}
-(void)stopAnimation {
    [activityView stopAnimating];
}
@end
