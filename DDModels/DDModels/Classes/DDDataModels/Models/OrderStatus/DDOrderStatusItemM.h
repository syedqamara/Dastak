//
//  DDOrderStatusItemM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStatusItemM : DDBaseModel
@property (strong, nonatomic) NSString <Optional> *name;
@property (strong, nonatomic) NSString <Optional> *price;
@property (strong, nonatomic) NSArray <DDOrderStatusItemM, Optional> *options;
-(NSString *)combineNameWithSeparator:(NSString *)sep;
-(NSString *)combinePriceWithSeparator:(NSString *)sep;
@end

NS_ASSUME_NONNULL_END
