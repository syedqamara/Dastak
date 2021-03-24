//
//  DDMerchantSectionOutletDetailHFV.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 11/03/2020.
//

#import "DDMerchantBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantSectionOutletDetailHFVDelegate  <NSObject>

-(void)refreshMainTableViewFromOutletDetailSection;

@end

@interface DDMerchantSectionOutletDetailHFV : DDMerchantBaseHFV
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UILabel *description_Label;
@property (weak, nonatomic) IBOutlet UIButton *btnReadMore;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;
@property (weak, nonatomic) IBOutlet UIView *fadeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnReadMoreBottomConstraint;
@property (nonatomic, weak) id<DDMerchantSectionOutletDetailHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
