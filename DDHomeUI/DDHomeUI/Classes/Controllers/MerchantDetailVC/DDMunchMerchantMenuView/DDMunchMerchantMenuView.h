//
//  DDMunchMerchantMenuView.h
//  Munch
//
//  Created by Syed Qamar Abbas on 26/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DDUI.h>
NS_ASSUME_NONNULL_BEGIN

@class DDMunchMerchantMenuView;

@protocol DDMunchMerchantMenuViewDelegate <NSObject>
-(void)didSelectMenuAtIndexPath:(NSIndexPath * _Nullable )indexPath;
-(void)didSelectShowAllMenu;
@end

@interface DDMunchMerchantMenuView : DDBaseHFV
@property (assign) NSInteger selectedMenuIndex;
@property (weak, nonatomic, nullable) NSString *menuTitleStr;
@property (weak, nonatomic) NSArray * _Nullable menus;
@property (weak, nonatomic, nullable) id<DDMunchMerchantMenuViewDelegate> delegate;
-(void)reloadMenus;

+(DDMunchMerchantMenuView *)nibInstance;
@end

NS_ASSUME_NONNULL_END
