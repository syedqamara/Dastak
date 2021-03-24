//
//  DDMerchantDetailOffersTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDCashlessMerchantDetailOffersTVC.h"
#import "DDCashlessMerchantOffersTableHFV.h"
#import "DDCashlessOfferItemTVC.h"

@interface DDCashlessMerchantDetailOffersTVC () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray <DDMerchantOfferM*> *offerSections;
    DDCashlessMerchantOffersCellViewModel *offersCellViewModel;
}

@end

@implementation DDCashlessMerchantDetailOffersTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    offerSections = [NSMutableArray new];
    [self setUpTableView];
}

- (void) setUpTableView {
    
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    
    NSArray *headerViews = @[CashlessMerchantOffersTableHFV];
    NSArray *tableCells = @[CashlessOfferItemTVC];
    [self.tblView registerHeaderFooterWithNibNames:headerViews forClass:self.class withIdentifiers:headerViews];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
   
    self.tblView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblView.sectionHeaderHeight = 50;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 150.0;
    self.tblView.scrollEnabled = FALSE;
    [self.tblView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
}

-(void)designUI{
}

-(void)setData:(id)data{
    offersCellViewModel = (DDCashlessMerchantOffersCellViewModel*)data;
    DDMerchantDetailSectionM *sectionModel = offersCellViewModel.section;
    offerSections = sectionModel.offers.mutableCopy;
    
    [self updateSuperViewHeight];
    
    [super setData:data];
}


-(void)updateSuperViewHeight {
//    [self.tblView reloadData];
//    [self.tblView layoutIfNeeded];
//    self.tblHeightConstraint.constant = self.tblView.contentSize.height;

    if(!offersCellViewModel.merchant.isExpanded) {
        [self setHidden:YES];
        UITableView *tbl = (UITableView *)self.superview;
        [tbl beginUpdates];
        self.tblHeightConstraint.constant = 2;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [tbl endUpdates];
        return;
    }
    [self setHidden:NO];
    [UIView performWithoutAnimation:^{
        UITableView *tbl = (UITableView *)self.superview;
        [tbl beginUpdates];
        self.tblHeightConstraint.constant = CGFLOAT_MAX;
        [self.tblView reloadData];
        [self.tblView layoutIfNeeded];
        [self layoutIfNeeded];
        self.tblHeightConstraint.constant = self.tblView.contentSize.height;
        [self layoutIfNeeded];
        [tbl endUpdates];
    }];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!offersCellViewModel.merchant.isExpanded) {
        return 0;
    }
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
    DDCashlessMerchantOffersTableHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:CashlessMerchantOffersTableHFV];
    [view setData:offers.section_name];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDMerchantOfferM *offerSection = offerSections[indexPath.section];
    DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
    DDCashlessOfferItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:CashlessOfferItemTVC];
    DDCashlessMerchantOffersCellViewModel *viewModel = [[DDCashlessMerchantOffersCellViewModel alloc] init];
    viewModel.merchant = offersCellViewModel.merchant;
    viewModel.selectedOutlet = offersCellViewModel.selectedOutlet;
    viewModel.offerSection = offerSection;
    viewModel.offerToDisplay = offersToDisplay;
    [cell setData:viewModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTapOfferItem:)]) {
        DDMerchantOfferM *offerSection = offerSections[indexPath.section];
        DDMerchantOfferToDisplay *offersToDisplay = offerSection.offers_to_display[indexPath.row];
        DDCashlessMerchantOffersCellViewModel *viewModel = [[DDCashlessMerchantOffersCellViewModel alloc] init];
        viewModel.merchant = offersCellViewModel.merchant;
        viewModel.selectedOutlet = offersCellViewModel.selectedOutlet;
        viewModel.offerSection = offerSection;
        viewModel.offerToDisplay = offersToDisplay;
        [_delegate didTapOfferItem:viewModel];
    }
}

@end
