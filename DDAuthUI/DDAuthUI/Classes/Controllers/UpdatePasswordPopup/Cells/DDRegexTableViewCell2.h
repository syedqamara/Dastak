//
//  DDRegexTableViewCell2.h
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 10/03/2020.
//  Copyright © 2020 dynamicdelivery. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ROW_HEIGHT 15.0

NS_ASSUME_NONNULL_BEGIN

@interface DDRegexTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *validationImageView;

@end

NS_ASSUME_NONNULL_END
