//
//  DDSmilesViewController.m
//  DDAccountsUI
//
//  Created by M.Jabbar on 19/03/2020.
//

#import "DDSmilesViewController.h"
#import <DDConstants/DDConstants.h>
#import "DDAccountUIThemeManager.h"
#import <DDAccounts/DDAccounts.h>
#import <DDCommons/DDCommons.h>
#import "DDSmilesHeaderTableViewCell.h"
#import "SmilesPackBuyTableViewCell.h"

@interface DDSmilesViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) PSSmilesData *smilesData;
@end

@implementation DDSmilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.title = @"Smiles";

    self.smilesData = [DDAccountManager shared].smiles;
    [self setupTableView];
    if (_smilesData == nil) {
        [self getSmiles];
    }
    [self standardNavigationBar];
}

-(void)designUI{
    [super designUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)setupTableView{
    [self.tableView registerCell:@{@"DDSmilesHeaderTableViewCell":@"DDSmilesHeaderTableViewCell",@"SmilesPackBuyTableViewCell":@"SmilesPackBuyTableViewCell"} forClass:self.class];
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

-(void)getSmiles{
    __weak typeof(self) weakSelf = self;
    [UIApplication showDDLoaderAnimation];
    [[DDAccountManager shared] getSmiles:@{} completion:^(PSSmilesData * _Nullable model, NSString * _Nullable error) {
        [UIApplication dismissDDLoaderAnimation];
        if (model) {
            weakSelf.smilesData = [DDAccountManager shared].smiles;
            [weakSelf.tableView reloadData];
        }
    }];
}

-(void)buyPack:(UIButton*)buyButton{
    PSSmiles *smileInfo = self.smilesData.smiles[buyButton.tag];
    NSString *message = [NSString stringWithFormat:@"Use %@ Smiles to buy back %@, Total Smiles:%@ SMILES",smileInfo.smile_points,smileInfo.reward_name, self.smilesData.current_smiles];
    if (self.smilesData.current_smiles.intValue < smileInfo.smile_points.intValue){
        [DDAlertUtils showOkAlertWithTitle:@"Oops".localized subtitle:@"You don't have enough smiles to buy: A set of 10 pings. Keep saving to earn more smiles".localized completion:^{
        }];
    } else {
        __weak typeof(self) weakSelf = self;
        [DDAlertUtils showAlertWithTitle:@"Total Smiles" subtitle:message buttonNames:@[CANCEL, @"Buy"] highlightedAt:1 onClick:^(int index) {
            if (index == 1) {
                [weakSelf sendPurchaseRequest:smileInfo];
            }
        }];
    }
    
}

-(void) sendPurchaseRequest:(PSSmiles *) smile{
    
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *paramsMand = [[NSMutableDictionary alloc] initWithDictionary:smile.apiparams];
    [paramsMand setValue:smile.smile_points forKey:@"points"];
    
    [[DDAccountManager shared] purchaseSmilesPack:paramsMand completion:^(DDBuyPingsApiDataM * _Nullable model, NSError * _Nullable error) {
        if (error == nil){
            if (model.success && model.success.boolValue) {
                 [weakSelf getSmiles];
                NSString *message = [NSString stringWithFormat:@"%@:\nYour new balance smiles:%d",model.message,self.smilesData.current_smiles.intValue - smile.smile_points.intValue];
                [DDAlertUtils showOkAlertWithTitle:@"Success".localized subtitle:message completion:^{
                }];
            } else {
                [DDAlertUtils showOkAlertWithTitle:@"Oops".localized subtitle:model.message completion:^{
                }];
            }
        }else{
            [DDAlertUtils showOkAlertWithTitle:@"Oops".localized subtitle:error.localizedDescription completion:^{
            }];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.smilesData ? self.smilesData.smiles.count + 1 :  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = indexPath.row == 0 ? @"DDSmilesHeaderTableViewCell" : @"SmilesPackBuyTableViewCell";
    DDBaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (indexPath.row == 0) {
        [cell setData:self.smilesData];
    }else{
        [cell setData:self.smilesData.smiles[indexPath.row-1]];
    }
    if ([cell isKindOfClass:[SmilesPackBuyTableViewCell class]]) {
        SmilesPackBuyTableViewCell *cells = (SmilesPackBuyTableViewCell*)cell;
        cells.buyButton.tag = indexPath.row-1;
        [cells.buyButton addTarget:self action:@selector(buyPack:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectionStyle = UITableViewScrollPositionNone;
    return cell;
}
@end
