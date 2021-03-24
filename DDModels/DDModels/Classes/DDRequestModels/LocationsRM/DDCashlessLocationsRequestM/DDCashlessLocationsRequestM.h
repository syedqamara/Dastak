//
//  DDCashlessLocationsRequestM.h
//  Pods
//
//  Created by Awais Shahid on 25/02/2020.
//

#import "DDBaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessLocationsRequestM : DDBaseRequestModel

@property (strong, nonatomic) NSString <Optional> *title;
@property (strong, nonatomic) NSNumber <Optional> *delivery_location_id;

-(BOOL)isValidRequestForDeleteLocation;
-(NSString *)validationErrorForDeleteLocation;

-(BOOL)isValidRequestForAddLocation;
-(NSString *)validationErrorForAddLocation;


@end

NS_ASSUME_NONNULL_END
