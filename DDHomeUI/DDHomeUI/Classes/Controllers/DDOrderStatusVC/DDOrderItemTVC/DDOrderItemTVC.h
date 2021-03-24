//
//  DDOrderItemTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 01/08/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderItemTVC : DDBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *itemPriceLabel;


@property (unsafe_unretained, nonatomic) IBOutlet UILabel *adonsLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *adonsNameLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *adonsPriceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *separatorView;

@end

NS_ASSUME_NONNULL_END
