//
//  DDCustomiseCell.m
//  The Entertainer
//
//  Created by mac on 4/2/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDCustomiseCell.h"
#import "DDCustomiseOptionCell.h"
#import "DDCustomiseOptionHeaderView.h"

#define HEADER_HEIGHT 50
#define LIGHT_BLACK @"282828"
#define LIGHT_GRAY @"636363"

@interface DDCustomiseCell()<UITableViewDelegate, UITableViewDataSource, DDCustomiseOptionCellDelegate>{
    NSString *cellIdentifier;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;



@end
@implementation DDCustomiseCell


-(UITableView *) getChildTableView{
    return self.tableview;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    cellIdentifier = @"DDCustomiseOptionCell";
    [self.tableview registerCellWithNibNames:@[cellIdentifier] forClass:self.class withIdentifiers:@[cellIdentifier]];
    
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableview.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedSectionHeaderHeight = 70;
    
}

-(void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self.tableview reloadData];
    [self enableDisableOvrlay];
}
-(void)enableDisableOvrlay {
    if (self.cust.show_selection.boolValue == YES) {
        self.viewOverlay.hidden = self.cust.is_selected.boolValue == YES;
    } else {
        self.viewOverlay.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - TableView Delegates & Datasource

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%@",scrollView.contentOffset.y);
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasource.count;
    //return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.datasource objectAtIndex:section] options_items] count];
    //return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDCustomiseOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    DDCashlessCustomizationOptionM *options = [self.datasource objectAtIndex:indexPath.section];
    //[options setAllIDs];
    cell.option = options;
    DDCashlessItemCustomizationOptionItemM *optionItem = [options.options_items objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.allowMultipleSelection = options.allow_multiple_selection.boolValue;
    cell.optionItem = optionItem;
    if (options.allow_multiple_selection.boolValue) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    
    [cell setupData];
    
    //cell.isAddedForCustomisation = [self.product isOptionAlreadySelected:optionItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DDCustomiseOptionHeaderView *headerView = [DDCustomiseOptionHeaderView nibInstanceOfClass:DDCustomiseOptionHeaderView.class];
    
    DDCashlessCustomizationOptionM *options = (DDCashlessCustomizationOptionM *)[self.datasource objectAtIndex:section];
    headerView.titleLable.text = options.title;
    headerView.subTitleLabel.text = options.sub_title;
    
    if (options.selectionMissing.boolValue) {
        headerView.titleLable.textColor = [UIColor redColor];
        headerView.subTitleLabel.textColor = [UIColor redColor];
    } else {
        headerView.titleLable.textColor = [UIColor DDcolorFromHexString:LIGHT_BLACK];
        headerView.subTitleLabel.textColor = [UIColor DDcolorFromHexString:LIGHT_GRAY];
    }
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    DDCashlessCustomizationOptionM *options = (DDCashlessCustomizationOptionM *)[self.datasource objectAtIndex:section];
    if (options.title && ![options.title isEqualToString:@""]) {
        return UITableViewAutomaticDimension;//return HEADER_HEIGHT;
    } else {
        return 10.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)reloadTableView
{
    [self enableDisableOvrlay];
    [self.tableview reloadData];
}
-(void)cellSelectedTheCustomizationOption:(DDCustomiseOption)option withType:(DDCustomiseOption)type atIndexPath:(NSIndexPath *)indexPath withSubItem:(DDCashlessCustomizationOptionM *)subItem isMultipleSelectionAllowed:(BOOL)allowMultipleSelection
{
    [self.tableview reloadData];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    return CGSizeMake(self.tableview.frame.size.width, [self getTableViewContentHeight]);
}

-(CGFloat)getTableViewContentHeight {
    CGFloat headerHeight = [self getAllHeadersHeight];
    CGFloat cellHeight = 0;
    for (DDCashlessCustomizationOptionM *customizeM in self.datasource) {
        cellHeight += (40 * customizeM.options_items.count);
    }
    
    return headerHeight + cellHeight;
}

-(CGFloat) getAllHeadersHeight{
    
    CGFloat height = 0.0;
    for (NSInteger section = 0; section < self.datasource.count; section++) {
        UIView *view = [self tableView:self.tableview viewForHeaderInSection:section];
        if (view != nil) {
            CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
            height += size.height;
        }else {
            height += 10;
        }
        
    }
//    for (DDOrderCustomisationM *customizeM in self.datasource) {
//        if (customizeM.title && ![customizeM.title isEqualToString:@""]){
//            height += self.tableview.sectionHeaderHeight;
//        } else {
//            height += 10;
//        }
//    }
    
    return height;
}

@end
