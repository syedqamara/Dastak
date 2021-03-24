//
//  CashlessOrderPickupTHFV.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOrderPickupDelegate <NSObject>
-(void)didTapPickupOrderButton;
@end

@interface DDCashlessOrderPickupTHFV : DDCashlessBaseTHFV
@property (weak, nonatomic) id<DDCashlessOrderPickupDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
