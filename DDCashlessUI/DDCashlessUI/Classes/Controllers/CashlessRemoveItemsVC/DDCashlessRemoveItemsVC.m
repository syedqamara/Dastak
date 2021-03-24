//
//  DDCashlessRemoveItemsVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 19/03/2020.
//

#import "DDCashlessRemoveItemsVC.h"
#import "DDCashlessRemoveItemTVC.h"

@interface DDCashlessRemoveItemsVC () <UITableViewDelegate, UITableViewDataSource, DDCashlessRemoveItemTVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSMutableArray* itemsArray;

@end

@implementation DDCashlessRemoveItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    if (![self.navigation.routerModel.data isKindOfClass:[NSArray<DDCashlessItemM*> class]]) {
        [self goBackWithCompletion:nil];
        return;
    }
    self.itemsArray =(NSMutableArray<DDCashlessItemM*>*)self.navigation.routerModel.data;
    if (self.itemsArray.count > 0) {
        DDCashlessItemM *deleteAllItem = [DDCashlessItemM new];
        deleteAllItem.itemName = DELETE_All;
        [self.itemsArray addObject:deleteAllItem];
    }
    [self setupTableView];
}

-(void)setupNavigation {
    self.title = @"Remove item".localized;
    UIColor *color = DDCashlessThemeManager.shared.selected_theme.text_theme.colorValue;
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:color direction:(DDNavigationItemDirectionLeft)];
    [self addNavigationItemWithTitle:DONE identifier:DONE tintColor:color direction:(DDNavigationItemDirectionRight)];
}

- (void)designUI {
    
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    [self.navigation.routerModel sendDataCallback:sender.identifier withData:nil withController:self];
}

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[CashlessRemoveItemTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessRemoveItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessRemoveItemTVC forIndexPath:indexPath];
    DDCashlessItemM *item = [self.itemsArray objectAtIndex:indexPath.row];
    [cell setData:item];
    cell.delegate = self;
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}


#pragma mark - Delegate
- (void)deleteItem:(DDCashlessItemM *)item atIndex:(NSInteger)index {
    [DDBasket.shared.currentOrder removeSingleProductAgainstLocalStoredId:item];
    [self.itemsArray removeObjectAtIndex:index];
    [self.tableView reloadData];
}

- (void)deleteAllItems {
    __weak typeof(self) weakSelf = self;
    [DDAlertUtils showAlertWithTitle:@"" subtitle:DELETE_ALL_WARNING.localized buttonNames:@[CANCEL, CONTINUE] onClick:^(int index) {
        if (index == 1) {
            [DDBasket.shared.currentOrder removeSelectedCustomizedProductsAgainstProduct:weakSelf.itemsArray.firstObject];
            [weakSelf.navigation.routerModel sendDataCallback:DONE withData:nil withController:weakSelf];
        }
    }];

}

@end
