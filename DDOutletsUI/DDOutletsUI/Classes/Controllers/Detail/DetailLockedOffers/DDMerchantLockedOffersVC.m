//
//  DDMerchantLockedOffersVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 19/03/2020.
//

#import "DDMerchantLockedOffersVC.h"
#import "DDAmenitiesDetailTVC.h"
#import "DDOutletsUIConstants.h"
#import "DDOfferItemTVC.h"
#import "DDMerchantOffersTableHFV.h"

@interface DDMerchantLockedOffersVC () <UITableViewDelegate,UITableViewDataSource>{
    DDMerchantOffersLocalDataM *viewModel;
    NSMutableArray <DDMerchantOfferM*> *offerSections;
}

@end

@implementation DDMerchantLockedOffersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    offerSections = [NSMutableArray new];
    viewModel  = self.navigation.routerModel.data;
    offerSections = viewModel.section.offers.mutableCopy;
    [self setUpTableView];
    [self.tblView reloadData];
}

- (void) viewWillAppear:(BOOL)animated  {
    self.sectionTitle.text = viewModel.section.section_name;
    [self reloadTableView];
}

- (void) reloadTableView {
    [self.tblView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tblView reloadData];
    });
}

-(void)designUI{
    self.sectionTitle.textColor  = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.sectionTitle.font = [UIFont DDBoldFont:20];
    [self.btnCross setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icCloseRounded"] forState:UIControlStateNormal];
}

- (void) setUpTableView {
    
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
   NSArray *headerViews = @[DDMerchantOffersSectionTableHFV];
    NSArray *tableCells = @[DDOfferItemTVCell];
    [self.tblView registerHeaderFooterWithNibNames:headerViews forClass:self.class withIdentifiers:headerViews];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
   
    self.tblView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblView.sectionHeaderHeight = 50;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 150.0;
}

- (IBAction)crossAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return offerSections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DDMerchantOfferM *offers = offerSections[section];
    return offers.offers_to_display.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DDMerchantOfferM *offers = offerSections[section];
    DDMerchantOffersTableHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:DDMerchantOffersSectionTableHFV];
    [view setData:offers.section_name];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDMerchantOfferM *offerSection = offerSections[indexPath.section];
    DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
    DDOfferItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDOfferItemTVCell];
    DDMerchantOffersLocalDataM *model = [[DDMerchantOffersLocalDataM alloc] init];
    model.merchant = viewModel.merchant;
    model.selectedOutlet = viewModel.selectedOutlet;
    model.offerSection = offerSection;
    model.offerToDisplay = offersToDisplay;
    [cell setData:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantOfferM *offerSection = offerSections[indexPath.section];
    DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
    DDMerchantOffersLocalDataM *model = [[DDMerchantOffersLocalDataM alloc] init];
    model.merchant = viewModel.merchant;
    model.selectedOutlet = viewModel.selectedOutlet;
    model.offerSection = offerSection;
    model.offerToDisplay = offersToDisplay;
}


@end
