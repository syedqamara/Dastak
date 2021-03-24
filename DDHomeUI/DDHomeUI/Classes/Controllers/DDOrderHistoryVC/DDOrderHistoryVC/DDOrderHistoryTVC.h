//
//  DDOrderHistoryTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *outletImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *outletName;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderTime;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderAddress;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *orderStatusImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderStatusTitle;

@end

NS_ASSUME_NONNULL_END
