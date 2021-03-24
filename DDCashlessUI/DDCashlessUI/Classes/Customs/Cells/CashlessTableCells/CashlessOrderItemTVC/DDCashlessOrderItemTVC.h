//
//  DDCashlessOrderItemTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 15/04/2020.
//

#import "DDCashlessBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCashlessOrderItemTVC : DDCashlessBaseTVC
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

NS_ASSUME_NONNULL_END
