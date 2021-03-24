//
//  DDMerchantDetailOffersTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDOutletsUIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantDetailOffersTVCDelegate  <NSObject>

-(void)didTapOfferItem : (DDMerchantOffersLocalDataM*)offerViewModel;
@end

@interface DDMerchantDetailOffersTVC : DDBaseTVC

@property (weak, nonatomic) id<DDMerchantDetailOffersTVCDelegate> delegate;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@end

NS_ASSUME_NONNULL_END
