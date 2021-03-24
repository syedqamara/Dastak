//
//  DDCashlessViewOrderTVC.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessViewOrderTHFVDelegate <NSObject>
-(void)didTapExpandButton;
@end

@interface DDCashlessViewOrderTHFV : DDCashlessBaseTHFV
@property (weak, nonatomic) id<DDCashlessViewOrderTHFVDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
