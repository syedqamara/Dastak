//
//  DDHorizontalSelectedFilters.h
//  DDFiltersUI
//
//  Created by Awais Shahid on 02/04/2020.
//

#import "DDUIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHorizontalSelectedFilters : DDUIBaseView
- (void)setDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt;
+ (void)showInConatiner:(UIView *)container withDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt;
+ (DDHorizontalSelectedFilters*)showAndReturnInConatiner:(UIView *)container withDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt;
@end

NS_ASSUME_NONNULL_END
