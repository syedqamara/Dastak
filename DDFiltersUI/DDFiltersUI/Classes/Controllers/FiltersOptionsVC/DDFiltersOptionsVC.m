//
//  DDFiltersOptionsVC.m
//  The Entertainer
//
//  Created by Raheel on 23/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDFiltersOptionsVC.h"
#import "DDFilterOptionsTVC.h"

@interface DDFiltersOptionsVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIButton *resetBtn;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIButton *closeBtn;
@property (nonatomic, weak) IBOutlet UIButton *bottomBtn;
@property (nonatomic, weak) IBOutlet UIView *searchView;
@property (nonatomic, weak) IBOutlet UITextField *searchTxtField;
@property (nonatomic, weak) IBOutlet UIImageView *searchIcon;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *itemsList;
@property (nonatomic, strong) DDFiltersSectionM *section;
@property (nonatomic, strong) NSMutableArray *previousStatus;

@end

@implementation DDFiltersOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.navigation.routerModel.data isKindOfClass:[DDFiltersSectionM class]]) {
        [self goBackWithCompletion:nil];
        return;
    }
    self.section = self.navigation.routerModel.data;
    self.itemsList = self.section.options.mutableCopy;
    [self savePreviousStatus];
    [self setupTableview];
    [self.searchTxtField addTarget:self action:@selector(editingChanged:) forControlEvents:(UIControlEventEditingChanged)];
}

-(void)savePreviousStatus {
    self.previousStatus = [NSMutableArray new];
    for (int i=0; i<self.section.options.count; i++) {
        DDFiltersOptionM *option = [self.itemsList objectAtIndex:i];
        [self.previousStatus addObject:option.selected];
    }
}

-(void)designUI {
    
    self.titleLbl.text = self.section.section_title;
    self.resetBtn.titleLabel.font = [UIFont DDMediumFont:17];
    [self.resetBtn setTitle:RESET.localized forState:(UIControlStateNormal)];
    [self.resetBtn setTitleColor:DDFiltersThemeManager.shared.selected_theme.text_theme.colorValue forState:(UIControlStateNormal)];
    
    [self.closeBtn loadImageWithStringWithoutTemplate:@"filter_close.png" forClass:self.class];
    [self.closeBtn setTintColor:DDFiltersThemeManager.shared.selected_theme.bg_grey_199.colorValue];
    
    self.titleLbl.font = [UIFont DDBoldFont:17];
    self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.searchView.cornerR = 12;
    self.searchView.borderW = 0.5;
    self.searchView.borderColor = DDFiltersThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.searchView.clipsToBounds = YES;
    
    self.searchTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTxtField.placeholder = SEARCH.localized;
    self.searchTxtField.font = [UIFont DDRegularFont:17];
    [self.searchIcon loadImageWithString:@"icSearch.png" forClass:self.class];
    
    [self.bottomBtn setTitle:APPLY.localized forState:UIControlStateNormal];
    [self.bottomBtn setTitleColor:DDFiltersThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundColor:DDFiltersThemeManager.shared.selected_theme.app_theme.colorValue];
    self.bottomBtn.cornerR = 12;
    self.bottomBtn.clipsToBounds = YES;
    self.bottomBtn.titleLabel.font = [UIFont DDBoldFont:17];
    
    [self setStatusBarStyle:(UIStatusBarStyleDefault)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - tableView

-(void)setupTableview {
    [self.tableView registerCellWithNibNames:@[FilterOptionsTVC] forClass:self.class withIdentifiers:@[FilterOptionsTVC]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = FALSE;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDFilterOptionsTVC *cell = [tableView dequeueReusableCellWithIdentifier:FilterOptionsTVC];
    DDFiltersOptionM* filters = self.itemsList[indexPath.row];
    [cell setData:filters];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDFiltersOptionM* filters = self.itemsList[indexPath.row];
    [filters toggleSelection];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - IBActions

-(void)editingChanged:(UITextField*)textField {
    if (textField.text.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", textField.text];
        NSArray *filtered = [self.section.options filteredArrayUsingPredicate:predicate];
        self.itemsList = filtered.mutableCopy;
    }
    else {
        self.itemsList = self.section.options.mutableCopy;
    }
    [self.tableView reloadData];
}

-(IBAction)applyBtnAction:(id)sender {
    [self.navigation.routerModel sendDataCallback:nil withData:self.section withController:self];
    [self goBackWithCompletion:nil];
}

- (IBAction)resetBtnAction:(id)sender {
    for (DDFiltersOptionM *filter in self.section.options) {
        filter.selected = @(0);
    }
    [self editingChanged:self.searchTxtField];
    [self.tableView reloadData];
}

- (IBAction)closeBtnAction:(id)sender {
    for (int i=0; i<self.section.options.count; i++) {
        DDFiltersOptionM *option = [self.itemsList objectAtIndex:i];
        option.selected = [self.previousStatus objectAtIndex:i];
    }
    [self goBackWithCompletion:nil];
}




@end
