//
//  DDBaseHistoryMenuCollectionCell.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseHistoryMenuCollectionCell : DDBaseCVC
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIView *container_view;
@property (weak, nonatomic) NSIndexPath *selecetedIndexPath;
@property BOOL isCellSelected;
- (void)setData:(id __nullable)data :  (NSString*)item;
@end

NS_ASSUME_NONNULL_END
