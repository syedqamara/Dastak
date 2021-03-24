//
//  DDSliderView.h
//  SomeSDK_Example
//
//  Created by mac on 09/02/2020.
//  Copyright © 2020 syedhasnain0035. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTagM.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDHorizontalTagMenuDelegate <NSObject>
-(void)didTapHorizontalTagAtIndex:(NSInteger)index;
@end

@interface DDHorizontalTagMenu : UIView
@property (strong, nonatomic) NSMutableArray <DDTagM *> *dataSource;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) UIColor *selectionBackgroundColor;
@property (weak, nonatomic) id<DDHorizontalTagMenuDelegate> delegate;
-(UIView *)tagSelectionView;
@end

NS_ASSUME_NONNULL_END
