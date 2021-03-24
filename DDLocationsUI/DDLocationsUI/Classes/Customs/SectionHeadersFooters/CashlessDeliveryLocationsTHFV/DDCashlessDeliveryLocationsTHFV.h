//
//  DDCashlessDeliveryLocationsTHFV.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 13/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDLocationBaseTHFV.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessDeliveryLocationsTHFVDelegate <NSObject>
@optional
-(void)addNewLocationTapped;
-(void)currentLocationTapped;
-(void)manualLocationTapped;
@end


@interface DDCashlessDeliveryLocationsTHFV : DDLocationBaseTHFV
@property (weak, nonatomic) id<DDCashlessDeliveryLocationsTHFVDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
