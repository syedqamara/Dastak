//
//  DDCashlessOrderConcernsTHFV.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOrderCollectTHFVDelegate <NSObject>
-(void)orderConcersTapped;
@end

@interface DDCashlessOrderCollectTHFV : DDCashlessBaseTHFV
@property (nonatomic, weak) id <DDCashlessOrderCollectTHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
