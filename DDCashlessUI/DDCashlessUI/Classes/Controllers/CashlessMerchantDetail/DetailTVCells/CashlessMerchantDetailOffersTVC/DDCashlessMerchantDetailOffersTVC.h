//
//  DDMerchantDetailOffersTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDCashlessUIManager.h"
#import "DDCashlessThemeManager.h"
#import "DDCashlessMerchantOffersCellViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessMerchantDetailOffersTVCDelegate  <NSObject>

-(void)didTapOfferItem : (DDCashlessMerchantOffersCellViewModel*)offerViewModel;
@end

@interface DDCashlessMerchantDetailOffersTVC : DDBaseTVC

@property (weak, nonatomic) id<DDCashlessMerchantDetailOffersTVCDelegate> delegate;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@end

NS_ASSUME_NONNULL_END
