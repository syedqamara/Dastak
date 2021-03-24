//
//  DDSavingsViewController.m
//  DDAccountsUI
//
//  Created by Zubair Ahmad on 01/04/2020.
//

#import "DDSavingsViewController.h"
#import <DDConstants/DDConstants.h>
#import "DDAccountUIThemeManager.h"
#import <DDAccounts/DDAccounts.h>
#import <DDCommons/DDCommons.h>
#import "HACBarChart.h"
#import "DDAuthUIThemeManager.h"
#import <DDUI/DDUI.h>

#define FILTER_BY_MONTH @"by_month"
#define FILTER_BY_YEAR @"by_year"

@interface DDSavingsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *graphData;
    NSString *selectedFilterType;

}
@property (weak, nonatomic) IBOutlet DDUIBaseView *emptyView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (weak, nonatomic) IBOutlet UILabel *emptyViewLabel;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *familyCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet DDMenuCollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet HACBarChart *graphView;
@property (nonatomic) IBOutlet UISwitch * familySwitch;
@property (weak, nonatomic) IBOutlet UIView *totalSavingsView;
@property (weak, nonatomic) IBOutlet UILabel *totalSavingsLabel;

@property (weak, nonatomic) IBOutlet UILabel *viewFamilySavingsLabel;

@property (nonatomic) DDSavingsApiDataM * savingsData;
@property (nonatomic) DDMonthsData * selectedMenuItem;

@property (nonatomic) DDSavingsDetailAPIData *savingsMonthly;
@property (nonatomic) DDSavingsDetailAPIData *savingsYearly;

@property (nonatomic) NSMutableArray *familyMembers;
@property (strong, nonatomic) NSString *apiErrorMessage;
@end

@implementation DDSavingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.titleView = self.segmentControl;
//    self.selectedMenuItem = [[DDMonthsData alloc] init];
    graphData = [[NSMutableArray alloc] initWithArray: @[]];
    self.familyMembers = [[NSMutableArray alloc] initWithArray: @[]];
   
    // Show axis line
    _graphView.showAxis                 = NO;
    // Show text for bar
    _graphView.showProgressLabel        = YES;
    // Orientation chart
    _graphView.vertical                 = YES;
    // Show value contains _data, or real percent value
    _graphView.showDataValue            = YES;
    // Show custom text, in _data with key kHACCustomText
    _graphView.showCustomText           = YES;
    // Margin between bars
    
    _graphView.barsMargin               = 20;
    _graphView.barWidth = 50;
    
    _graphView.typeBar = HACBarType2;
    
    _graphView.progressTextColor        = [UIColor blackColor];
    //
    _graphView.progressTextFont         = [UIFont DDBoldFont:12];
    
    _graphView.data = graphData;
    
    self.menuCollectionView.selectedItem = ^(DDMonthsData * _Nonnull item) {
        if ([item isEnabled] && self.selectedMenuItem != nil && self.selectedMenuItem.month != item.month) {
            self.selectedMenuItem = item;
            if ([self->_familySwitch isOn]) {
                [self refreshData];
            }else{
                self.selectedMenuItem = item;
                if (self.segmentControl.selectedSegmentIndex == 0) {
                    [self loadSavings:self.savingsMonthly];
                }else{
                    [self loadSavings:self.savingsYearly];
                }
            }
        }else if (self.selectedMenuItem == nil){
            self.selectedMenuItem = item;
            [self refreshData];
        }
    };
    [self setupCollectionView];
    [self.menuCollectionView loadMonths];
    [self setupEmptyView];
    [self standardNavigationBar];
}

-(void)designUI{
    [super designUI];
    
    self.viewFamilySavingsLabel.font = [UIFont DDRegularFont:15];
    self.totalSavingsView.backgroundColor =  DDAuthUIThemeManager.shared.selected_theme.bg_grey_240.colorValue;
    self.totalSavingsLabel.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black.colorValue;
    self.totalSavingsLabel.font = [UIFont DDMediumFont:13];
    [self.familySwitch setTintColor:DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue];
    self.menuCollectionView.backgroundColor = [@"#2f85fe".colorValue colorWithAlphaComponent:0.1];
    
    self.segmentControl.layer.borderColor = DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue.CGColor;
    self.segmentControl.layer.borderWidth = 1;
    [self.segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont DDMediumFont:15]} forState:(UIControlStateNormal)];
    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue} forState:(UIControlStateNormal)];
    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue} forState:(UIControlStateSelected)];

    [self.familySwitch setOnTintColor:DDAuthUIThemeManager.shared.selected_theme.app_theme.colorValue];
    [self.segmentControl setTintColor:DDAuthUIThemeManager.shared.selected_theme.text_white.colorValue];
    
    self.emptyViewLabel.font = [UIFont DDMediumFont:17];
    self.emptyViewLabel.textColor = DDAuthUIThemeManager.shared.selected_theme.text_black.colorValue;

    [self updateDesign];
}
-(void)setupCollectionView{
    
    [self.collectionView registerCellWithNibNames:@[@"DDSavingsMembersCollectionViewCell"] forClass:self.class withIdentifiers:@[@"DDSavingsMembersCollectionViewCell"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}
-(void)resetUI{
    [_graphView clearChart];
    [self updateTotalSavings:0.0 currency:[DDUserManager shared].currentUser.currency];
}
-(void)setupEmptyView{
    if (self.apiErrorMessage.length) {
        self.emptyViewLabel.text = self.apiErrorMessage;
    }
    else {
        self.emptyViewLabel.text = [NSString stringWithFormat:@"You don't have saving in this %@",self.segmentControl.selectedSegmentIndex == 0 ? @"month" : @"year"].localized;
    }
    self.emptyImageView.image = [NSBundle loadImageFromResourceBundlePNG:DDUIBaseView.class imageName:@"noBookingsPromo"];
}
-(void)reloadFamilyCollectionView{
    __weak __typeof(self) weakSElf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.familySwitch.isOn && self.familyMembers.count > 0) {
            self.familyCollectionViewHeightConstraint.constant = MAX((self.familyMembers.count / 2)  * 26, 26) ;
        }else{
            self.familyCollectionViewHeightConstraint.constant = 0;
        }
    });
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSElf.collectionView reloadData];
        [weakSElf.graphView draw];
    });
    
}
-(void)updateDesign{
    self.totalSavingsView.layer.cornerRadius = self.totalSavingsView.frame.size.height / 2;
    self.totalSavingsView.clipsToBounds = YES;
}
-(void)updateTotalSavings:(long)totalSavings currency:(NSString*)currency{
    NSString *totalString = [NSString stringWithFormat:@"%ld %@",(long)totalSavings, currency ?: @"AED"];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Total Savings\n%@",totalString]];
    
    [attributedText addAttribute:NSFontAttributeName value: [UIFont DDRegularFont:13]   forString:@"Total Savings"];
    [attributedText addAttribute:NSFontAttributeName value: [UIFont DDBoldFont:20]   forString:totalString];
    self.totalSavingsLabel.attributedText = attributedText;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self refreshData];
    
}

-(void) refreshData{
    if (self.segmentControl.selectedSegmentIndex == 0) {
        selectedFilterType = FILTER_BY_MONTH;

    }else{
        selectedFilterType = FILTER_BY_YEAR;
    }
    [self getSavingsData:selectedFilterType];
//    [self getSavingsData:FILTER_BY_YEAR];
}

-(void)getSavingsData:(NSString *) filterType{
    
    __weak __typeof(self) weakSElf = self;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:filterType forKey:@"summary_type"];
    [parameters setValue:@([self.familySwitch isOn]).stringValue forKey:@"include_family_savings"];
   
    [DDUserManager shared].currentUser.currency = @"AED";
//    if ([filterType isEqualToString: FILTER_BY_MONTH]) {
//        [parameters setValue:[self.familySwitch isOn] ? @"savingmonthfamily":@"savingmonthly" forKey:@"end"];
//    }else{
//        [parameters setValue:@"yearlyresponse" forKey:@"end"];
//    }
    
    if ([self.familySwitch isOn]) {
        if ([filterType isEqualToString: FILTER_BY_MONTH]) {
            [parameters setValue:self.selectedMenuItem.index forKey:@"month_number"];
        }else{
            [parameters setValue:self.selectedMenuItem.month forKey:@"year_number"];
        }
    }
    
    [[DDAccountManager shared] getSavings:parameters completion:^(DDSavingsDetailAPIData * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [UIApplication dismissDDLoaderAnimation];
        if (model) {
            weakSElf.apiErrorMessage = @"";
            if ([filterType isEqualToString:FILTER_BY_MONTH]) {
                weakSElf.savingsMonthly = model;
            }else{
                weakSElf.savingsYearly = model;
            }
            if (weakSElf.segmentControl.selectedSegmentIndex == 0) {
                [weakSElf loadSavings: weakSElf.savingsMonthly];
            }else{
                [weakSElf loadSavings: weakSElf.savingsYearly];
            }
        }
        else {
            weakSElf.apiErrorMessage = error.localizedDescription;
            if (weakSElf.apiErrorMessage.length == 0) weakSElf.apiErrorMessage = SOMETHING_WDD_WRONG;
            [DDAlertUtils showOkAlertWithTitle:@"Error" subtitle:weakSElf.apiErrorMessage completion:nil];
            [weakSElf setupEmptyView];
            [weakSElf.emptyView setHidden:NO];
        }
    }];
}
//MARK:- Add missing months or years items that are not comming from server.
-(NSArray*)addMissingMonthsOrYearsFor:(NSArray*)saving{
    
    NSMutableArray *totalSavings = [[NSMutableArray alloc] init];
    totalSavings =  [totalSavings arrayByAddingObjectsFromArray:saving].mutableCopy;
    
    for (DDMonthsData *menuItem in self.menuCollectionView.monthMenuArray) {
        if ([menuItem isEnabled]) {
            DDSavingsProgressData *savingItem = [totalSavings filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                DDSavingsM *savings = (DDSavingsM*)evaluatedObject;
                return [savings.name.lowercaseString hasPrefix:[menuItem.month componentsSeparatedByString:@"\n"].firstObject.lowercaseString];
            }]].firstObject;
            
            if (savingItem) {
               
                savingItem.index = menuItem.index;

            }else{
              
                DDSavingsProgressData *item = [[DDSavingsProgressData alloc] init];
                item.currency = [DDUserManager shared].currentUser.currency;
                item.name = [menuItem.month componentsSeparatedByString:@"\n"].firstObject;
                item.total_savings = @(0);
                item.savings = @(0);
                item.index = menuItem.index;
                [totalSavings addObject:item];
            }
        }
    }
    return [totalSavings sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        DDSavingsProgressData *item1 = (DDSavingsProgressData*)obj1;
        DDSavingsProgressData *item2 = (DDSavingsProgressData*)obj2;
        return item1.index.intValue > item2.index.intValue;
    }];
}
//MARK:- Draw graph on base of seleccted menu item either its months or years.

-(void)loadSavings:(DDSavingsDetailAPIData*)saving{
    
    float totalSavings = 0.0;
    
    [self.emptyView setHidden:YES];

    
    graphData = [[NSMutableArray alloc] init];
    self.familyMembers = [[NSMutableArray alloc] init];
    [_graphView clearChart];
    if([self.familySwitch isOn]){
        if (saving.graph_members.count == 0) {
            [self setupEmptyView];
            [self.emptyView setHidden:NO];
            return;
        }
        for (DDSavingsGraphDataSection *savings in saving.graph_members) {
            DDSavingsGraphData *graphDataValues = savings.graph_data.firstObject;
            if (graphDataValues) {
                totalSavings += graphDataValues.value.floatValue;
                [graphData addObject:@{kHACSelected: @(0), kHACPercentage:graphDataValues.value, kHACColor  : savings.line_color.colorValue, kHACCustomText : [NSString stringWithFormat:@"%@\n%@",graphDataValues.value,graphDataValues.currency]}];
                [self.familyMembers addObject:savings];
            }
        }
       
    }else{
        if (saving.progress_data.count == 0) {
            [self setupEmptyView];
            [self.emptyView setHidden:NO];
            return;
        }
        for (DDSavingsProgressData *savings in [self addMissingMonthsOrYearsFor:saving.progress_data.mutableCopy]) {
            totalSavings =  savings.total_savings.floatValue;
            if (totalSavings <= 0.0){
                totalSavings = saving.life_time_saving.floatValue;
            }
            BOOL isCurrnetMonth = [savings.name.lowercaseString hasPrefix:[self.selectedMenuItem.month componentsSeparatedByString:@"\n"].firstObject.lowercaseString];
           
            [graphData addObject:@{kHACSelected: @(isCurrnetMonth),kHACPercentage:savings.savings, kHACColor  : isCurrnetMonth ?  @"01a4a4".colorValue : @"c7c7c7".colorValue, kHACCustomText : [NSString stringWithFormat:@"%@\n%@",savings.savings,savings.currency]}];
            
        }
    }
    
    [self  updateTotalSavings:totalSavings currency:saving.currency];
   
    self.graphView.data = graphData;
    [self  updateDesign];
    [self reloadFamilyCollectionView];
}

//MARK: - CollectionView Delegate and DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.familyMembers.count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DDUIThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDSavingsMembersCollectionViewCell" forIndexPath:indexPath];
    [cell setData:self.familyMembers[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.width/2 - self.collectionView.layoutMargins.left, 26);
}

-(IBAction)switchValuesChanged:(UISwitch*)sender {
    [self resetUI];
    [self refreshData];
}
- (IBAction)segemntSelectionChnage:(UISegmentedControl*)sender {
    [self resetUI];
    if (sender.selectedSegmentIndex == 0) {
        selectedFilterType = FILTER_BY_MONTH;
        [self.menuCollectionView loadMonths];
    }else{
        selectedFilterType = FILTER_BY_YEAR;
        [self.menuCollectionView loadYears:[[DDUserManager shared].currentUser.user_creation_date componentsSeparatedByString:@"-"].firstObject];

    }
}

+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *route = [[DDUIRouterM alloc]init];
    route.route_link = DD_Nav_Accounts_Savings_Detail;
    route.should_embed_in_nav = YES;
    route.transition = DDUITransitionPush;
    route.is_animated = YES;
    route.auth_permission = DDUIRouterAuthPermissionTypeAsk;
    return @[route];
}


@end
