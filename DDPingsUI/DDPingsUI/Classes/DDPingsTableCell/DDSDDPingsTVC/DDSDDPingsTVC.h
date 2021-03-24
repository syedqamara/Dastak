//
//  DDSentPingsTVC.h
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDUIThemeTableViewCell.h"
#import <DDModels/DDModels.h>
#import "DDPingBaseTVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDSentPingsTVC : DDPingBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIView *callButtonContainerView;
@property (weak, nonatomic) DDPingModel *cellModelData;


@end

NS_ASSUME_NONNULL_END
