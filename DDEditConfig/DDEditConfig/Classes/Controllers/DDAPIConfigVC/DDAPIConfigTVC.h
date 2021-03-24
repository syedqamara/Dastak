//
//  DDAPIConfigTVC.h
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDUI.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDAPIConfigTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *encSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sslSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *staticSwitch;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *endpointTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *authTypeControl;
- (IBAction)didChangeAuthTypeControl:(id)sender;

@end

NS_ASSUME_NONNULL_END
