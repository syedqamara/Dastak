//
//  DDCheersConfirmationView.m
//  DDUI
//
//  Created by Zubair Ahmad on 20/04/2020.
//

#import "DDCheersConfirmationView.h"
#import "DDUserManager.h"
@interface DDCheersConfirmationView ()

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *lblMessageTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblNo;
@property (nonatomic, strong) IBOutlet UILabel *lblYes;
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;
@property (nonatomic, strong) IBOutlet UIButton *btnDone;

@end

@implementation DDCheersConfirmationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Cheers_Popup andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
