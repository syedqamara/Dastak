//
//  DDMDOnlineOfferHistoryDetailTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 24/03/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMDOnlineOfferHistoryDetailTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UIView *sepratorView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Redeemed;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Redeemed_Date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PromoCode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PromoCode_Number;
@property (weak, nonatomic) IBOutlet UIButton *btn_Copy;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_logo;

@end

NS_ASSUME_NONNULL_END
