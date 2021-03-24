//
//  DDGetawayPrePopupTVC.h
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 31/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>
#import <DDUI/DDUI.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDGetawayPrePopupTVCDelegate <NSObject>

- (void)didOfferButtonTap;
- (void)didBookingButtonTap;

@end

@interface DDGetawayPrePopupTVC : DDBaseTVC

@property (weak) id <DDGetawayPrePopupTVCDelegate> delegate;

@property (strong, nonatomic) DDGetawayPrePopuInfoSectionM *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundConstraintHeight;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *viewButton;
@property (weak, nonatomic) IBOutlet UIImageView *buttonAccessoryImg;
@property (weak, nonatomic) IBOutlet UILabel *buttonLbl;

@end

NS_ASSUME_NONNULL_END
