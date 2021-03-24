//
//  DDBasket.h
//  The Entertainer
//
//  Created by mac on 4/9/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDOrderBasketM.h"
#import "DDCommons.h"
#import "DDModels.h"
#import <WebKit/WebKit.h>
#import "DDOrderTimer.h"

@interface DDBasket : NSObject

@property (nonatomic, strong) DDOrderBasketM *currentOrder;
@property (nonatomic, strong) DDOrderBasketM *currentPendingOrder;
//@property (nonatomic, strong) DDHistoryOrderItem *orderHisotyItem;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;

+ (DDBasket *_Nonnull)shared;
-(void)checkAndInsertPrePopulatedProductWithMerchant:(DDCashlessMerchantM *)merchant;
-(void)setMerchant:(DDCashlessMerchantM *)merchant andAllProducts:(NSMutableArray <DDCashlessItemM *>*)allProducts;
-(void)addSelectedOutlet:(DDOutletM *)outlet;
-(void)addAllLocations:(NSArray *)locations;
-(BOOL)loadSavedBasket;
-(void)resetBasketForceReset:(BOOL)shouldForceReset;
-(void) checkEditOrderAndResetBasket;
- (BOOL)isLocationEnabledAndShowAlert;
+(BOOL) isBasketEmpty;
-(NSString *)merchantAndOutletName;
+(void) resetEditIdleOrderTimerAndMarkOrderIdNil:(NSNumber *) orderId;
+(void) resetEditIdleOrderTimerOnly;
-(BOOL) isOrderInEditState;
-(DDCashlessCart *)getBasketRequestMForWeb;
-(void)encryptedCashlessCart:(DDCashlessCart *)cart;
-(NSString *)cashlessType;
-(void)loadTimerWithTime:(NSTimeInterval)time shouldClearBasketOnCompletion:(BOOL)shouldClearBasket withCompletion:(MainTimerBlock _Nullable)completion;
@end
