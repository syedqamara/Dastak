//
//  DDPurchaseProductsHistoryVC.m
//  DDProductsUI
//
//  Created by M.Jabbar on 26/03/2020.
//

#import "DDPurchaseProductsHistoryVC.h"
#import <DDProducts/DDProducts.h>
#import "DDProductsPurchaseHistorySectionView.h"

@interface DDPurchaseProductsHistoryVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) DDProductPurchaseApiDataM *purchaseSections;

@end

@implementation DDPurchaseProductsHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Products".localized;
    [self loadPurchseHistory];
    [self setupTableView];
}
-(void)setupTableView{
    [self.tableView registerCell:@{@"hitory":@"DDPurchaseProductsHistoryTableViewCell"} forClass:self.class];
    [self.tableView registerHeaderFooterWithNibNames:@[@"DDProductsPurchaseHistorySectionView"] forClass:[self class] withIdentifiers:@[@"DDProductsPurchaseHistorySectionView"]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 60;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}
-(void)loadPurchseHistory{
    
    __weak typeof(self) weakSelf = self;

    DDBaseRequestModel *model = [[DDBaseRequestModel alloc] init];
    [DDProductManager loadProductsWithModel:model withCompletion:^(DDProductPurchaseApiDataM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakSelf.purchaseSections = model;
        [weakSelf reloadData];
    }];
}
-(void)reloadData{
    DDProductPurchaseSectionM  *firstItem = self.purchaseSections.products.firstObject;
    firstItem.isCollapsed = @(!firstItem.collapsed);
    [self.tableView reloadData];
}
-(IBAction)openSection:(UIButton*)sender{
    DDProductPurchaseSectionM  *firstItem = self.purchaseSections.products[sender.tag];
    firstItem.isCollapsed = @(!firstItem.collapsed);
    [self.tableView reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.purchaseSections.products.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DDProductPurchaseSectionM *sections = self.purchaseSections.products[section];
    return sections.collapsed  ? 0 : sections.products.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DDProductPurchaseSectionM *sections = self.purchaseSections.products[indexPath.section];
    DDBaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"hitory"];
    [cell setData:sections.products[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDProductPurchaseSectionM *sectionInfo = self.purchaseSections.products[section];
        DDProductsPurchaseHistorySectionView *sectionView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDProductsPurchaseHistorySectionView"];
        if (sectionView) {
            [sectionView setData:sectionInfo];
        }
    sectionView.seeAllButton.tag = section;
    [sectionView.seeAllButton addTarget:self action:@selector(openSection:) forControlEvents:UIControlEventTouchUpInside];
        return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 50;
}
@end
