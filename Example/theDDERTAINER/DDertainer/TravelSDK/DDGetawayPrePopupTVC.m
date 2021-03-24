//
//  DDGetawayPrePopupTVC.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 31/03/2020.
//

#import "DDGetawayPrePopupTVC.h"
#import "SDWebImage.h"

@interface DDGetawayPrePopupTVC () {
    DDGetawayPrePopuInfoSectionM *_model;
}

@end


@implementation DDGetawayPrePopupTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLbl setFont:[UIFont DDBoldFont:17.f]];
    [self.buttonLbl setFont:[UIFont DDBoldFont:17.f]];
    
    self.containerView.layer.cornerRadius = 12;
    self.backgroundImg.superview.layer.cornerRadius = 12;
    self.containerView.clipsToBounds = false;
    
    [self.containerView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.containerView.layer setBorderWidth:0.2];

    // drop shadow
    [self.containerView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [self.containerView.layer setShadowOpacity:0.5];
    [self.containerView.layer setShadowRadius:3.0];
    [self.containerView.layer setShadowOffset:CGSizeMake(0, 0)];
    
    self.viewButton.layer.cornerRadius = 8;
    
    self.backgroundConstraintHeight.constant = self.containerView.bounds.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DDGetawayPrePopuInfoSectionM *)model{
    _model = model;
    [self.backgroundImg sd_setImageWithURL:[NSURL URLWithString:_model.section_background_image]];
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:_model.section_top_image]];
    self.titleLbl.text = _model.section_title;
    self.buttonLbl.text = _model.section_button_title;
    self.viewButton.backgroundColor = _model.section_button_background_color.colorValue;
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        self.backgroundConstraintHeight.constant = self.containerView.bounds.size.height;
    });
    
}

- (DDGetawayPrePopuInfoSectionM *)model{
    return _model;
}

- (IBAction)buttonAction:(id)sender {
    if ([_model.section_identifier isEqualToString:@"getaways_category"]) {
        if (self.delegate) {
            [self.delegate didBookingButtonTap];
        }
    } else {
        if (self.delegate) {
            [self.delegate didOfferButtonTap];
        }
    }
}

@end
