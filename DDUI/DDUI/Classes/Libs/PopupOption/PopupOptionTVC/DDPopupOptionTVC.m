//
//  DDPopupOptionTVC.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/06/2020.
//

#import "DDPopupOptionTVC.h"
#import "DDPopupOptionVM.h"
@implementation DDPopupOptionTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(id)data {
    DDPopupOptionVM *viewModel = (DDPopupOptionVM *)data;
    self.leftLabel.text = viewModel.titleLabelLeft;
    self.leftLabel.font = viewModel.fontLeft;
    self.leftLabel.textColor = viewModel.titleColorLeft;
    
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    
    self.rightLabel.text = viewModel.titleLabelRight;
    self.rightLabel.font = viewModel.fontRight;
    self.rightLabel.textColor = viewModel.titleColorRight;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    
    [self.leftView setHidden:viewModel.shouldHideLeftImage];
    [self.rightView setHidden:viewModel.shouldHideRightImage];
    
    [self.titleLeftView setHidden:viewModel.shouldHideLeftTitle];
    [self.titleRightView setHidden:viewModel.shouldHideRightTitle];
    
    [self.separatorView setHidden:viewModel.shouldHideSeparator];
    
    self.separatorView.backgroundColor = viewModel.separatorColor;
    
    [self.leftImageView loadImageWithString:viewModel.leftImage forClass:self.class];
    [self.rightImageView loadImageWithString:viewModel.rightImage forClass:self.class];
    
    self.leftWidthConstraint.constant = viewModel.leftImageWidthHeight;
    self.rightWidthConstraint.constant = viewModel.rightImageWidthHeight;
    
    [self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
