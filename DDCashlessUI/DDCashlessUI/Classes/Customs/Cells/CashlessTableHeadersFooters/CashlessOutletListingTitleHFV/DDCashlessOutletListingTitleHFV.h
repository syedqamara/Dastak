//
//  DDCashlessOutletListingTitleHFV.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 16/03/2020.
//

#import "DDCashlessBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOutletListingTitleHFVDelegate <NSObject>
-(void)didTapOnCashlessOutletListingTitleHFVButton:(id _Nullable)data;
@end


@interface DDCashlessOutletListingTitleHFV : DDCashlessBaseTHFV
@property (weak, nonatomic) id<DDCashlessOutletListingTitleHFVDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
