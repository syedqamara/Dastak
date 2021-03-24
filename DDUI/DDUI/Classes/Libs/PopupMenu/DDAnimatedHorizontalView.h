//
//  DDAnimatedHorizontalView.h
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCategoriesPopupVM.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDAnimatedHorizontalViewDelegate <NSObject>
-(void)didTapOnItem : (NSInteger)index;
@end


@interface DDAnimatedHorizontalView : UIView
@property (weak, nonatomic) id<DDAnimatedHorizontalViewDelegate> delegate;
@property (strong, nonatomic) NSArray <DDCategoriesPopupVM *>*dataSource;
-(void)reload;
-(void)reset;
@end

NS_ASSUME_NONNULL_END
