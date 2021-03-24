//
//  DDCashlessRemoveItemTVC.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 19/03/2020.
//

#import "DDCashlessBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessRemoveItemTVCDelegate <NSObject>
-(void)deleteItem:(DDCashlessItemM*)item atIndex:(NSInteger)index;
-(void)deleteAllItems;
@end

@interface DDCashlessRemoveItemTVC : DDCashlessBaseTVC
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) id <DDCashlessRemoveItemTVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
