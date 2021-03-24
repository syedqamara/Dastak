//
//  DDFormViewController.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDFormViewController.h"
#import "DDFormCollectionM.h"
#import "DDFormTVC.h"
#import "DDGradientButton.h"

#define CELL_DEFAULT_HEIGHT 63
#define FOOTER_DEFAULT_HEIGHT 120

@interface DDFormViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    DDGradientButton *submitButton;
}
@property (strong, readonly) DDFormCollectionM *input;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DDFormViewController
-(DDFormCollectionM *)input {
    return self.navigation.routerModel.data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.input.title;
    [self.tableView setAlwaysBounceVertical:NO];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerCells:@[@"DDFormTVC"] forClass:self.class];
    [self.tableView reloadData];
    [self.tableView setAllowsSelection:NO];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.input.allForms.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFormTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DDFormTVC"];
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    [cell.textField addTarget:self action:@selector(didChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    [cell setData:self.input.allForms[indexPath.row]];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, FOOTER_DEFAULT_HEIGHT)];
    if (submitButton == nil) {
        submitButton = [DDGradientButton.alloc initWithFrame:CGRectMake(15, 35, self.view.frame.size.width - 30, 50)];
        [submitButton addTarget:self action:@selector(didTapSubmit:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    submitButton.overlayColor = THEME.bg_white.colorValue;
    submitButton.overlayAlpha = 0.3;
    submitButton.titleLabel.font = [UIFont DDSemiBoldFont:17];
    [submitButton setTitleColor:THEME.text_white.colorValue forState:(UIControlStateNormal)];
    [submitButton.layer setCornerRadius:14];
    [submitButton setClipsToBounds:YES];
    [submitButton setTitle:self.input.submitButtonTitle forState:(UIControlStateNormal)];
    submitButton.showOverlay = !self.input.isAllRequiredInputGiven;
    [view addSubview:submitButton];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return FOOTER_DEFAULT_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FOOTER_DEFAULT_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}
-(void)didTapSubmit:(UIButton *)button {
    for (DDFormM *form in self.input.allForms) {
        [form updateValue];
    }
    [self.view endEditing:YES];
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
    }];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self panTransiotionToFullScreen];
}
-(void)didChangeText:(UITextField *)textField {
    DDTextFormM *form = (DDTextFormM *)self.input.allForms[textField.tag];
    if (form != nil) {
        form.edit_value = textField.text;
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->submitButton.showOverlay = !self.input.isAllRequiredInputGiven;
    });
    return YES;
}
-(CGFloat)dragableHeight {
    return (self.input.allForms.count * CELL_DEFAULT_HEIGHT) + FOOTER_DEFAULT_HEIGHT + 50;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
