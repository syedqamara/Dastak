//
//  DDOrderStatusM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderStatusM : DDBaseModel
@property (strong, nonatomic) NSNumber <Optional> *state;
@property (strong, nonatomic) NSString <Optional> *color;

-(BOOL)isEnabled;
-(NSDictionary *)chartDict;
-(NSDictionary *)emptyChartDict;
@end

NS_ASSUME_NONNULL_END
