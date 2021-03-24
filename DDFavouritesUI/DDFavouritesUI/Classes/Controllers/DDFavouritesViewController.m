//
//  DDFavouritesViewController.m
//  DDFavouritesUI
//
//  Created by Zubair Ahmad on 24/02/2020.
//

#import "DDFavouritesViewController.h"
#import <DDModels/DDModels.h>
#import "DDFavouritesThemeManager.h"
#import "FavouritesTableViewCell.h"
#import <DDFavourites/DDFavourites.h>
#import <DDUI/DDUI.h>
#import <DDCommons/DDCommons.h>
#import "DDFavouritesSectionHeader.h"
#import <DDSocial/DDSocial.h>
#import "DDFavouritesUIManager.h"

@interface DDFavouritesViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate> {
    DDEmptyView *emptyView;
}
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UIView *navigationContainerView;
@property(nonatomic)NSMutableArray <DDFavouritesSectionM> *favorities;

@end

@implementation DDFavouritesViewController

-(UITabBarItem *)tabBarItem {
    return [[UITabBarItem alloc]initWithTitle:@"Favourites" image:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icInactiveFavourites"] tag:2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFavorities) name:REFRESH_FAVOURITES_NOTIFICATION object:nil];
    
    [self registerCells];
    [self designUI];
    [self fetchFavorities];
}

-(void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:REFRESH_FAVOURITES_NOTIFICATION object:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setThemeNavigationBar];
    [self largeNavigationBar];
    self.title = @"Favourites".localized;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadTableView];
}
-(void)designUI{
    [super designUI];
}
-(void)registerCells {
    NSDictionary <NSString *, NSString *> *cells = @{
        @"FavouritesTableViewCell":@"FavouritesTableViewCell"
    };
    [self.tableView registerCell:cells forClass:self.class];
    [self.tableView registerHeaderFooterWithNibNames:@[@"DDFavouritesSectionHeader"] forClass:[self class] withIdentifiers:@[@"DDFavouritesSectionHeader"]];

    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 100;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}
-(void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)fetchFavorities{
    __weak typeof(self) weakSelf = self;
    [[DDFavouritesManager shared] getFavoritiesListAndCompletion:^(DDFavouritesApiM * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self->emptyView removeFromSuperview];
        if (model.data.favourite &&  model.data.favourite.count > 0) {
            weakSelf.favorities = model.data.favourite.mutableCopy;
        }else {
            DDEmptyViewModel *emptyVM = [[DDFavouritesUIManager shared] getEmptyViewModelForNoFavData];
            if (emptyVM != nil) {
                self->emptyView = [DDEmptyView showAndReturnInConatiner:self.tableView withEmptyViewModel:emptyVM completion:nil];
            }
        }
        [weakSelf reloadTableView];
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.favorities.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DDFavouritesSectionM *sectionM = self.favorities[section];
    if (sectionM.is_expandable.boolValue) {
        return sectionM.expended.boolValue ?  sectionM.section_list.count : 0;
    }
    return sectionM.section_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDFavouritesSectionM *sectionM = self.favorities[indexPath.section];
    DDFavouritesSectionListM *item = sectionM.section_list[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    
    FavouritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"FavouritesTableViewCell" forIndexPath:indexPath];
    [cell setData:item];
    cell.callBackFavourite = ^(FavouritesTableViewCell * _Nonnull cell) {
        [weakSelf changeFavourite:cell];
    };
    cell.callBackShare = ^(FavouritesTableViewCell * _Nonnull cell) {
        [weakSelf shareText:cell];
    };
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DDFavouritesSectionM *sectionM = self.favorities[section];

    __weak typeof(self) weakSelf = self;

    DDFavouritesSectionHeader *sectionView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DDFavouritesSectionHeader"];
    if (sectionView) {
        [sectionView setData:sectionM];
        sectionView.expandColapsedButtonTapped = ^(NSInteger sectionTag) {
            DDFavouritesSectionM *sectionM = weakSelf.favorities[sectionTag];
            sectionM.expended = [NSNumber numberWithBool:!sectionM.expended.boolValue];
            [weakSelf.tableView reloadData];
        };
    }
    sectionView.tag = section;
    return sectionView;
}
-(void)changeFavourite:(FavouritesTableViewCell*)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DDFavouritesSectionM *sectionM = self.favorities[indexPath.section];
    DDFavouritesSectionListM *item = sectionM.section_list[indexPath.row];

    __weak typeof(self) weakSelf = self;

    [[DDFavouritesManager shared] markFavoritie:@[item.merchant_id] isFavourite:!item.is_favourite.boolValue needFavRefresh:NO completion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && model.successfulApi) {
            item.is_favourite = @(!item.is_favourite.boolValue);
            [weakSelf fetchFavorities];
            [weakSelf reloadTableView];
        }
    }];
}
-(void)shareText:(FavouritesTableViewCell*)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DDFavouritesSectionM *sectionM = self.favorities[indexPath.section];
    DDFavouritesSectionListM *item = sectionM.section_list[indexPath.row];
    DDSocialShareContent *content = [[DDSocialShareContent alloc] init];
    content.text = item.share_text;
    [[DDSocialManager shared] shareContent:content from:self onNativeShareSheet:^(BOOL completed, NSString * _Nullable message) {
    }];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDFavouritesSectionM *sectionM = self.favorities[indexPath.section];
    DDFavouritesSectionListM *item = sectionM.section_list[indexPath.row];
    DDMerchantDetailRequestM *model = [[DDMerchantDetailRequestM alloc] init];
    [model getReqParams];
    model.outlet_id = [NSNumber numberWithInt:0];
    model.merchant_id = item.merchant_id;
    [[DDFavouritesUIManager shared] showMerchantDetailsFrom:self withModel:model andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
    }];
}
#pragma mark - Helpers
@end
