//
//  DDPopupOptionVC.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/06/2020.
//

#import "DDPopupOptionVC.h"
#import "DDPopupOptionVM.h"
#import "DDPopupOptionTVC.h"

@interface DDPopupOptionVC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) DDPopupVM *popup;
@end

@implementation DDPopupOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popup = (DDPopupVM *)self.navigation.routerModel.data;
    self.searchBar.placeholder = self.popup.search_placeholder;
    self.searchBar.delegate = self;

    [self.searchBar.superview setHidden:self.popup.search_placeholder.length == 0];
    self.navigationItem.title = self.popup.title;
    [self.tableView registerCellWithNibNames:@[@"DDPopupOptionTVC"] forClass:DDPopupOptionTVC.class withIdentifiers:@[@"DDPopupOptionTVC"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self filterByText:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.popup.filtered_options.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDPopupOptionVM *option = self.popup.filtered_options[indexPath.row];
    DDPopupOptionTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDPopupOptionTVC"];
    [cell setData:option];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDPopupOptionVM *option = self.popup.filtered_options[indexPath.row];
    return option.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDPopupOptionVM *option = self.popup.filtered_options[indexPath.row];
    option.isSelected = YES;
    [self.navigation.routerModel sendDataCallback:@"CUSTOM" withData:option.object withController:self];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterByText:searchText];
}
-(void)filterByText:(NSString *)searchText {
    if (searchText.length == 0) {
        self.popup.filtered_options = self.popup.options;
    }else {
        NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(DDPopupOptionVM   * _Nullable  evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.titleLabelLeft.lowercaseString containsString:searchText.lowercaseString]) {
                return YES;
            }
            if ([evaluatedObject.titleLabelRight.lowercaseString containsString:searchText.lowercaseString]) {
                return YES;
            }
            return NO;
        }];
        self.popup.filtered_options = [self.popup.options filteredArrayUsingPredicate:pred].mutableCopy;
    }
    [self.tableView reloadData];
}
-(CGFloat)dragableHeight {
    CGFloat panHeight = self.popup.panHeight;
    if (self.popup.search_placeholder.length > 0) {
        panHeight += 50;
    }
    return panHeight;
}
-(void)panIsBeingDismissed{
    [self.navigation.routerModel sendDataCallback:nil withData:nil withController:self];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self panTransiotionToFullScreen];
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
