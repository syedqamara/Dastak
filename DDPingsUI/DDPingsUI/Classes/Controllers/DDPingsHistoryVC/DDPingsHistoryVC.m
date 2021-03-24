//
//  DDPingsHistoryVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 28/01/2020.
//

#import "DDPingsHistoryVC.h"
#import "DDPingsReceivedVC.h"
#import "DDPingsSentVC.h"
#import "UIViewController+DDViewController.h"

@interface DDPingsHistoryVC (){
    NSArray *headerButtonArray;
    NSUInteger selectedButtonIndex;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *headerMessageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbl_MessasgeHeaderView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *headerButtonContainerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonStack;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) DDPingsReceivedVC *receivedVC;
@property (strong, nonatomic) DDPingsSentVC *sentVC;

@end

@implementation DDPingsHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInititals];
    [self setupContainerChildren];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setThemeNavigationBar];
}

-(void)setupInititals {
    self.lbl_MessasgeHeaderView.text = @"";
    self.headerViewHeight.constant = 0;
    headerButtonArray = [[NSArray alloc] initWithObjects:@"Received".localized,@"Sent".localized, nil];
    selectedButtonIndex = 0;
    [self setupHeaderButtons];
}

 // MARK:- Design UI
-(void) designUI {
    
    self.title = [PING_HISTORY_LISTING localized];

    self.view.backgroundColor = DDPingsThemeManager.shared.selected_theme.bg_white.colorValue;
    self.headerMessageView.backgroundColor = [DDPingsThemeManager.shared.selected_theme.app_header_messageBG.colorValue colorWithAlphaComponent:0.1];
    self.lbl_MessasgeHeaderView.font = [UIFont DDMediumFont:15.0];
    self.lbl_MessasgeHeaderView.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.headerButtonContainerView.layer.cornerRadius = 12.0f;
    self.headerButtonContainerView.layer.borderColor = [DDPingsThemeManager.shared.selected_theme.border_theme.colorValue CGColor];
    self.headerButtonContainerView.layer.borderWidth = 1.0f;
    self.headerButtonContainerView.clipsToBounds = YES;
    [self setupHeaderButtons];
    
}
-(void)setupHeaderButtons{
    [_buttonStack enumerateObjectsUsingBlock:^(UIButton  *button, NSUInteger index, BOOL * _Nonnull stop) {
        [button setTitle:[NSString stringWithFormat:@"%@",[headerButtonArray objectAtIndex:index ]] forState:UIControlStateNormal];
        [button setTitleColor:DDPingsThemeManager.shared.selected_theme.text_theme.colorValue forState:UIControlStateNormal];
        [button setTitleColor:DDPingsThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateSelected];
        button.tag = index;
        if (index == selectedButtonIndex){
            [button setBackgroundColor:DDPingsThemeManager.shared.selected_theme.app_theme.colorValue];
            [button setSelected:TRUE];
        }else{
            [button setBackgroundColor:DDPingsThemeManager.shared.selected_theme.bg_white.colorValue];
            [button setSelected:FALSE];
        }
    }];
}

-(void)loadControllers {
    UIViewController *vc = selectedButtonIndex == 0 ? self.receivedVC : self.sentVC;
    [self display:vc];
}

-(IBAction)btnStackAction:(id)sender{
    selectedButtonIndex = [(UIView *)sender tag];
    [self setupHeaderButtons];
    [self loadControllers];
}

#pragma mark - Container

-(void)setupContainerChildren {
    __weak typeof(self) weakSelf = self;
    self.receivedVC = [[DDPingsReceivedVC alloc] initWithNibName:NSStringFromClass(DDPingsReceivedVC.class) forClass:DDPingsReceivedVC.class];
    self.receivedVC.callBackAfterDataLoaded = ^(DDPingSectionModel * _Nonnull model) {
        weakSelf.lbl_MessasgeHeaderView.text = model.message;
        weakSelf.headerViewHeight.constant = model.message.length ? 40 : 0;
        weakSelf.headerMessageView.backgroundColor = model.background_color.colorValue;
    };
    
    self.sentVC = [[DDPingsSentVC alloc] initWithNibName:NSStringFromClass(DDPingsSentVC.class) forClass:DDPingsSentVC.class];
    self.sentVC.callBackAfterDataLoaded = ^(DDPingSectionModel * _Nonnull model) {
       weakSelf.lbl_MessasgeHeaderView.text = model.message;
       weakSelf.headerViewHeight.constant = model.message.length ? 40 : 0;
       weakSelf.headerMessageView.backgroundColor = model.background_color.colorValue;
    };
    [self loadControllers];
}

-(void)display:(UIViewController*)vc {
    [self addChild:vc];
    [(DDPingsBaseVC*)vc loadData];
    if ([vc isKindOfClass:DDPingsReceivedVC.class]) {
        [self removeChild:self.sentVC];
    }
    else {
        [self removeChild:self.receivedVC];
    }
    
}

-(void)addChild:(UIViewController*)child {
    [self addChildViewController:child];
    [self.containerView addSubview:child.view];
    child.view.frame = self.containerView.bounds;
    child.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [child didMoveToParentViewController:self];
}

-(void)removeChild:(UIViewController*)child {
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *ping = [[DDUIRouterM alloc]init];
    ping.route_link = DD_Nav_Pings_History;
    ping.should_embed_in_nav = YES;
    ping.transition = DDUITransitionPush;
//    ping.data = data;
    return @[ping];
}

@end
