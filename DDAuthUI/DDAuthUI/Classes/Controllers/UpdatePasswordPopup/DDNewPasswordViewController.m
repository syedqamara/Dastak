//
//  DDNewPasswordViewController.m
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 20/02/2020.
//  Copyright © 2020 dynamicdelivery. All rights reserved.
//

#import "DDNewPasswordViewController.h"

#import "DDRegexTableViewCell.h"
#import "DDUserManager.h"
#import <IQKeyboardManager.h>
#import "DDRegexTableViewCell2.h"
#import "DDAuthUIManager.h"
#import "DDAuth.h"
#import "DDAuthUIThemeManager.h"

#define REGEX_ROW_HEIGHT 20

@interface DDNewPasswordViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *crossImageView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordConfirmTF;
@property (weak, nonatomic) IBOutlet UIButton *updatePasswordButton;

@end

@implementation DDNewPasswordViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTransparentNavigationBar];
    self.passwordTF.delegate = self;
    self.confirmPasswordTF.delegate = self;
    [self.passwordTF setSecureTextEntry:YES];
    [self.confirmPasswordTF setSecureTextEntry:YES];
    [self.tableView registerCellWithNibNames:@[@"DDRegexTableViewCell", @"DDRegexTableViewCell2"] forClass:self.class withIdentifiers:@[@"DDRegexTableViewCell", @"DDRegexTableViewCell2"]];
    
    CGFloat tableHeight = 0;
    self.tableViewHeight.constant = tableHeight;
    [self.view layoutIfNeeded];
    

    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    [self.passwordTF addTarget:self action:@selector(passwordTextDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.confirmPasswordTF addTarget:self action:@selector(passwordTextDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self addNavigationItemWithTitle:@"Close".localized identifier:@"close" tintColor:AUTH_THEME.app_theme.colorValue direction:(DDNavigationItemDirectionRight)];
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [self didTapCloseButton:nil];
}
-(void)designUI {
    self.titleLabel.text = @"Set a new password".localized;
    self.subTitleLabel.text = @"Make sure it’s 8 characters or more.".localized;
    self.passwordTF.placeholder = @"Password".localized;
    self.confirmPasswordTF.placeholder = @"Confirm Password".localized;
    [self.updatePasswordButton setTitle:@"UPDATE".localized forState:UIControlStateNormal];
    [self.updatePasswordButton setTitleColor:AUTH_THEME.text_white.colorValue forState:UIControlStateNormal];
    self.updatePasswordButton.backgroundColor = AUTH_THEME.app_theme.colorValue;
    
    self.crossImageView.tintColor = AUTH_THEME.text_black_40.colorValue;
    self.passwordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.confirmPasswordTF.textColor = AUTH_THEME.text_black_40.colorValue;
    self.popupView.backgroundColor = AUTH_THEME.bg_white.colorValue;
    self.titleLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.subTitleLabel.textColor = AUTH_THEME.text_black_40.colorValue;
    self.crossImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icCloseRounded.png"];
    
    self.titleLabel.font = [UIFont DDBoldFont:28];
    self.subTitleLabel.font = [UIFont DDRegularFont:15];
    self.passwordTF.font = [UIFont DDRegularFont:17];
    self.confirmPasswordTF.font = [UIFont DDRegularFont:17];
    self.updatePasswordButton.titleLabel.font = [UIFont DDBoldFont:17];
    
    [self.showPasswordTF setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"eye"] forState:UIControlStateNormal];
    [self.showPasswordTF setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross_eye"] forState:UIControlStateSelected];
    
    [self.showPasswordConfirmTF setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"eye"] forState:UIControlStateNormal];
    [self.showPasswordConfirmTF setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"cross_eye"] forState:UIControlStateSelected];
    
    self.updatePasswordButton.cornerR = 12;
    self.updatePasswordButton.clipsToBounds = YES;
    
    [self checkSendButtonColor];
}
-(void)checkSendButtonColor {
    if ([self isAllValid]) {
        self.updatePasswordButton.enabled = YES;
        [self.updatePasswordButton setTitleColor:AUTH_THEME.text_white.colorValue forState:UIControlStateNormal];
    }else {
        self.updatePasswordButton.enabled = NO;
        [self.updatePasswordButton setTitleColor:[AUTH_THEME.text_white.colorValue colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager.sharedManager setEnable:NO];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager.sharedManager setEnable:YES];
}
-(void)animateAndDismiss {
    [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)didTapCloseButton:(id)sender {
    [self animateAndDismiss];
}
- (IBAction)didTapSendButton:(id)sender {
    if ([self isAllValid]) {
        
    }
}
-(void)passwordTextDidChange:(UITextField *)textField {
    if (textField == self.passwordTF) {
        NSString *text = textField.text;
        
        [self.tableView reloadData];
    }
    [self checkSendButtonColor];
}

- (IBAction)passwordEyeBtnAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 1){
        sender.selected ? (self.passwordTF.secureTextEntry = NO):(self.passwordTF.secureTextEntry = YES);
        [self.showPasswordTF setSelected:sender.selected];
    }else {
        sender.selected ? (self.confirmPasswordTF.secureTextEntry = NO):(self.confirmPasswordTF.secureTextEntry = YES);
        [self.showPasswordConfirmTF setSelected:sender.selected];
    }
}

#pragma TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft ? @"DDRegexTableViewCell2" : @"DDRegexTableViewCell";
    DDRegexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    [cell setData:@""];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return REGEX_ROW_HEIGHT;
}
-(BOOL)isAllValid {
    BOOL isValidPassword = NO;
    BOOL isValidCPassword = [self.passwordTF.text isEqualToString:self.confirmPasswordTF.text];
    return isValidPassword && isValidCPassword;
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_New_Password andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
