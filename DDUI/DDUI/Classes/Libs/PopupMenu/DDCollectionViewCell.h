//
//  DDCollectionViewCell.h
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewCell : DDBaseCVC
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (assign, nonatomic) NSInteger index;

@end

NS_ASSUME_NONNULL_END
