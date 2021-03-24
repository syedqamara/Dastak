//
//  DDCashlessCuisinesTVC.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 24/03/2020.
//

#import "DDCashlessBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessCuisinesTVCDelegate <NSObject>
-(void)cuisineSelected;
@end

@interface DDCashlessCuisinesTVC : DDCashlessBaseTVC
@property (weak, nonatomic) id <DDCashlessCuisinesTVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
