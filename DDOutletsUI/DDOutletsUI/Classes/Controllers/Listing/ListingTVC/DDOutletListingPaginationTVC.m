//
//  DDOutletListingPaginationTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 30/01/2020.
//

#import "DDOutletListingPaginationTVC.h"

@interface DDOutletListingPaginationTVC ()
{
    UIActivityIndicatorView *activityView;
}
@end

@implementation DDOutletListingPaginationTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        activityView.hidesWhenStopped = YES;
        [self.contentView addSubview:activityView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (activityView != nil) {
        CGFloat heightWidth = 40;
        activityView.frame = CGRectMake((self.frame.size.width/2)-(heightWidth/2), (self.frame.size.height/2)-(heightWidth/2), heightWidth, heightWidth);
        [activityView setHidesWhenStopped:YES];
    }
}

-(void)startAnimation{
    [activityView startAnimating];
    [super startAnimation];
}

-(void)stopAnimation {
    [activityView stopAnimating];
    [super stopAnimation];
}

-(void)loadActivityIndicator{
    [super loadActivityIndicator];
}

-(void)designUI {
}

-(void)setData:(id)data {
    [super setData:data];
}
@end
