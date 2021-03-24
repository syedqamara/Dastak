//
//  DDCashlessMerchantM+DDCashless.h
//  DDCashless
//
//  Created by Syed Qamar Abbas on 13/02/2020.
//

#import "DDModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessMerchantM(DDCashless)
-(void)validateSelectedLocationOnOutlet:(DDOutletM *)outlet onCompletion:(StringCompletionCallBack)completion;
-(BOOL)isAllowedToPlaceOrder;
@end

NS_ASSUME_NONNULL_END
