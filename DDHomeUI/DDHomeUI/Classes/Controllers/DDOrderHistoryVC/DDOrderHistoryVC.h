//
//  DDOrderHistoryVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/08/2020.
//

#import "DDUIBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDOrderHistoryVC : DDUIBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)didChangeSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

NS_ASSUME_NONNULL_END
