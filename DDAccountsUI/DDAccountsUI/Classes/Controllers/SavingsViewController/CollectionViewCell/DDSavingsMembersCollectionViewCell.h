//
//  DDSavingsMembersCollectionViewCell.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 09/04/2020.
//

#import <UIKit/UIKit.h>
#import "DDBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSavingsMembersCollectionViewCell : DDBaseCVC
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIView *container_view;

@end

NS_ASSUME_NONNULL_END
