//
//  DDCashlessOrderConcernsTHFV.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOrderConcernsTHFVDelegate <NSObject>
-(void)orderConcersTapped;
@end

@interface DDCashlessOrderConcernsTHFV : DDCashlessBaseTHFV
@property (nonatomic, weak) id <DDCashlessOrderConcernsTHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
