//
//  DDRegexTableViewCell.h
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 20/02/2020.
//  Copyright © 2020 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDUI.h"
#define PASSWORD_RULES_ROW_HEIGHT 25.0
NS_ASSUME_NONNULL_BEGIN



@interface DDRegexTableViewCell : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *validationImageView;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;

@end

NS_ASSUME_NONNULL_END
