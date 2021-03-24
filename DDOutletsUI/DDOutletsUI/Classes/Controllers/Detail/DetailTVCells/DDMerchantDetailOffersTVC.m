//
//  DDMerchantDetailOffersTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDMerchantDetailOffersTVC.h"
#import "DDOutletsThemeManager.h"
#import "DDMerchantOffersTableHFV.h"
#import "DDOfferItemTVC.h"

@interface DDMerchantDetailOffersTVC () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray <DDMerchantOfferM*> *offerSections;
    DDMerchantOffersLocalDataM *offersCellViewModel;
}

@end

@implementation DDMerchantDetailOffersTVC 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    offerSections = [NSMutableArray new];
    self.tblHeightConstraint.constant = 0;
    [self setUpTableView];
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
    self.tblView.scrollEnabled = FALSE;
}

-(void)designUI{
}

-(void)setData:(id)data{
    offersCellViewModel = (DDMerchantOffersLocalDataM*)data;
    DDMerchantDetailSectionM *sectionModel = offersCellViewModel.section;
    offerSections = sectionModel.offers.mutableCopy;
    
    [self updateSuperViewHeight];
    
    [super setData:data];
}


-(void)updateSuperViewHeight {
    
    [self.tblView reloadData];
    [self.tblView layoutIfNeeded];
    self.tblHeightConstraint.constant = self.tblView.contentSize.height;
    
//    [UIView performWithoutAnimation:^{
//        UITableView *tbl = (UITableView *)self.superview;
//        [tbl beginUpdates];
//        self.tblHeightConstraint.constant = CGFLOAT_MAX;
//        [self.tblView reloadData];
//        [self.tblView layoutIfNeeded];
//        [self layoutIfNeeded];
//        self.tblHeightConstraint.constant = self.tblView.contentSize.height;
//        [self layoutIfNeeded];
//        [tbl endUpdates];
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    DDMerchantOffersLocalDataM *viewModel = [[DDMerchantOffersLocalDataM alloc] init];
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
        DDMerchantOffersLocalDataM *viewModel = [[DDMerchantOffersLocalDataM alloc] init];
        viewModel.merchant = offersCellViewModel.merchant;
        viewModel.selectedOutlet = offersCellViewModel.selectedOutlet;
        viewModel.offerSection = offerSection;
        viewModel.offerToDisplay = offersToDisplay;
        [_delegate didTapOfferItem:viewModel];
    }
}

@end
