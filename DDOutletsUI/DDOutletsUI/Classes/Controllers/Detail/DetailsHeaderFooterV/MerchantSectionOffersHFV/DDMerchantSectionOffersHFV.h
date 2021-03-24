//
//  DDMerchantSectionOffersHFV.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//


#import "DDMerchantBaseHFV.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantSectionOffersHFVDelegate <NSObject>
-(void)didTapExpandCollapsButtonFromOfferSection:(NSString*)sectionID;
@end

@interface DDMerchantSectionOffersHFV : DDMerchantBaseHFV
@property (weak, nonatomic) id<DDMerchantSectionOffersHFVDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblSectionTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandCollaps;
@property (weak, nonatomic) IBOutlet UIButton *imgVArrow;

@end

NS_ASSUME_NONNULL_END
