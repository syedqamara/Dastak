//
//  DDOrderStatusDataM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseModel.h"
#import "DDOrderStatusSectionM.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStatusDataM : DDBaseModel
@property (strong, nonatomic) NSArray <DDOrderStatusSectionM, Optional> *sections;
@property (strong, nonatomic) NSNumber <Optional> *refresh_time_interval;
@property (strong, nonatomic) NSNumber <Optional> *is_order_complete;
@property (strong, nonatomic) NSNumber <Optional> *is_cancellable;
@property (strong, nonatomic) NSNumber <Optional> *show_rating;
@property (strong, nonatomic) NSString <Optional> *merchant_name;
@property (strong, nonatomic) NSNumber <Optional> *order_id;
@property (strong, nonatomic) NSNumber <Optional> *merchant_id;
@property (strong, nonatomic) NSNumber <Optional> *outlet_id;
@property (strong, nonatomic) NSString <Optional>*order_no;

-(void)markAnOtherStatusTrue;
-(BOOL)canMarkAnotherTrue;
-(BOOL)isOrderComplete;
-(BOOL)canCancelOrder;
-(BOOL)showRating;
-(NSInteger)refreshTimeInterval;
@end

NS_ASSUME_NONNULL_END
