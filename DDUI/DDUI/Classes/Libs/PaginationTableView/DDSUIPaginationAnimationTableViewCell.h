//
//  DDSUIPaginationAnimationTableViewCell.h
//  DDSearchUI_Example
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseTVC.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDSUIPaginationAnimationTableViewCell : DDBaseTVC
-(void)startAnimation;
-(void)stopAnimation;
-(void)loadActivityIndicator;
@end

NS_ASSUME_NONNULL_END
