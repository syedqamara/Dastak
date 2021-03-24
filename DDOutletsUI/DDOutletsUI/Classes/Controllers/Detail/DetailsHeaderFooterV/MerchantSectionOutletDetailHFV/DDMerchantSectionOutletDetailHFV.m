//
//  DDMerchantSectionOutletDetailHFV.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 12/03/2020.
//

#import "DDMerchantSectionOutletDetailHFV.h"
#import "DDOutletsThemeManager.h"
#import "DDOutletsConstants.h"
#import "DDMerchantDetailAttributesTVC.h"

@interface DDMerchantSectionOutletDetailHFV()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray*detailAttributeArray;
}

@end


@implementation DDMerchantSectionOutletDetailHFV

-(void)awakeFromNib {
    [super awakeFromNib];

    [self.tblView registerCellWithNibNames:@[DDMerchantDetailAttributesTableCell] forClass:self.class withIdentifiers:@[DDMerchantDetailAttributesTableCell]];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.estimatedRowHeight = 60.0;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.scrollEnabled = FALSE;
    self.btnReadMore.selected = FALSE;
    self.tblHeightConstraint.constant = 0;
    self.description_Label.numberOfLines = 4;
}

-(void)designUI {
    
    self.title_Label.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title_Label.font = [UIFont DDBoldFont:20];
    self.btnReadMore.titleLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue;
    self.fadeView.backgroundColor = [DDOutletsThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.6];
    [super designUI];
}

-(void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel  = (DDMerchantDetailSectionM*) data;
    self.description_Label.text = sectionModel.detail_desc;
    [self.btnReadMore setTitle:@"Read More".localized forState:UIControlStateNormal];
    [self.btnReadMore setTitle:@"".localized forState:UIControlStateSelected];
    self.title_Label.text = sectionModel.section_name;
    detailAttributeArray = sectionModel.detail_attributes.mutableCopy;
    
    
    if (self.btnReadMore.isSelected) {
        self.tblHeightConstraint.constant = self.tblView.contentSize.height;
        self.btnReadMoreBottomConstraint.constant = 20;
        self.title_Label.numberOfLines = 0;
    }
    else {
        self.tblHeightConstraint.constant = 0;
        self.btnReadMoreBottomConstraint.constant = 2;
        self.title_Label.numberOfLines = 4;
    }
    [self.tblView reloadData];
    [self.tblView layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tblView reloadData];
    });
    [super setData:data];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDMerchantDetailAttributesTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantDetailAttributesTableCell];
    [cell setData:[detailAttributeArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewScrollPositionNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return detailAttributeArray.count;
}
-(IBAction)btnShowMoreAction:(UIButton*)btn{
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(refreshMainTableViewFromOutletDetailSection)]){
           [self.delegate refreshMainTableViewFromOutletDetailSection];
    }
}
@end

