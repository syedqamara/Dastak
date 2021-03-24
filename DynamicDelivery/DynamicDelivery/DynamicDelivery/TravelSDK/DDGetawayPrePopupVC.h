//
//  DDGetawayPrePopupVC.h
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 31/03/2020.
//

#import "DDUIBaseViewController.h"
#import "DDAuth/DDAuth.h"
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDGetawayPrePopupVC : DDUIBaseViewController

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIImageView *mainBackgroundImg;
@end

NS_ASSUME_NONNULL_END
